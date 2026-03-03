// ============================================================
// CONTRAT D'ÉQUIPE — SOFTBALL QUÉBEC
// Ajouter ce bloc avant la fermeture </script> dans admin.html
// ============================================================

const CONTRAT_EQUIPES = ['Aigles','Condors','Ducs','Faucons','Harfangs','Vautours'];
const CONTRAT_ROLES_JOUEURS = ['joueur','lanceur_a'];
const CONTRAT_ROLES_COACH = ['coach','coachlanceur_a','coachadmin'];
let contratJoueurs = [];

// Init date par défaut
(function(){
    const d = document.getElementById('contratDate');
    if(d) d.value = new Date().getFullYear() + '-06-15';
})();

function contratSplitNom(fullName) {
    const parts = (fullName||'').trim().split(/\s+/);
    if (parts.length <= 1) return { nom: parts[0]||'', prenom: '' };
    return { nom: parts.slice(0,-1).join(' '), prenom: parts[parts.length-1] };
}

function contratShowStatus(msg, type) {
    const el = document.getElementById('contratStatus');
    el.style.display = 'block';
    el.style.borderColor = type==='ok'?'var(--success)':type==='err'?'var(--danger)':'var(--primary)';
    el.style.background = type==='ok'?'#d4edda':type==='err'?'#f8d7da':'#cce5ff';
    el.textContent = msg;
}

async function contratCharger() {
    const saison = document.getElementById('contratSaison').value;
    const equipe = document.getElementById('contratEquipeSelect').value;
    if (!equipe) { contratShowStatus('Choisis une équipe.','err'); return; }

    contratShowStatus('Chargement...','info');
    try {
        const eqRes = await sbFetch(`equipes_saison?select=joueur_nom&saison=eq.${saison}&equipe=eq.${equipe.toUpperCase()}`, { headers: { 'Range': '0-999' } });
        const eqData = eqRes.ok ? await eqRes.json() : [];
        const noms = eqData.map(e => e.joueur_nom.toUpperCase().trim());
        const jRes = await sbFetch(`joueurs_liste?select=*&saison=eq.${saison}&actif=eq.true`, { headers: { 'Range': '0-999' } });
        const joueurs = jRes.ok ? await jRes.json() : [];

        contratJoueurs = noms.map(n => {
            const found = joueurs.find(j => j.nom && j.nom.toUpperCase().trim() === n);
            if (found) return { ...found, equipe };
            return { nom: n, role:'joueur', equipe, ...contratSplitNom(n) };
        });

        contratJoueurs.sort((a,b) => {
            const pa = CONTRAT_ROLES_COACH.includes(a.role)?0:1;
            const pb = CONTRAT_ROLES_COACH.includes(b.role)?0:1;
            return pa-pb;
        });

        contratRenderPreview(equipe);
        document.getElementById('btnContratExport').disabled = false;
        contratShowStatus(`${contratJoueurs.length} joueurs chargés pour ${equipe} (${saison})`,'ok');
    } catch(e) {
        contratShowStatus('Erreur: '+e.message,'err');
    }
}

function contratRenderPreview(equipe) {
    document.getElementById('contratPreviewBox').style.display = 'block';
    const couleurs = {Aigles:'var(--aigles)',Condors:'var(--condors)',Ducs:'var(--ducs)',Faucons:'var(--faucons)',Harfangs:'var(--harfangs)',Vautours:'var(--vautours)'};
    const nbJ = contratJoueurs.filter(j=>CONTRAT_ROLES_JOUEURS.includes(j.role)).length;
    const nbC = contratJoueurs.filter(j=>CONTRAT_ROLES_COACH.includes(j.role)).length;
    document.getElementById('contratPreviewTitle').innerHTML = `👥 <span style="color:${couleurs[equipe]||'#333'}">${equipe}</span> — ${nbJ} joueurs, ${nbC} coachs`;

    const tbody = document.getElementById('contratPreviewBody');
    tbody.innerHTML = '';
    contratJoueurs.forEach((j,i) => {
        const p = j.nom ? contratSplitNom(j.nom) : {nom:'',prenom:''};
        const section = CONTRAT_ROLES_JOUEURS.includes(j.role) ? 'Joueur' : 'Coach';
        const sColor = section==='Coach' ? 'var(--success)' : 'var(--primary)';
        const missing = '<span style="color:#ccc;font-style:italic">—</span>';
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${i+1}</td>
            <td><span style="background:${sColor};color:white;padding:.1rem .4rem;font-size:.7rem;font-family:'Oswald',sans-serif">${section}</span></td>
            <td><strong>${p.nom}</strong></td>
            <td>${p.prenom}</td>
            <td>${j.naissance||missing}</td>
            <td>${j.adresse||missing}</td>
            <td>${j.ville||missing}</td>
            <td>${j.code_postal||missing}</td>
            <td>${j.telephone||j.telephone1||missing}</td>
            <td style="font-size:.75rem">${j.courriel||missing}</td>
        `;
        tbody.appendChild(tr);
    });
}

async function contratExporterExcel() {
    if (!contratJoueurs.length) return;
    const equipe = document.getElementById('contratEquipeSelect').value;
    const saison = document.getElementById('contratSaison').value;
    contratShowStatus('Génération du Excel...','info');
    try {
        const wb = contratGenererWorkbook(equipe, saison, contratJoueurs);
        const buf = await wb.xlsx.writeBuffer();
        saveAs(new Blob([buf],{type:'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'}), `Contrat_equipe_${saison}_${equipe}.xlsx`);
        contratShowStatus(`Contrat ${equipe} ${saison} exporté!`,'ok');
    } catch(e) {
        contratShowStatus('Erreur: '+e.message,'err');
        console.error(e);
    }
}

async function contratExporterToutes() {
    const saison = document.getElementById('contratSaison').value;
    document.getElementById('btnContratToutes').disabled = true;
    contratShowStatus('Export de toutes les équipes...','info');
    try {
        const jRes = await sbFetch(`joueurs_liste?select=*&saison=eq.${saison}&actif=eq.true`, { headers: { 'Range': '0-999' } });
        const joueurs = jRes.ok ? await jRes.json() : [];
        for (const eq of CONTRAT_EQUIPES) {
            contratShowStatus(`Export ${eq}...`,'info');
            const eqRes = await sbFetch(`equipes_saison?select=joueur_nom&saison=eq.${saison}&equipe=eq.${eq.toUpperCase()}`, { headers: { 'Range': '0-999' } });
            const eqData = eqRes.ok ? await eqRes.json() : [];
            const noms = eqData.map(e=>e.joueur_nom.toUpperCase().trim());
            const joueursEq = noms.map(n => {
                const f = joueurs.find(j=>j.nom&&j.nom.toUpperCase().trim()===n);
                return f ? {...f,equipe:eq} : {nom:n,role:'joueur',equipe:eq,...contratSplitNom(n)};
            });
            joueursEq.sort((a,b)=>(CONTRAT_ROLES_COACH.includes(a.role)?0:1)-(CONTRAT_ROLES_COACH.includes(b.role)?0:1));
            const wb = contratGenererWorkbook(eq, saison, joueursEq);
            const buf = await wb.xlsx.writeBuffer();
            saveAs(new Blob([buf],{type:'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'}), `Contrat_equipe_${saison}_${eq}.xlsx`);
            await new Promise(r=>setTimeout(r,500));
        }
        contratShowStatus(`6 contrats exportés pour ${saison}!`,'ok');
    } catch(e) {
        contratShowStatus('Erreur: '+e.message,'err');
    }
    document.getElementById('btnContratToutes').disabled = false;
}

function contratGenererWorkbook(equipe, saison, joueurs) {
    const wb = new ExcelJS.Workbook();
    wb.creator = 'LBMA'; wb.created = new Date();
    const dateVal = document.getElementById('contratDate').value;
    const dateFmt = dateVal ? dateVal.split('-').reverse().join('-') : '';
    const lj = joueurs.filter(j=>CONTRAT_ROLES_JOUEURS.includes(j.role));
    const lc = joueurs.filter(j=>CONTRAT_ROLES_COACH.includes(j.role));

    contratBuildSheet(wb.addWorksheet('Français',{pageSetup:{paperSize:9,orientation:'landscape',fitToPage:true,fitToWidth:1,fitToHeight:1}}), {
        equipe, saison, dateFmt, lj, lc,
        L:{date:'DATE :',discipline:'DISCIPLINE:',disciplineVal:'Balle orthodoxe (softball)',
           sexe:'SEXE:',sexeVal:'Masculin',categorie:'CATÉGORIE:',categorieVal:'OPEN-Senior',
           equipeLabel:'ÉQUIPE :',classe:'CLASSE:',classeVal:'C',
           ligue:'LIGUE:',ligueVal:'LBMA',region:'RÉGION:',regionVal:'Montréal',
           joueurs:'JOUEURS-JOUEUSES',annee:'ANNÉE '+saison,contrat:"CONTRAT D'ÉQUIPE",
           genre:'GENRE',nom:'NOM',prenom:'PRÉNOM',ddn:'DATE DE NAISSANCE\nAAAA-MM-JJ',
           adresse:'ADRESSE',ville:'VILLE',cp:'CODE POSTAL',tel:'TÉLÉPHONE',courriel:'COURRIEL',
           gerant:'GÉRANT / TRÉSORIER',pnce:'# PNCE',entraineurs:'ENTRAÎNEURS',
           obligatoire:"OBLIGATOIRE - Deux cases à cocher par l'entraîneur chef de l'équipe ou gérant",
           consent1:"À titre de responsable de l'équipe et/ou de président de la ligue/association, je confirme que les membres listés sur ce contrat ont acceptés que les données incluses peuvent être utilisées par\nSoftball Québec et ses comités régionaux dans le but de rejoindre ses membres.",
           consent2:"À titre de responsable de l'équipe et/ou président de la ligue/association, je confirme que tous les membres de cette équipe ont reçu la\nPolitique en matière de protection de l'intégrité et ses codes de conduite, en ont pris connaissance et s'engage à la respecter.",
           avis:"VOUS DEVEZ REMETTRE VOTRE CONTRAT D'ÉQUIPE À VOTRE REGISTRAIRE RÉGIONAL AU PLUS TARD LE 15 JUIN.\nSi vous désirez modifier votre contrat entre le 15 et 30 juin, vous devez contacter votre registraire régional afin de l'informer.",
           registraire:"Espace réservé au régistraire: NE PAS TRANSFORMER CE CONTRAT EN FORMAT PDF\nUne fois les données complétées et validées, vous devez entrer votre nom, la date, et ensuite cocher le bouton \"Approuvé\".",
           nomReg:'Nom du régistraire',dateLabel:'Date',approuve:'  Approuvé: ',dateDernier:'Date dernière approbation:'}
    });

    contratBuildSheet(wb.addWorksheet('English',{pageSetup:{paperSize:9,orientation:'landscape',fitToPage:true,fitToWidth:1,fitToHeight:1}}), {
        equipe, saison, dateFmt, lj, lc,
        L:{date:'DATE :',discipline:'SOFTBALL TYPE:',disciplineVal:'Balle orthodoxe (softball)',
           sexe:'GENDER:',sexeVal:'Masculin',categorie:'CATEGORY:',categorieVal:'OPEN-Senior',
           equipeLabel:'TEAM:',classe:'CLASS:',classeVal:'C',
           ligue:'LEAGUE:',ligueVal:'LBMA',region:'REGION:',regionVal:'Montréal',
           joueurs:'PLAYERS',annee:saison+' season',contrat:'TEAM CONTRACT',
           genre:'GENDER',nom:'LAST NAME',prenom:'FIRST NAME',ddn:'DATE OF BIRTH\nYYYY-MM-DD',
           adresse:'ADDRESS',ville:'CITY',cp:'POSTAL CODE',tel:'PHONE',courriel:'EMAIL',
           gerant:'MANAGERS',pnce:'NCCP NUMBER',entraineurs:'COACHES',
           obligatoire:'MANDATORY - The two boxes below must be checked by the head coach or the manager',
           consent1:'As team responsible and/or league/association president, I confirm that the members listed on this contract have agreed that the data included may be used by Softball Québec and its regional committees in order to reach its members.',
           consent2:'As team responsible and/or league/association president, I confirm that all members of this team have received the Integrity protection policy and its codes of conduct, have taken notice and commit to respecting them.',
           avis:"TEAMS MUST RETURN THEIR TEAM CONTRACT TO THE REGIONAL REGISTRAR NO LATER THAN JUNE 15TH.",
           registraire:"SPACE RESERVED FOR THE REGISTRAR: DO NOT TRANSFORM THIS CONTRACT INTO A PDF FORMAT",
           nomReg:"Registrar's name:",dateLabel:'Date',approuve:'  Approved: ',dateDernier:'Date of latest approval:'}
    });

    return wb;
}

function contratBuildSheet(ws, opts) {
    const {L, equipe, saison, dateFmt, lj, lc} = opts;
    const f10 = {name:'Arial',size:10};
    const f10b = {name:'Arial',size:10,bold:true};
    const f9b = {name:'Arial',size:9,bold:true};
    const f12b = {name:'Arial',size:12,bold:true};
    const ctr = {horizontal:'center',vertical:'middle'};
    const lft = {horizontal:'left',vertical:'middle',wrapText:true};
    const bdr = {top:{style:'thin'},bottom:{style:'thin'},left:{style:'thin'},right:{style:'thin'}};
    // Couleurs de fond du formulaire officiel
    const fillGrey = {type:'pattern',pattern:'solid',fgColor:{argb:'FFD9D9D9'}}; // gris clair (en-têtes colonnes, #col)
    const fillYellowBright = {type:'pattern',pattern:'solid',fgColor:{argb:'FFFFFF00'}}; // jaune vif (CONTRAT D'ÉQUIPE, consent1)
    const fillGold = {type:'pattern',pattern:'solid',fgColor:{argb:'FFFFC000'}}; // or/ambre (ANNÉE, consent2)
    const fillRed = {type:'pattern',pattern:'solid',fgColor:{argb:'FFFF0000'}}; // rouge (OBLIGATOIRE)
    const fillLightGrey = {type:'pattern',pattern:'solid',fgColor:{argb:'FFEEECE1'}}; // gris chaud (registraire)

    // Largeurs colonnes
    [3,10.3,21,22.6,19.4,11.7,27.6,20.9,16.7,16.7,15.9,16.3].forEach((w,i)=>ws.getColumn(i+1).width=w);

    // EN-TÊTE (rows 1-7)
    ws.getCell('D1').value='7665, boulevard Lacordaire'; ws.getCell('D1').font=f10;
    ws.getCell('D2').value='Montréal (Québec) H1S 2A7'; ws.getCell('D2').font=f10;
    ws.getCell('D3').value='Tél.: (514) 252-3061'; ws.getCell('D3').font=f10;
    ws.getCell('D4').value='Courriel : cgagnon@loisirquebec.qc.ca'; ws.getCell('D4').font=f10;
    ws.getCell('D6').value='Site internet : www.softballquebec.com'; ws.getCell('D6').font=f10b;

    ws.getCell('F1').value=L.date; ws.getCell('F1').font=f10b; ws.getCell('F1').fill=fillGrey;
    ws.getCell('G1').value=dateFmt; ws.getCell('G1').font=f10; ws.getCell('G1').alignment=ctr;
    ws.getCell('H1').value=L.discipline; ws.getCell('H1').font=f10b; ws.getCell('H1').fill=fillGrey;
    ws.mergeCells('I1:J1'); ws.getCell('I1').value=L.disciplineVal; ws.getCell('I1').font=f10; ws.getCell('I1').alignment=ctr;

    ws.mergeCells('F2:F3'); ws.getCell('F2').value=L.sexe; ws.getCell('F2').font=f10b; ws.getCell('F2').fill=fillGrey;
    ws.mergeCells('G2:G3'); ws.getCell('G2').value=L.sexeVal; ws.getCell('G2').font=f10; ws.getCell('G2').alignment=ctr;
    ws.mergeCells('H2:H3'); ws.getCell('H2').value=L.categorie; ws.getCell('H2').font=f10b; ws.getCell('H2').fill=fillGrey;
    ws.mergeCells('I2:J3'); ws.getCell('I2').value=L.categorieVal; ws.getCell('I2').font=f10; ws.getCell('I2').alignment=ctr;

    ws.mergeCells('F4:F5'); ws.getCell('F4').value=L.equipeLabel; ws.getCell('F4').font=f10b; ws.getCell('F4').fill=fillGrey;
    ws.mergeCells('G4:G5'); ws.getCell('G4').value=equipe; ws.getCell('G4').font=f10; ws.getCell('G4').alignment=ctr;
    ws.mergeCells('H4:H5'); ws.getCell('H4').value=L.classe; ws.getCell('H4').font=f10b; ws.getCell('H4').fill=fillGrey;
    ws.mergeCells('I4:J5'); ws.getCell('I4').value=L.classeVal; ws.getCell('I4').font=f10; ws.getCell('I4').alignment=ctr;

    ws.mergeCells('F6:F7'); ws.getCell('F6').value=L.ligue; ws.getCell('F6').font=f10b; ws.getCell('F6').fill=fillGrey;
    ws.mergeCells('G6:G7'); ws.getCell('G6').value=L.ligueVal; ws.getCell('G6').font=f10; ws.getCell('G6').alignment=ctr;
    ws.mergeCells('H6:H7'); ws.getCell('H6').value=L.region; ws.getCell('H6').font=f10b; ws.getCell('H6').fill=fillGrey;
    ws.mergeCells('I6:J7'); ws.getCell('I6').value=L.regionVal; ws.getCell('I6').font=f10; ws.getCell('I6').alignment=ctr;

    ws.mergeCells('K1:L7');
    ws.getCell('K1').value='Softball\nQuébec'; ws.getCell('K1').font={name:'Arial',size:14,bold:true,color:{argb:'FF888888'}}; ws.getCell('K1').alignment={...ctr,wrapText:true};

    ws.getRow(1).height=25.5;
    for(let r=2;r<=7;r++) ws.getRow(r).height=12.75;

    // ROW 8 — Titres section
    ws.getRow(8).height=18.95;
    ws.mergeCells('A8:C8'); ws.getCell('A8').value=L.joueurs; ws.getCell('A8').font=f10b; ws.getCell('A8').alignment={horizontal:'left',vertical:'middle'};
    ws.mergeCells('D8:E8'); ws.getCell('D8').value=L.annee; ws.getCell('D8').font=f10b; ws.getCell('D8').alignment=ctr; ws.getCell('D8').fill=fillGold;
    ws.mergeCells('F8:J8'); ws.getCell('F8').value=L.contrat; ws.getCell('F8').font=f10b; ws.getCell('F8').alignment=ctr; ws.getCell('F8').fill=fillYellowBright;

    // ROW 9 — En-têtes colonnes joueurs
    ws.getRow(9).height=45.75;
    [{c:'A',v:'#'},{c:'B',v:L.genre},{c:'C',v:L.nom},{c:'D',v:L.prenom},{c:'E',v:L.ddn},{c:'H',v:L.ville},{c:'I',v:L.cp},{c:'J',v:L.tel}].forEach(h=>{
        const cell=ws.getCell(h.c+'9'); cell.value=h.v; cell.font=f10b; cell.alignment={...ctr,wrapText:true}; cell.border=bdr; cell.fill=fillGrey;
    });
    ws.mergeCells('F9:G9'); ws.getCell('F9').value=L.adresse; ws.getCell('F9').font=f10b; ws.getCell('F9').alignment={...ctr,wrapText:true}; ws.getCell('F9').border=bdr; ws.getCell('F9').fill=fillGrey;
    ws.mergeCells('K9:L9'); ws.getCell('K9').value=L.courriel; ws.getCell('K9').font=f10b; ws.getCell('K9').alignment={...ctr,wrapText:true}; ws.getCell('K9').border=bdr; ws.getCell('K9').fill=fillGrey;

    // ROWS 10-26 — Joueurs (17 max)
    for(let i=0;i<17;i++){
        const row=10+i; ws.getRow(row).height=18.95;
        const j=i<lj.length?lj[i]:null;
        const p=j?contratSplitNom(j.nom):{nom:'',prenom:''};
        ws.getCell('A'+row).value=i+1; ws.getCell('A'+row).font=f10; ws.getCell('A'+row).alignment=ctr; ws.getCell('A'+row).fill=fillGrey;
        ws.getCell('B'+row).value=j?'Homme':''; ws.getCell('B'+row).font=f10; ws.getCell('B'+row).alignment=ctr;
        ws.getCell('C'+row).value=p.nom; ws.getCell('C'+row).font=f10; ws.getCell('C'+row).alignment=ctr;
        ws.getCell('D'+row).value=p.prenom; ws.getCell('D'+row).font=f10; ws.getCell('D'+row).alignment=ctr;
        ws.getCell('E'+row).value=j?(j.naissance||''):''; ws.getCell('E'+row).font=f10; ws.getCell('E'+row).alignment=ctr;
        ws.getCell('H'+row).value=j?(j.ville||''):''; ws.getCell('H'+row).font=f10; ws.getCell('H'+row).alignment=ctr;
        ws.getCell('I'+row).value=j?(j.code_postal||''):''; ws.getCell('I'+row).font=f10; ws.getCell('I'+row).alignment=ctr;
        ws.getCell('J'+row).value=j?(j.telephone||j.telephone1||''):''; ws.getCell('J'+row).font=f10; ws.getCell('J'+row).alignment=ctr;
        ws.mergeCells(`F${row}:G${row}`);
        ws.getCell('F'+row).value=j?(j.adresse||''):''; ws.getCell('F'+row).font=f10; ws.getCell('F'+row).alignment=ctr;
        ws.mergeCells(`K${row}:L${row}`);
        ws.getCell('K'+row).value=j?(j.courriel||''):''; ws.getCell('K'+row).font=f10; ws.getCell('K'+row).alignment=ctr;
        ['A','B','C','D','E','F','H','I','J','K'].forEach(c=>{ws.getCell(c+row).border=bdr;});
    }

    // ROW 27 — GÉRANT
    ws.getRow(27).height=18.95;
    ws.mergeCells('A27:C27'); ws.getCell('A27').value=L.gerant; ws.getCell('A27').font=f10b; ws.getCell('A27').alignment={horizontal:'left',vertical:'middle'};

    // ROW 28 — En-têtes gérant
    ws.getRow(28).height=21;
    [{c:'B',v:L.genre},{c:'C',v:L.nom},{c:'D',v:L.prenom},{c:'E',v:L.pnce},{c:'H',v:L.ville},{c:'I',v:L.cp},{c:'J',v:L.tel}].forEach(h=>{
        const cell=ws.getCell(h.c+'28'); cell.value=h.v; cell.font=f10b; cell.alignment={...ctr,wrapText:true}; cell.border=bdr; cell.fill=fillGrey;
    });
    ws.mergeCells('F28:G28'); ws.getCell('F28').value=L.adresse; ws.getCell('F28').font=f10b; ws.getCell('F28').alignment=ctr; ws.getCell('F28').border=bdr; ws.getCell('F28').fill=fillGrey;
    ws.mergeCells('K28:L28'); ws.getCell('K28').value=L.courriel; ws.getCell('K28').font=f10b; ws.getCell('K28').alignment=ctr; ws.getCell('K28').border=bdr; ws.getCell('K28').fill=fillGrey;

    // ROWS 29-30 — Gérant (vide)
    for(let i=0;i<2;i++){
        const row=29+i; ws.getRow(row).height=18.95;
        ws.getCell('A'+row).value=i+1; ws.getCell('A'+row).font=f10; ws.getCell('A'+row).alignment=ctr; ws.getCell('A'+row).fill=fillGrey;
        ws.mergeCells(`F${row}:G${row}`); ws.mergeCells(`K${row}:L${row}`);
        ['A','B','C','D','E','F','H','I','J','K'].forEach(c=>{ws.getCell(c+row).border=bdr;});
    }

    // ROW 31 — ENTRAÎNEURS
    ws.getRow(31).height=18.95;
    ws.mergeCells('A31:C31'); ws.getCell('A31').value=L.entraineurs; ws.getCell('A31').font=f10b; ws.getCell('A31').alignment={horizontal:'left',vertical:'middle'};

    // ROW 32 — En-têtes coach
    ws.getRow(32).height=20.45;
    [{c:'B',v:L.genre},{c:'C',v:L.nom},{c:'D',v:L.prenom},{c:'E',v:L.pnce},{c:'H',v:L.ville},{c:'I',v:L.cp},{c:'J',v:L.tel}].forEach(h=>{
        const cell=ws.getCell(h.c+'32'); cell.value=h.v; cell.font=f10b; cell.alignment={...ctr,wrapText:true}; cell.border=bdr; cell.fill=fillGrey;
    });
    ws.mergeCells('F32:G32'); ws.getCell('F32').value=L.adresse; ws.getCell('F32').font=f10b; ws.getCell('F32').alignment=ctr; ws.getCell('F32').border=bdr; ws.getCell('F32').fill=fillGrey;
    ws.mergeCells('K32:L32'); ws.getCell('K32').value=L.courriel; ws.getCell('K32').font=f10b; ws.getCell('K32').alignment=ctr; ws.getCell('K32').border=bdr; ws.getCell('K32').fill=fillGrey;

    // ROWS 33-37 — Coachs (5 max)
    for(let i=0;i<5;i++){
        const row=33+i; ws.getRow(row).height=18.95;
        const j=i<lc.length?lc[i]:null;
        const p=j?contratSplitNom(j.nom):{nom:'',prenom:''};
        ws.getCell('A'+row).value=i+1; ws.getCell('A'+row).font=f10; ws.getCell('A'+row).alignment=ctr; ws.getCell('A'+row).fill=fillGrey;
        ws.getCell('B'+row).value=j?'Homme':''; ws.getCell('B'+row).font=f10; ws.getCell('B'+row).alignment=ctr;
        ws.getCell('C'+row).value=p.nom; ws.getCell('C'+row).font=f10; ws.getCell('C'+row).alignment=ctr;
        ws.getCell('D'+row).value=p.prenom; ws.getCell('D'+row).font=f10; ws.getCell('D'+row).alignment=ctr;
        ws.getCell('E'+row).value=''; ws.getCell('E'+row).font=f10; ws.getCell('E'+row).alignment=ctr;
        ws.getCell('H'+row).value=j?(j.ville||''):''; ws.getCell('H'+row).font=f10; ws.getCell('H'+row).alignment=ctr;
        ws.getCell('I'+row).value=j?(j.code_postal||''):''; ws.getCell('I'+row).font=f10; ws.getCell('I'+row).alignment=ctr;
        ws.getCell('J'+row).value=j?(j.telephone||j.telephone1||''):''; ws.getCell('J'+row).font=f10; ws.getCell('J'+row).alignment=ctr;
        ws.mergeCells(`F${row}:G${row}`);
        ws.getCell('F'+row).value=j?(j.adresse||''):''; ws.getCell('F'+row).font=f10; ws.getCell('F'+row).alignment=ctr;
        ws.mergeCells(`K${row}:L${row}`);
        ws.getCell('K'+row).value=j?(j.courriel||''):''; ws.getCell('K'+row).font=f10; ws.getCell('K'+row).alignment=ctr;
        ['A','B','C','D','E','F','H','I','J','K'].forEach(c=>{ws.getCell(c+row).border=bdr;});
    }

    // ROWS 38-43 — Sections légales
    ws.getRow(38).height=22.15; ws.mergeCells('A38:L38'); ws.getCell('A38').value=L.obligatoire; ws.getCell('A38').font={name:'Arial',size:10,bold:true,color:{argb:'FFFFFFFF'}}; ws.getCell('A38').alignment={...ctr}; ws.getCell('A38').fill=fillRed;
    ws.getRow(39).height=24; ws.mergeCells('C39:L39'); ws.getCell('C39').value=L.consent1; ws.getCell('C39').font=f9b; ws.getCell('C39').alignment=lft; ws.getCell('A39').fill=fillYellowBright; ws.getCell('B39').fill=fillYellowBright; ws.getCell('C39').fill=fillYellowBright;
    ws.getRow(40).height=24; ws.mergeCells('C40:L40'); ws.getCell('C40').value=L.consent2; ws.getCell('C40').font=f9b; ws.getCell('C40').alignment=lft; ws.getCell('A40').fill=fillGold; ws.getCell('B40').fill=fillGold; ws.getCell('C40').fill=fillGold;
    ws.getRow(41).height=34.9; ws.mergeCells('A41:L41'); ws.getCell('A41').value=L.avis; ws.getCell('A41').font=f9b; ws.getCell('A41').alignment=lft;
    ws.getRow(42).height=40.9; ws.mergeCells('A42:L42'); ws.getCell('A42').value=L.registraire; ws.getCell('A42').font=f9b; ws.getCell('A42').alignment=lft; ws.getCell('A42').fill=fillLightGrey;

    ws.getRow(43).height=24.6;
    ws.mergeCells('A43:C43'); ws.getCell('A43').value=L.nomReg; ws.getCell('A43').font=f12b; ws.getCell('A43').alignment=ctr; ws.getCell('A43').fill=fillGrey;
    ws.getCell('E43').value=L.dateLabel; ws.getCell('E43').font=f12b; ws.getCell('E43').fill=fillGrey;
    ws.mergeCells('F43:G43');
    ws.getCell('H43').value=L.approuve; ws.getCell('H43').font=f12b; ws.getCell('H43').fill=fillGrey;
    ws.mergeCells('I43:J43'); ws.getCell('I43').value=L.dateDernier; ws.getCell('I43').font=f12b; ws.getCell('I43').alignment=ctr; ws.getCell('I43').fill=fillGrey;
    ws.mergeCells('K43:L43');

    ws.pageSetup.printArea='A1:L43';
}
