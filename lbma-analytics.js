// ============================================================
// lbma-analytics.js — Google Analytics + Consentement Loi 25
// Ajouter sur chaque page: <script src="lbma-analytics.js"></script>
// ============================================================

(function() {
    var GA_ID = 'G-6ERJEBXPZW';
    var SB = 'https://xgyskiatppgaeaamjhxr.supabase.co/rest/v1/visites';
    var SK = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhneXNraWF0cHBnYWVhYW1qaHhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA0OTgxNTQsImV4cCI6MjA4NjA3NDE1NH0.67KCcUWlJij-scDoCUvZpkiCle5-mHVmy-inRk96Tac';
    var STORAGE_KEY = 'lbma_cookies_consent';

    // --- Activer Google Analytics ---
    function activerGA() {
        var s = document.createElement('script');
        s.async = true;
        s.src = 'https://www.googletagmanager.com/gtag/js?id=' + GA_ID;
        document.head.appendChild(s);
        window.dataLayer = window.dataLayer || [];
        function gtag(){ dataLayer.push(arguments); }
        window.gtag = gtag;
        gtag('js', new Date());
        gtag('config', GA_ID);
    }

    // --- Tracker Supabase (interne, pas de consentement requis) ---
    function trackerVisite() {
        try {
            fetch(SB, {
                method: 'POST',
                headers: {
                    'apikey': SK,
                    'Authorization': 'Bearer ' + SK,
                    'Content-Type': 'application/json',
                    'Prefer': 'return=minimal'
                },
                body: JSON.stringify({
                    page: location.pathname.split('/').pop() || 'index.html',
                    referrer: document.referrer || null,
                    user_agent: navigator.userAgent.substring(0, 200),
                    screen_width: screen.width
                })
            });
        } catch(e) {}
    }

    // --- Banniere de consentement ---
    function afficherBanniere() {
        var banniere = document.createElement('div');
        banniere.id = 'lbma-cookie-banner';
        banniere.style.cssText = [
            'position:fixed',
            'bottom:0',
            'left:0',
            'right:0',
            'background:#1a2a4a',
            'color:#fff',
            'padding:14px 20px',
            'display:flex',
            'align-items:center',
            'justify-content:space-between',
            'flex-wrap:wrap',
            'gap:12px',
            'z-index:99999',
            'font-family:Arial,sans-serif',
            'font-size:0.85rem',
            'box-shadow:0 -2px 8px rgba(0,0,0,0.3)'
        ].join(';');

        var texte = document.createElement('span');
        texte.textContent = 'Ce site utilise Google Analytics pour mesurer l\'achalandage. Acceptez-vous les cookies de suivi?';
        texte.style.cssText = 'flex:1;min-width:200px;';

        var lienInfo = document.createElement('a');
        lienInfo.href = '/confidentialite.html';
        lienInfo.textContent = 'En savoir plus';
        lienInfo.style.cssText = 'color:#aac4ff;font-size:0.8rem;white-space:nowrap;';

        var boutons = document.createElement('div');
        boutons.style.cssText = 'display:flex;gap:10px;flex-shrink:0;';

        var btnRefuser = document.createElement('button');
        btnRefuser.textContent = 'Refuser';
        btnRefuser.style.cssText = [
            'background:transparent',
            'color:#ccc',
            'border:1px solid #ccc',
            'padding:8px 18px',
            'border-radius:4px',
            'cursor:pointer',
            'font-size:0.85rem'
        ].join(';');

        var btnAccepter = document.createElement('button');
        btnAccepter.textContent = 'Accepter';
        btnAccepter.style.cssText = [
            'background:#e8a020',
            'color:#fff',
            'border:none',
            'padding:8px 18px',
            'border-radius:4px',
            'cursor:pointer',
            'font-size:0.85rem',
            'font-weight:bold'
        ].join(';');

        btnAccepter.addEventListener('click', function() {
            localStorage.setItem(STORAGE_KEY, 'accepte');
            banniere.remove();
            activerGA();
        });

        btnRefuser.addEventListener('click', function() {
            localStorage.setItem(STORAGE_KEY, 'refuse');
            banniere.remove();
        });

        boutons.appendChild(btnRefuser);
        boutons.appendChild(btnAccepter);
        banniere.appendChild(texte);
        banniere.appendChild(lienInfo);
        banniere.appendChild(boutons);
        document.body.appendChild(banniere);
    }

    // --- Lien confidentialite dans le footer ---
    function ajouterLienFooter() {
        var fb = document.querySelector('.footer-bottom');
        if (!fb) return;
        // Eviter les doublons si le script est charge deux fois
        if (fb.querySelector('a[href="/confidentialite.html"]')) return;
        var sep = document.createTextNode(' \u00B7 ');
        var a = document.createElement('a');
        a.href = '/confidentialite.html';
        a.textContent = 'Politique de confidentialit\u00E9';
        a.style.color = 'inherit';
        a.style.textDecoration = 'underline';
        fb.appendChild(sep);
        fb.appendChild(a);
    }

    // --- Logique principale ---
    function init() {
        trackerVisite();
        ajouterLienFooter();

        var consentement = localStorage.getItem(STORAGE_KEY);
        if (consentement === 'accepte') {
            activerGA();
        } else if (consentement === 'refuse') {
            // GA desactive
        } else {
            afficherBanniere();
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();
