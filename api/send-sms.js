// api/send-sms.js — VERSION PRODUCTION
export default async function handler(req, res) {
    if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

    const { message } = req.body;
    if (!message || !message.trim()) return res.status(400).json({ error: 'Message requis' });

    const PREFIX = 'Un message de l exécutif de la LBMA:\n';
    const messageComplet = PREFIX + message.trim();

    const SB_URL = process.env.SUPABASE_URL;
    const SB_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
    const SID    = process.env.TWILIO_ACCOUNT_SID;
    const TOKEN  = process.env.TWILIO_AUTH_TOKEN;
    const FROM   = process.env.TWILIO_FROM;

    // Vérification détaillée des variables manquantes
    const manquantes = [];
    if (!SB_URL)  manquantes.push('SUPABASE_URL');
    if (!SB_KEY)  manquantes.push('SUPABASE_SERVICE_ROLE_KEY');
    if (!SID)     manquantes.push('TWILIO_ACCOUNT_SID');
    if (!TOKEN)   manquantes.push('TWILIO_AUTH_TOKEN');
    if (!FROM)    manquantes.push('TWILIO_FROM');
    if (manquantes.length > 0) {
        console.error('Variables manquantes:', manquantes.join(', '));
        return res.status(500).json({ error: 'Variables manquantes: ' + manquantes.join(', ') });
    }

    // Charger les joueurs 2026 avec un numéro de téléphone
    const saison = new Date().getFullYear();
    const sbUrl = `${SB_URL}/rest/v1/joueurs_liste?saison=eq.${saison}&or=(actif.eq.true,actif.is.null)&telephone1=not.is.null&select=nom,telephone1`;
    console.log('Supabase URL:', sbUrl);

    const sbRes = await fetch(sbUrl, {
        headers: {
            'apikey': SB_KEY,
            'Authorization': 'Bearer ' + SB_KEY,
            'Range': '0-9999'
        }
    });

    if (!sbRes.ok) {
        const errText = await sbRes.text();
        console.error('Supabase erreur:', sbRes.status, errText);
        return res.status(500).json({ error: 'Erreur chargement joueurs: ' + sbRes.status + ' — ' + errText });
    }

    const joueurs = await sbRes.json();
    console.log('Joueurs trouvés:', joueurs.length);

    // Normaliser les numéros (format E.164 canadien)
    function normaliserTel(tel) {
        if (!tel) return null;
        var digits = tel.replace(/\D/g, '');
        if (digits.length === 10) return '+1' + digits;
        if (digits.length === 11 && digits[0] === '1') return '+' + digits;
        return null;
    }

    const valides = joueurs
        .map(j => ({ ...j, tel: normaliserTel(j.telephone1) }))
        .filter(j => j.tel !== null);

    console.log('Numéros valides:', valides.length);

    if (!valides.length) return res.status(200).json({ succes: true, envoyes: 0, erreurs: 0, message: 'Aucun numéro valide trouvé' });

    const credentials = Buffer.from(`${SID}:${TOKEN}`).toString('base64');
    const url = `https://api.twilio.com/2010-04-01/Accounts/${SID}/Messages.json`;

    let envoyes = 0, erreurs = 0, details = [];

    for (const j of valides) {
        const nomAff = j.nom || 'Joueur';
        try {
            const r = await fetch(url, {
                method: 'POST',
                headers: {
                    'Authorization': 'Basic ' + credentials,
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    From: FROM,
                    To:   j.tel,
                    Body: messageComplet
                }).toString()
            });
            const data = await r.json();
            if (r.ok && data.sid) {
                envoyes++;
                details.push({ nom: nomAff, tel: j.tel, statut: 'ok' });
            } else {
                erreurs++;
                console.error('Twilio erreur pour', nomAff, ':', data.message);
                details.push({ nom: nomAff, tel: j.tel, statut: 'erreur', raison: data.message || 'Inconnu' });
            }
        } catch (e) {
            erreurs++;
            details.push({ nom: nomAff, tel: j.tel, statut: 'erreur', raison: e.message });
        }
        await new Promise(r => setTimeout(r, 100));
    }

    return res.status(200).json({ succes: true, envoyes, erreurs, total: valides.length, details });
}
