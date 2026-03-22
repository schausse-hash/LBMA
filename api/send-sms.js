// api/send-sms.js — MODE TEST (1 seul numéro)
export default async function handler(req, res) {
    if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

    const { message } = req.body;
    if (!message || !message.trim()) return res.status(400).json({ error: 'Message requis' });

    const PREFIX = 'LBMA - Michel Plante :\n';
    const messageComplet = PREFIX + message.trim();

    const SID   = process.env.TWILIO_ACCOUNT_SID;
    const TOKEN = process.env.TWILIO_AUTH_TOKEN;
    const FROM  = process.env.TWILIO_FROM;

    if (!SID || !TOKEN || !FROM) {
        return res.status(500).json({ error: 'Variables Twilio manquantes' });
    }

    // ⚠️ MODE TEST — envoie seulement à ce numéro
    const valides = [
        { nom: 'Chaussé', prenom: 'Serge', tel: '+15149533381' }
    ];

    const credentials = Buffer.from(`${SID}:${TOKEN}`).toString('base64');
    const url = `https://api.twilio.com/2010-04-01/Accounts/${SID}/Messages.json`;

    let envoyes = 0, erreurs = 0, details = [];

    for (const j of valides) {
        const nomAff = `${j.prenom || ''} ${j.nom || ''}`.trim();
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
