/* ============================================
   LBMA Analytics — lbma-analytics.js
   Ajouter sur chaque page: <script src="lbma-analytics.js"></script>
   ============================================ */

// Google Analytics (G-6ERJEBXPZW)
var s=document.createElement('script');s.async=true;s.src='https://www.googletagmanager.com/gtag/js?id=G-6ERJEBXPZW';document.head.appendChild(s);
window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments)}
gtag('js',new Date());gtag('config','G-6ERJEBXPZW');

// Supabase Tracking
(function(){
    var SB='https://xgyskiatppgaeaamjhxr.supabase.co/rest/v1/visites';
    var SK='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhneXNraWF0cHBnYWVhYW1qaHhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA0OTgxNTQsImV4cCI6MjA4NjA3NDE1NH0.67KCcUWlJij-scDoCUvZpkiCle5-mHVmy-inRk96Tac';
    try{
        fetch(SB,{
            method:'POST',
            headers:{'apikey':SK,'Authorization':'Bearer '+SK,'Content-Type':'application/json','Prefer':'return=minimal'},
            body:JSON.stringify({
                page:location.pathname.split('/').pop()||'index.html',
                referrer:document.referrer||null,
                user_agent:navigator.userAgent.substring(0,200),
                screen_width:screen.width
            })
        });
    }catch(e){}
})();
