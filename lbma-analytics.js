// ============================================================
// lbma-analytics.js — Google Analytics + Consentement Loi 25
// ============================================================

(function() {
    var GA_ID = 'G-6ERJEBXPZW';
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

    // --- Afficher la bannière ---
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
        texte.style.flex = '1';
        texte.style.minWidth = '200px';

        var boutons = document.createElement('div');
        boutons.style.cssText = 'display:flex;gap:10px;flex-shrink:0;';

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

        var lienInfo = document.createElement('a');
        lienInfo.href = '/confidentialite.html';
        lienInfo.textContent = 'En savoir plus';
        lienInfo.style.cssText = 'color:#aac4ff;font-size:0.8rem;white-space:nowrap;';

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

    // --- Logique principale ---
    function init() {
        var consentement = localStorage.getItem(STORAGE_KEY);
        if (consentement === 'accepte') {
            activerGA();
        } else if (consentement === 'refuse') {
            // rien — GA désactivé
        } else {
            // Pas encore de choix — afficher la bannière
            afficherBanniere();
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();
