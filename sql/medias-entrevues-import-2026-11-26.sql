-- =====================================================================
-- LBMA — Import des 55 entrevues de Jean-Christian Dionne
-- Fichier : sql/medias-entrevues-import-2026-11-26.sql   (ÉTAPE 2 sur 2)
-- =====================================================================
-- Ce que ça fait :
--   Copie dans public.medias_entrevues les 55 entrevues publiées
--   aujourd'hui sous medias/entrevues-dionne/ (49 joueurs actuels,
--   6 légendes) : nom, catégorie, sous-titre et texte de l'entrevue.
--   Le texte vient tel quel des pages du site (déjà publiques), sans
--   les balises <span> de mise en page. Aucune donnée personnelle.
--   Généré automatiquement à partir des fichiers HTML du dépôt.
--
-- Prérequis : l'étape 1 (sql/medias-entrevues-2026-11-26.sql).
-- Sans risque : table neuve ; « on conflict do nothing » saute une
-- entrevue déjà présente, donc relancer le fichier ne double rien.
-- Les anciennes pages HTML restent en place (rien n'est supprimé).
--
-- Retour en arrière (destructif : seulement avec le « go » de Sergio) :
--   delete from public.medias_entrevues where slug in (<les 55 slugs ci-dessous>);
--
-- Vérification après (lancer à part) :
--   select categorie, count(*) from public.medias_entrevues group by categorie;
--   -- attendu : actuel 49, legende 6
-- =====================================================================

begin;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('eric-collard', 'Éric Collard', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec Eric Collard</h2>
<p>Tout le monde me parlais de (smilley), tu vas le reconnaitre sur le terrain… wow pas juste pour son sourire, quel joueur !!</p>
<p>Et voici M. Éric Collard;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Je suis arrivé dans le LBMA à l’été 2005. C’était mon premier été à Montréal, je ne connaissais pas un joueur de balle en ville mais je me suis dit, ce n’est pas vrai que je ne vais pas jouer à la balle cette été. J’ai donc trouvé le site de la LBMA et contacté Michel Plante. Je pense être le premier joueur « non-référé » de la LBMA, et j’ai eu droit à un essai, en remplacement de Doug Wilson, qui n’était pas reconnu pour son coup de bâton. C’était un samedi matin et Michel m’avait dit que l’exécutif allait me regarder pour voir si j’étais du calibre à Doug. Je connaissais les capacités offensives limitées de Doug et malgré ça, à ma dernière présence, j’ai frappé un circuit… J’étais certain que je n’allais pas être retenu et c’est là que Michel est venu me voir pour me dire, « Tu m’amèneras ton chèque la semaine prochaine! » Je suis pas mal sûr que Denis Charbonneau et André Dandurand avaient eu de bons mots à mon endroit!</p>
<p class="question">2.Raconte-nous ton parcours de balle au travers des années ?</p>
<p>De 4 à 14 ans, je jouais dans la ligue de baseball plus ou moins bien organisée de ma Ville natale en Abitibi, coaché par les amis à mon frère. Ce n’était donc pas la grosse affaire, mais on était un bon groupe de jeune. J’étais le receveur de la gang! À 15 ans, l’équipe AA de Rouyn nous a appelée en début d’année pour jouer une partie hors-concours parce qu’ils avaient besoin de joueurs. On y est allés, on les a battus, et ils m’ont repêché. J’ai donc fait une première année de baseball « vraiment organisé » avec des pratiques, des games, des tournois pis toute, pour la première fois cette été là! On s’est rendu au provincial et on a perdu en final. L’année suivante, j’ai commencé à jouer à la balle-molle dans une ligue « d’adultes » et je n’ai jamais arrêté.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Aucune idée… mes parents, qui ne sont pas sportifs du tout, m’ont inscrit au T-ball à 4 ans, et j’ai eu la piqure. Les journées d’été chaudes, je pourrais jouer toute la journée, et recommencer tous les jours. Par contre, et peut-être même étonnamment, je ne regarde pas vraiment le baseball à la télé. Je suis allé voir les expos 2-3 fois max. L’équipe que j’ai le plus regardé est les Orioles d’Ahuntsic, souvent avec Michel Plante, parce que j’étais voisin du parc. C’est donc pratiquer ce sport et coacher mon fils qui me passionne.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>À ma première année, un tournoi de T-ball à l’intérieur de l’aréna, parce qu’il pleuvait dehors. Le pantalon était noir et le chandail orange pétant. C’était précurseur à ma première année dans la LBMA, pour les Vautours de Denis, dont la chemise était aussi Orange!</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Je regarde très peu de film donc je n’ai pas une tonne de référence. J’ai bien aimé Moneyball comme ben du monde, mais celui que j’ai préféré, est une animation : Everyone’s Hero.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Malgré que je suis généralement patient, une de mes citations préférées, que j’aime répéter à mes gars pour les faire rire est de Martin Matte dans les Beaux Malaises : Enweille, tu sais que j’suis pas patient!!</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>J’en ai plein, mais vous pouvez m’acheter avec du chocolat au lait😉</p>
<p>D’ailleurs, à 17 ans je devais vendre du chocolat pour financer l’équipe régionale de badminton et pour diverses raisons, j’ai dû prendre une année sabbatique. Plutôt que vendre le chocolat, ou le remettre à l’organisation, j’ai mangé une barre, puis une autre, et encore une autre…puis toute la boite… j’en ai pas vendu une maudite. Comme si l’équipe n’allait pas me retrouver pour que je paye...</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>J’adore ça et je le recommande !! D’ailleurs, envoyez vos CV à Michel Plante, je pense qu’il est en recrutement😉</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Je ne pense pas non… je fais toujours un peu la même chose, mais je pense que c’est plus des TOC que de la superstition!</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Généralement non. Perdre quand l’équipe joue bien ça va… Perdre contre des mauvais gagnants par contre, arrogants par exemple, peut faire sortir un côté de moi que la LBMA a peu vu.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>La conciliation travail/télé-travail/famille/activités familiale est du sport… J’ai déjà beaucoup joué au badminton, au golf, au hockey cosom et au hockey sur glace, en plus de faire du snowboard, mais maintenant ça se limite au hockey cosom 1x/semaine, au golf 1x/été et ski alpin 1x/hivers. J’ai commencé le Disque golf et ce n’était pas un succès. C’est clair que je vais quand même rejouer.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Je ne suis pas un gars extrême, donc le mot passion est fort pas mal. Mais présentement, mon attention et mon énergie sont complètement orientés vers ma famille et mon travail.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondue ?</p>
<p>Je pourrais à peine nommer quelques joueurs des expos ou des braves des années 90, et quelques légendes, sans plus, et je n’ai pas vraiment d’attachement à un joueur en particulier… tout ce que je peux dire c’est que j’ai déjà eu un poster de Larry Walker, et puisque j’étais receveur, j’ai bien aimé le retour de Gary Carter avec les Expos.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Au baseball mineur c’est sans doute mon été de 15 ans que je vous ai parlé plus tôt, et à la balle molle, j’ai quelques titres notables dans le LBMA. J’ai aussi pu tirer mon épingle du jeu assez bien dans d’autres ligues plus compétitives, mais je ne suis pas en mesure de nommer un jeu en particulier. Je joue pour la game, pour la gang, pour l’esprit, et les jeux en particuliers, j’ai tendances à les oublier assez rapidement. C’est pour ça que je ris après un Strike-out… je l’ai déjà oublié!!</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Receveur et 2b. J’aime bien lancer dans la LBMA, mais c’est pas là où je suis le plus utile…</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>J’ai une volonté de réussir chaque jeu, et j’y met l’intensité pour y arriver. J’observe les joueurs et la situation pour me donner un maximum de chance de réussir. Je prêche par l’exemple et surtout, j’adopte toujours la meilleure attitude possible.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Oui. Je connais assez bien les promoteurs Devimco et Claridge qui sont derrière le projet pour savoir qu’ils en sont capables. Maintenant, une fois qu’ils auront réussi, comment ça se passera sur le terrain et dans les gradins… c’est une autre histoire!</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Peu importe, je bois peu de boisson gazeuse.</p>
<p>Crémeuse ou Traditionnelle ?Traditionnelle extra vinaigre et poivre</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Aucun</p>
<p>Yankees ou Red Sox ?Aucun</p>
<p>Bière ou vin ?Ça dépend de l’évènement</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Sans</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?J’ai la réputation d’être sage😉.</p>
<p>Chien ou chat ?Chat</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?Bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?À moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Les jeux olympiques😉</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>L’activité n’est pas tant importante… pourvu que je sois avec les gens que j’aime, en été, avec un BBQ, et des breuvages froids!</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>C’est très serré dans bien des catégories… mais avec ses séries, Stéphane Proulx à une longueur d’avance comme lanceur, offensivement, Sylvain Longtin passe sous le radar mais je pense qu’il mérite certainement le joueur offensif, Stéphane Barsalou peut tout faire en défensive, Stéphane Beaudoin, est certainement finaliste pour être MVP, mais au final je décerne le coach de l’année à Alex Bibeau. Il a su plus que relevé le défi durant les absences de mon grand chum Blou!</p>
<p>Pour ta part mon JC, tu te débrouilles pas si mal sur un terrain de balle…😉</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>L’avantage d’être coach c’est justement de jouer avec ces gars-là… En 2020, j’ai joué avec Pat Chartrand, qui n’avait jamais « daigner » me repêcher et l’été dernier j’ai joué avec Stéphane Beaudoin avec je n’avais jamais jouer, pas même en remplacement. C’est sur que je veux rejouer à mon ami Barsalou. Des gars comme Joe Desrosiers, Sylvain Longtin et JC Noël sont parmi les joueurs qui seront un jour rouge.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Absolument, d’ailleurs j’ai fait entrer des gars comme Stéphane Barsalou et Sylvain Lamontagne qui sont parmi les gars les plus appréciés de la ligue. J’en ai fait entrer des moins apprécié, mais je ne m’en venterai pas.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>J’ai été assez chanceux jusqu’à maintenant… une entorse et une commotion en plus de 35 ans de sports de balle… et mes genoux ne veulent plus que je catche. Je touche du bois pour que ça continu comme ça.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>La LBMA doit rester une ligue où la camaraderie est une des principales valeurs. À cela, il faut s’assurer de remplacer les joueurs qui quittent par des joueurs de calibre au moins équivalent pour maintenir un certain niveau de jeu. La LBMA est une ligue de balle molle orthodoxe. Pas de balle donnée. J’aime la LBMA, je crois qu’elle peut durer encore un autre 45 ans, mais pour ça, pour assurer sa santé et sa pérennité, il faut l’implication et la bonne conduite de tous et chacun.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Attraper les balles plus hautes que la ceinture.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Attraper les balles plus basses que la ceinture😉Certains seulement comprendront ces réponses, les autres, on en reparle l’été prochain!</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>J’essaie de ne pas arriver en retard!</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Je joue principalement arrêt-court et parfois au champ. Lorsque la situation le permet, j’aime bien aller sur la butte. Mais je manque un peu (beaucoup) de pratique.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Parce que je suis têteux! Pis je me débrouille sur un terrain de balle.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Statistiquement non. Je suis là pour m’amuser et avec le plaisir, le succès vient.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle?</p>
<p>Je les oublis ceux-là … mais l’été dernier, une chandelle est frappée hors-ligne derrière le 3ebut, le genre de balle que j’attrape les yeux fermés d’habitude… mais cette fois-là, ca l’air que je n’ai pas croisé mes pieds comme d’habitude et je me suis étendu de tout mon long… et je vois la balle tomber à l’intérieur des lignes…</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Y’en a plein… il y a la famille Blouin au grand complet, David Asselin, David-Alexandre Beauregard.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Je dirais positif, engagé et fiable…</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Jamais de lance balle pour moi, je déteste ça. Je passe à autre chose complètement l’hiver.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>C’est un incontournable… et si tu ajoutes des oignons, tu auras une surprise…</p>
<p>J’espère pouvoir rejouer avec toi un jour, ce fut un beau privilège.</p>
<p>Éric en est à sa 17esaison, 366 parties jouées, 1227 apparitions au bâton, 663 coups sûrs, 40 circuits, 557 points comptés, 374 points produits, 0.540 de moyenne à vie et il a été 5 fois champion frappeur !</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('1', 'Coach 2021', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec les coachs 2021</h2>
<h3>Jean-Christian Dionne</h3>
<h3>Première entrevue</h3>
<p>Bonjour Messieurs,</p>
<p>J’ai le privilège d’avoir cette tribune et je vais m’efforcer d’en faire bon usage. C’est une très belle et bonne façon de découvrir et de mieux connaitre nos pairs.</p>
<p>Comme vous l’avez constatez, je suis un amoureux de la balle. Je m’implique car j’aime ça. Je mange de la balle ! Mes dernières années dans d’autres ligues m’ont laissé quelques goûts amers pour le sport que j’aime tant. La compétition continuelle, la pression de toujours performer et des gérances douteuses pour favoriser des équipes…bref, maintenant, je fais partie de la famille de la LBMA et j’en suis fier. J’y aie trouvé ma place auprès de vous et me suis réconcilier avec ma passion. Une saine compétition avec une bonne camaraderie, en plein ce que je cherchais !</p>
<p>Alors, quand j’aime, j’aime donner et c’est pourquoi je vais tenter de mon mieux de continuer le beau travail fait par mes prédécesseurs en vous posant des questions de type entrevues. J’espère vous divertir, j’espère que vous serez ouverts et participatifs, j’espère que vous allez aimer me lire autant que j’aurais de plaisir à écrire.</p>
<p>Alors, on débute avec un questionnaire « Vox Pop » fait auprès des entraineurs en fin de saison 2021.</p>
<p class="question">1-Quelles sont vos impressions sur la série et la saison 2021 ?</p>
<p class="question">2-Quelle a été la surprise de votre équipe ? Si applicable, y’a-t’ il des déceptions ?</p>
<p class="question">3-Quel joueurs (un ou plusieurs) d’une autre équipe que la vôtre vous a impressionnez?</p>
<p class="question">4-Selon vous, quelles sont les choses les plus importantes qu’on coach doit apporter à son équipe ?</p>
<p>La réponse de Sylvain Longtin, assistant coach des Vautours est celle-ci :</p>
<p>D’abord, ce fut encore une belle saison pour les vautours, surtout suite aux problèmes du début de saison. Pour ce qui est des surprises, je crois que les Verts en terminant 2ieme au classement, en a surpris plus d’un. Dans notre équipe, la surprise fut notre 2ebut Marc, très fort offensivement et défensivement et surtout un gentleman. Dans les autres équipes, Keith et Ali des Oranges ont été mes plus belles surprises. Un bon coach se doit de toujours motiver ses troupes avec une approche personnelle pour chaque joueur et surtout, s’amuser.</p>
<p>La grande inspiration de Benoit Hammarrenger, Coach des Harfangs ;</p>
<p>Impressions 2021</p>
<p>Parmi toutes les saisons que j'ai connues dans cette ligue, la saison 2021 a été l'une de celles avec la plus belle parité entre les équipes. Jusqu'au dernier week-end, trois équipes pouvaient terminer en tête et la lutte s'est chaudement disputée entre les Harfangs, les Ducs et les Vautours. Ça fait des parties qui ont des enjeux, riches en adrénaline, et ce sont les parties les plus l'fun à jouer! Au cours de nos différents affrontements cette saison, je trouvais qu'aucune équipe n'était une victoire automatique, et aucune équipe ne dominait outrageusement les autres. Même les Aigles qui ont finalement pris la dernière place avaient tout un alignement de frappeurs avec Sly, Barsalou, Ali, Francoeur et Bob. Ayoye!!! Alors pour cette belle parité, toutes mes félicitations aux coachs pour la belle job au repêchage, mais également pour votre travail remarquable de gestion d'équipe tout au long de l'année!</p>
<p>Surprises / déceptions chez les Harfangs</p>
<p>Pandémie oblige, au repêchage cette année nous n'avions pas vu les nouveaux joueurs en action. Les coachs nous devions donc nous fier à une petite fiche remplie par notre dépisteur en chef, Michel Plante. Dans la construction de mon équipe, Je me suis donc risqué avec deux joueurs que je ne connaissais pas, et quelles belles surprises ce fut!!</p>
<p>- J'ai arrêté mon tout premier choix au repêchage sur JC Dionne. Après l'avoir niaisé un peu dans nos pratiques («si ça te tente pas, reste chez vous»), j'ai rapidement réalisé à quel joueur exceptionnel j'avais affaire (bon il avait un chandail sur lequel c'était écrit qu'il était un joueur exceptionnel, alors ça m'a aidé). Il a certainement été l'une des pièces maîtresses de notre équipe à l'attaque comme en défense, mais également (et je ne vais surprendre personne) au niveau de la cohésion et de l'esprit d'équipe. Un grand joueur, une belle personne !</p>
<p>- Plus tard au cours du repêchage, j'ai jeté mon dévolu sur un autre joueur qui m'était inconnu : Eric Lafrenière. Et encore une fois, quel coup de chance! Un joueur polyvalent, capable d'occuper à peu près toutes les positions à l'avant champ comme au champ. Il a même terminé la saison comme receveur et a fait tout un travail à cette position. Une attitude irréprochable, et un leader positif par son attitude au sein d'une équipe.</p>
<p>Ceci dit, message aux autres coachs : Je vous déconseille fortement de prendre ces deux gars-là au prochain repêchage, ils ont plein de défauts et de vices cachés. J'ai appris à les gérer et je peux vous faire la faveur de m'en occuper un an de plus. Non, non, ça va, ne me remerciez pas.</p>
<p>J'ai eu une déception cette année parmi les joueurs des Harfangs... le coach... Je n'ai pas eu la saison espérée, j'ai eu de la difficulté à frapper d'aplomb et surtout de la difficulté à faire ce que j'ai fait par les années passées, sonner le ralliement aux moments nécessaires. Je me promets de revenir plus fort l'an prochain !</p>
<p>Joueur d'une autre équipe m'ayant impressionné</p>
<p>Je dirais Phil Lancup. Il se mettait en chest après ses matchs et je le trouvais encore très « tight » pour un nouveau papa. C'est impressionnant.Sinon, les coups de canon d'Ali Sabrah, m'ont fait écarquiller les yeux quelques fois!</p>
<p>Choses les plus importantes qu'un coach doit apprendre à son équipe</p>
<p>Ma réponse ici va être teinté par ma formation professionnelle je pense. Je crois fermement que pour obtenir le meilleur potentiel de mes gars, je dois leur apprendre à croire en eux et à avoir confiance en ce qu'ils sont capables de faire. Ceux qui ont joué pour moi m'ont entendu répéter à quel point j'avais confiance envers les gars que j'ai repêchés. Je souligne à grand traits les bons coups et je les rappelle au gars concerné plusieurs fois dans l'année. Je pense qu'entretenir un sentiment de compétence dans un sport nous rend déjà plus compétent à ce sport. J'aime que chaque gars sente qu'il a un rôle dans mon équipe, et que c'est LUI que je veux pour remplir ce rôle.</p>
<p>Bon, pour ceux qui trouvent que je pellète des nuages, de façon plus concrète, parmi les choses les plus importantes à enseigner à son équipe, y aurait de jouer le « bunt » de la bonne façon. Ost** qu'on n'a pas été bon !!!</p>
<p>Ouf…. Quel poète !!!</p>
<p>On poursuit avec Keith Beauregard, Coach des Aigles;</p>
<p>Ça été une saison mouvementée avec des belles parties tout le long de la saison. Certaines équipes je crois, ont performées au-dessus de leur apparence sur papier et d’autres en dessous de ce qu'ils auraient dû produire sur papier. En général par contre, ce fût une saison assez bien équilibrée avec beaucoup de surprises. Les recrues ont tous su bien s'intégrer à la ligue et tous je crois, sont de belles additions à la famille. Je pense que le format des séries est intéressant en général, peut-être de petits changement amélioreraient, mais j'aime bien. Les équipes de Stéphane Blouin commencent presque toujours à jouer en Septembre et cette année a été pareil... félicitations aux Condors pour des séries enlevantes en général. Encore une fois, l'exécutif en général et Michel Plante en particulier doivent recevoir des éloges pour leur dévouement et acharnement pour présenter une saison malgré toutes les mesures sanitaires et les petites anicroches habituelles de n'importe quelle saison de balle.</p>
<p>Question 2</p>
<p>Dans les Aigles cette année, je pense que le joueur qui a cimenté sa réputation est Ali Sabrah. Un joueur polyvalent qui a un coup de bâton du tonnerre (littéralement!). Le fait de devenir Papa lui a fait du bien apparemment. Je pense qu'il a terminé la saison avec sa meilleure moyenne à vie et c'est tellement une bonne personne, tout le monde le voulait comme remplaçant (quand JC était pas disponible ... ou qu'ils avaient besoin d'un 3 :-)). Pour ce qui est de déceptions, je pourrais seulement dire que l'ensemble des erreurs commises sur le terrain en défensive par l'ensemble de l'équipe nous a souvent mis dans des trous qu'on avait de la difficulté à se sortir.</p>
<p>Question 3</p>
<p>Quoiqu'il y a des joueurs qui ont surpris en général cette année, une chose que j'ai remarqué est que beaucoup de joueurs ont connu des matchs et/ou des séquences impressionnantes: Ali Sabrah qui a frappé comme un démon 2-3 fin de semaines, Joe Santo qui a connu des parties impressionnantes au monticule, Phil Laverdière qui a surpris plus d'un au monticule dans un rôle qui ne s'attendait pas à devoir remplir au début de l'année. Pat Chartrand qui continue de connaître des saisons remarquables au bâton. Je pense que beaucoup de joueurs cette année ont connu des 'petits moments de gloire' ... et pour la majorité d'entre nous c'est pour ceci qu'on joue: on sait qu'on n’est pas les meilleurs, on sait que ce n'est pas les ligues majeurs, mais entre nous, c'est notre tour d'être Bob Gibson, ou Tim Raines, ou Gary Carter ou Jackie Robinson. Cette petite chaleur interne qui nous fait sourire, crier et s'encourager. Je ne changerais pas ça pour rien!</p>
<p>Question 4</p>
<p>Chaque coach a une vision différente de ce que son équipe devrait avoir. La nature des joueurs de notre ligue veut dire que nos coachs doivent dans certaines circonstances commencer au début et vraiment apprendre les bases. On doit aussi trouver où chaque joueur est le plus confortable en défensive et dans l'alignement des frappeurs. Somme tout, ce qui est le plus important est de créer une atmosphère où tout le monde a du plaisir et que les victoires sont possibles à chaque fois que l'on prend le terrain.</p>
<p>Éric Collard, coach des Faucons ajoute ceci;</p>
<p class="question">Quelles sont vos impressions sur la saison et série 2021 ?</p>
<p>C’était une saison où tout le monde était contant de se voir, de retrouver notre beau parc Jarry et de jouer à la balle, encore plus que par les autres années me semble! J’ai bien aimé voir les supporter des bleus être présent en grand nombre durant la fin de la saison et les séries… ça me rappelait mes belles années avec Coach Blouin.</p>
<p class="question">Quelles ont été les surprises dans votre équipe?</p>
<p>Mes recrues; Barnabé et Jérémie qui effectuait un retour dans la ligue.On ne sait jamais trop, trop à quoi s’attendre de ces gars-là au moment du repêchage, mais durant leur absence en série, on s’est bien vite rendu compte ce que ces gars-là apportaient sur le terrain!</p>
<p class="question">Si applicable, y a-t’ il eu des déceptions?</p>
<p>Oui, on a perdu nos pilules contre notre bipolarité!! Un soir on pouvait faire 15 points, et le lendemain pas capable d’acheter 5 coups surs... Surement que nos adversaires y étaient pour beaucoup aussi.</p>
<p class="question">Quel joueur (un ou plusieurs) d'une autre équipe que la vôtre, vous a impressionné ?</p>
<p>Y’en a plein, je pense entre autres à des gars comme Ali Sabrah pour sa puissance, JC Noel pour sa régularité, et Christian Poulin pour son positionnement et sa technique.</p>
<p class="question">Selon vous, quelles sont les choses les plus importantes qu'un coach doit apporter à son équipe?</p>
<p>Premièrement, donner l’exemple par l’attitude en général et sur le terrain. Je pense aussi que dans une ligue à talent variable comme la nôtre, le coach doit donner un certain encadrement aux joueurs, soit d’un point de vue technique pour certains joueurs qui apprennent à jouer ou qui sont dans un slump, ou de rappeler aux joueurs d’être « Never too high, never too low ». Bref, c’est un bon père de famille.</p>
<p>Guy Brisebois, allias « Tiger » commente à son tour;</p>
<p>La première chose que je constate, ce n’est pas comment tu commences, c’est comment tu finis une saison. En perspective, une belle saison des Ducs, très déçu que ça c’est terminé pour une deuxième année consécutive. Les favoris ont pas été invités à la grande finale, Félicitation aux Condors qui ont été jusqu’au début malgré un début de saison difficile. C’est une équipe qui ne lâche jamais. Je connais bien la recette des Condors pour y avoir fait partie pendant plusieurs années « beaucoup de bière et d’esprit d’équipe » Mention honorable des Vautours, belle saison « down the road ».</p>
<p>Les Ducs ont connu beaucoup d’adversité cette année, Tiger cette année pensait sur papier après le draft et l’ajout de la liste de protection que j’avais réussi ma vision pour bâtir de quoi de solide. Évidemment, y a rien de parfait dans la vie. Les rôles de tous et chacun ont été mis à contribution. En perdant notre lanceur partant ma vision a été (vite un plan B) Mon joueur protéger, non, non, ma Diva Phillippe Laverdiere a été le sauveur de la saison des Ducs. Je remercie également toute l’équipe pour leur dévouement, polyvalence et combativité malgré les embuches. Ma déception est vraiment que j’aurais aimé jouer plus de match avec l’équipe complet que j’ai drafter. Un gros remerciement a tous les joueurs qui ont fièrement porté main forte au Ducs cette année.</p>
<p>Un des joueurs qui m’a le plus impressionné cette saison est Keith Beauregard, que je connais depuis longtemps. Un vrai joueur de balle et un criss de bon gars mais cette année notre Keith nationale est revenu en grande forme. Après plusieurs blessures graves, des opérations il aurait pu facilement jouer 40 matchs cette saison. De plus nous avons eu une belle cuvée de nouveau joueur cette année, parfait pour la ligue.</p>
<p>Oh bo boys, les qualités d’un bon coach ? Si l’on parle dedans la LBMA ? Je commence par quoi? Technicien en garderie, négociateur, médiateur, guru, daddy, coach de vie, motivateur. Pour certain n’importe quel singe peut faire un line up, ma vision des choses et la passion que j’ai de la balle avec mes 60 matchs d’expérience en tant que coach, je pense que la première qualité selon moi est le Leadership. Faire partie de quelque chose comme une famille on passe quand même l’été ensemble. Enseigner la base ou rappeler celle-ci, essayer que tout le monde se battent pour le gars à côté de lui. Je vais terminer là-dessus pour plusieurs qui me connaissent, je suis très compétitif, je veux gagner, je vais essayer de sortir le meilleur de mes joueurs soir après soir. Pour cela je pense connaitre ma balle mais la vraie force d’un coach c’est de bien bâtir son équipe.</p>
<p>Wow intense même sur papier</p>
<p>L’on termine avec le coach vainqueur des séries, Stéphane Blouin des Condors !</p>
<p class="question">Quelles sont vos impressions sur la série et la saison 2021 ?</p>
<p>Bien encore une fois, une saison écourtée en raison de la covid. Un classement très serrer pour les 3 premières positions, belle bataille jusqu’à la fin. En série, là ou tout se joue, plusieurs nous voient comme la surprise des séries mais honnêtement tous les Condors savent qu’on avait plutôt mal joué dans la saison.</p>
<p class="question">Quelle a été la surprise de votre équipe ? Si applicable, y’a-t ’il des déceptions ?</p>
<p>La grande surprise des Condors fut les performances du bas de line-up.</p>
<p>Aucune déception chez les bleus.</p>
<p class="question">Quel joueurs (un ou plusieurs) d’une autre équipe que la vôtre vous a impressionnez?</p>
<p>Plusieurs belles surprises, Sylvain Forgue qui a très bien lancé quand il a été sollicité. Les nouveaux comme toi (JC Dionne) et Mathieu Francoeur et j’oublie des noms. Je dirais que tous les nouveaux sont de très bonne acquisition pour la belle LBMA.</p>
<p class="question">Selon vous, quelles sont les choses les plus importantes qu’on coach doit apporter à son équipe ?</p>
<p>Aucune caliss d’idée loll !!!Grouillez-vous la bière va se réchauffer !!</p>
<p>Disons juste que j’ai le tour pour faire sortir le meilleur de chacun et de faire croire à l’équipe que quand on tire tous du même bord personne ne peut nous arrêter sauf nous-même. Je ne veux pas me vanter mais dans les 8 dernières saisons j’ai 4 championnats des séries et si je ne me trompe pas, j’en ai 9 en 22ans comme coach…</p>
<p>Pour quelqu’un qui ne voulait pas se vanter … ;-)</p>
<p>Maintenant voici une petite question que j’ai posée aux lanceurs!</p>
<p class="question">Quels sont les 3 frappeurs les plus difficiles à affronter pour vous et pourquoi?</p>
<p>Réponse de Joe Santo</p>
<p>Stéphane Heppel et Alex Bibeau, ils collent tellement le marbre que ma zone de prise est très limitée.</p>
<p>Eric Collard, lui c’est le contraire, je peux lancer 10 pieds autour de la zone et il réussit toujours à me frapper.</p>
<p>Réponse de Myles O’Reilly</p>
<p>JC Dionne, Marc Ménabo et Patrick Chartrand.They’re all good hitters and most of the time they get their hits.</p>
<p>Réponse de Stéphane Beaudoin</p>
<p>JC Dionne parce qu’il frappe les balles hautes, les basses, à l’extérieur je fini par plus savoir ou lui lancer.</p>
<p>Pat Chartrand lui aussi frappes tous mes lancers et surtout il frappe tous les lanceurs, vraiment les lanceurs, surtout dans les jambes !</p>
<p>Sylvain Longtin, un autre qui frappe à tous les champs et peu importe ou je lance. Très difficile à retirer.</p>
<p>Ces 3 frappeurs, je n’ai pas encore de stratégie.</p>
<p>Réponse de Serge Chaussé</p>
<p>Well, bonne question mon JC, depuis 85, j’en ai affronté des frappeurs. Je vais m’en tenir aux nôtres.</p>
<p>Éric Collard, pour sa facilité à choisir ses tirs et l’agressivité qu’il a sur les buts.</p>
<p>Joe Desrosiers, pour sa faciliter à placer la balle ou il veut !</p>
<p>Gino Ciarlo, excellent frappeur de simple. Opportuniste, il frappe un peu n’importe quel lancer, haut, bas et les coins. Il est difficile à berner même avec un changement de vitesse.</p>
<p>Il y a toi (JC Dionne) ton nom sortira certainement un jour pour moi mais je dois encore avoir une couple de saison pour t’étudier. Loll</p>
<p>Réponse de Stéphane Proulx</p>
<p>Premièrement il y a monsieur Longtin, dur frappeur, prend beaucoup de place à la plate. Il peut frapper partout et sur n’importe quel lancer. À l’intérieur, extérieur, en haut, en bas, vraiment dur à affronter. Il est là pour le plaisir, tu peux le voir qu’il aime ça la balle. Toujours un challenge de l’affronter</p>
<p>Monsieur Collard, lui aussi fatigant au bâton ! Monsieur sourit tout au long de ses présences, prises ou balles, il sourit tout le temps ! Très dur à retirer sur 3 prises. Il cherche constamment les trous en défensives et il les vise. Très bon compétiteur.</p>
<p>Sans manquer de respect à personne, c’est toujours joueurs avec les cotes plus basses qui me font mal. Je lance comme j’en suis capable et « bang » ils sortent avec un coup sûr opportun.</p>
<p>Hey, Hey !!Maintenant un vox pop rapidos !!</p>
<p class="question">J’ai demandé aléatoirement à ces messieurs, quel lanceur vous donne le plus de difficulté ?</p>
<p>Sylvain Longtin; Monsieur Beaudouin, car il vari bien ces tirs ou il veut.</p>
<p>Sylvain Lamontagne; Stéphane Beaudoin, car il est un lanceur très précis, si tu ne frappes pas son 1 pitch tu ne verras plus aucun bon lancer par la suite à frapper.</p>
<p>Rémi Duval;J’hésite entre les 2 Stéphane mais je vais y aller avec Beaudoin. Il joue constamment avec sa vitesse pour tenir les frappeurs hors d’équilibre et varie aussi fréquemment ses lancers sur les coins intérieurs et extérieurs. De plus, je pense que sa “spinner” est un des meilleurs lancers que j’ai vu dans mes 10 ans dans la ligue. C’est un lanceur intelligent et tu dois absolument casser son rythme car il peut battre un club à lui seul.</p>
<p>Giuseppe Guerrera,</p>
<p>Donc personnellement je pense que Steph des Condors, la raison pourquoi ? C’est simple, la vitesse!</p>
<p>Jason Dorrington;</p>
<p>Serge Chausse, Pourquoi? J’en ai aucune idéeEn 2 ans j’ai un bon contact contre lui, ok, oui c’est en séries avec 2 retraits en dernière manche pour nous donner la victoire mais ça ne change rien du fait qu’il réussit toujours à me menotter. J’ai tout fait pour m’ajuster mais ça ne change rien. Je lui lève mon chapeau et je me prépare pour l’an prochain, comme compétiteur, je veux avoir le meilleur sur lui</p>
<p>Sébastien Marchand;</p>
<p>Je pense que c'est Joe Santo parce que ça ne fait seulement que 3 ans que je suis dans la ligue, il était avec moi la première année et était un lanceur B l'an passé...donc, c'était la première année que je l'affrontais et je trouve que sa balle est plus rapide qu'ont le croirais, il m'a eu sur 3 prises plusieurs fois.</p>
<p>Denis Charbonneau;</p>
<p>Beaudoin est killer avec ses prises aux genoux…..</p>
<p>Sylvain Forgue;</p>
<p>Pour moi, c'est Stéphane Beaudoin, à l'occasion sa balle à tendance à monter, à la dernière minute, tu veux la manger et tu te fais Fourrer hihihi !!!</p>
<p>Jonathan Latour;</p>
<p>Je dirais Joe Santo parce que je frappais presque toujours sur le joueur du 2e but...</p>
<p>JC Dionne;</p>
<p>Moi celui qui ma donner le plus de difficulté c’est Philippe Laverdiere !</p>
<p>Pourquoi ? Je ne suis pas capable la balle arc en ciel. Oui je peux en pincer une de temps en temps mais grrr.</p>
<p>JC Noel;</p>
<p>Stéphane Proulx. Grands changements de vitesse d’un lancer à l’autre. Et sa balle rapide est… rapide!</p>
<p>Ali Sabrah; Beaudoin. J’aimerais dire pourquoi, mais je ne veux pas trop donner d’informations !!</p>
<p>C’est tu pas « beautiful » ça !!</p>
<p>Merci tout le monde de vous êtes prêtés au jeu et de répondre à mes questions. Sans vous, cela aurait été pas mal « fade ».</p>
<p>Maintenant, je vais vous demander de bien regarder vos mails. Je vais bientôt écrire à quelques-uns d’entre vous pour une vraie entrevue.</p>
<p>J’espère que vous avez appréciez autant que j’ai aimé le faire !!</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('alexandre-bibeau', 'Alexandre Bibeau', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Voici un autre exemple du coté familial de la LBMA que j’aime beaucoup, c’est le cousin de grands joueurs …</p>
<p>Voici Alex Bibeau</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ? Je suis arrivé dans la ligue en 2006. C’est mon cousin Patrick Chartrand qui m’a fait entrer dans la ligue.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ? Au printemps 2006, j’avais 19 ans, Pat m’a appelé pour me demander si j’avais envie de jouer à la balle-molle, en sachant très bien que j’avais jamais joué de ma vie. À l’époque j’étais un joueur de hockey, mais Pat m’a expliqué que n’importe qui pouvait jouer dans la LMBA, bon ou pas. J’ai donc fait mes débuts l’été suivant son appel et je suis tombé en amour avec la ligue, assez pour lâcher le hockey alors que j’ai eu à faire un choix entre les deux sports.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ? J’aime tout le coté stratégique de la balle. J’aime vraiment chacune des tournures qu’un match peut prendre à la suite d’un jeu anodin sur le terrain ou d’une décision qui fait basculer le match d’un côté comme de l’autre.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ? J’étais relativement vieux la première fois que je suis allé voir les Expos, je suis allé voir deux matchs contre les Diamondbacks en 2000, un c’était Curt Schilling et l’autre c’était Randy Johnson. On avait de super bons billets juste au-dessus du dugout des Expos, mais je me souviens à quel point j’étais impressionné par les 6’10 du Big Unit.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ? J’y vais avec un choix un peu plus « champ gauche » que certains classiques nommés par les autres : Problem with the curve, avec Clint Eastwood</p>
<p class="question">6.Quelle est ta citation de film préférée ? J’ai beaucoup de mal à choisir laquelle, mais plusieurs répliques du film Slap Shot</p>
<p class="question">7.Quel est ton péché mignon ? Un bon filet mignon</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ? C’est sûr que j’aimerais tenter l’expérience. Je sais très bien que ça a des bons et des mauvais côtés mais on verra si l’occasion se présente un jour</p>
<p class="question">9.Es-tu superstitieux ? Pas à en perdre la raison non, mais je prends toujours le même bâton jusqu’à temps que ça fonctionne vraiment plus haha</p>
<p class="question">10.Es-tu mauvais perdant ? Non, mais je suis compétitif quand même. Je veux gagner et je vais tout faire pour y arriver pendant le match, mais un coup que c’est fini je suis content pour mes chums qui ont gagné l’autre côté. On efface et on recommence ça sert à rien de mâcher la défaite pendant des jours.</p>
<p class="question">11.Pratiques-tu d’autres sports ? Comme j’ai écrit plus haut, j’ai joué longtemps au hockey mais maintenant je joue juste à la balle.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? J’adore la pêche.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ? Si j’avais à en choisir un seul, ce serait Ken Griffey Jr. J’ai grandi en le voyant jouer dans ses meilleures années et que dire de son élan….</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ? Puisque ma carrière se limite à la LMBA, je dirais que ma plus grande fierté c’est les 2 derniers championnats gagnés avec les Condors. J’ai aimé chaque seconde que j’aurai joué avec ces gars-là. Dans l’adversité de la COVID et des saisons écourtées, du fait d’être négligés du début à la fin, de perdre 10 matchs de suite en 2021, la pression que je me mettais en étant le premier choix de l’équipe dans les deux saisons, de remporter les grands honneurs ça aura été la cerise sur le sundae qui fera en sorte que ce sera difficile à dépasser comme réussite collective. Si j’avais à choisir un exploit individuel ce serait d’avoir été nommé le joueur offensif de l’année en 2019.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? J’adore jouer au champ centre. Avant cette année j’avais joué une seule manche dans le diamond en 15 ans donc j’ai appris à aimer le gazon sous mes pieds haha. Par contre cette année j’ai joué quelques matchs comme receveur et j’ai aimé l’expérience. Il faut dire que c’est vraiment agréable de catcher Stéphane Proulx</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Je dirais que je suis un joueur polyvalent au bâton. On peut m’insérer n’importe où dans l’alignement de frappeurs et je vais m’adapter. En défensive je crois que j’ai un bon gant, j’essaye d’analyser chaque frappeur pour me positionner le mieux possible parce que pour un joueur de champ c’est important d’être à la bonne place. Par contre je n’ai pas un bras canon mais bon c’est à ça que servent les intercepteurs haha</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? Mon cœur dit oui, la raison me dit non.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnelle?Crémeuse</p>
<p>Sucré ou Salé ?Sucré</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?RedSox</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Jamais</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?Tannant</p>
<p>Chien ou chat ?Aucun des deux</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?Aucun des deux</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? J’aime être entourés de gens que j’aime. Je n’ai pas vraiment de scénario parfait j’apprécie plutôt le moment présent.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ? MVP, Joueur Offensif, recrue de l’année : JC Dionne.Meilleur lanceur et MVP des séries: Stéphane ProulxJoueur le plus amélioré : Sacha CarballadaJoueur défensif : Vincent RobergeEsprit sportif : JC Dionne</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? Bob Bureau sans hésiter. En 16 ans et après avoir joué pour toutes les équipes j’ai jamais eu la chance de jouer avec lui.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Bien sûr, j’ai même déjà réussi à convaincre mon chum David Péloquin, même si ça a pris plusieurs années, je crois qu’il ne regrette pas d’avoir finalement accepté.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Non mais j’espère que tu me jinxera pas en me posant cette question là !</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? On a des gestionnaires qui se dédient cœur et âme à la ligue. Tant qu’elle sera gérée par des gens passionnés elle sera en santé.</p>
<p class="question">25.Quel est ton point fort à la balle ? Mon positionnement en défensive</p>
<p class="question">26.Quel est ta faiblesse ? J’aimerais être plus patient au bâton</p>
<p class="question">27.Comment te prépares-tu avant un match ? Je n’ai pas de routine spéciale.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Je joue à toutes les positions au champ mais principalement au Centre. J’aimerais essayer le 2ebut un jour.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Je suis un gars d’équipe qui va s’adapter à ton style et qui va tout faire pour montrer l’exemple et pousser dans la même direction que le coach.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Gagner plus de championnats, disons que j’y ai pris goût haha j’en avais pas gagné depuis ma première année.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? J’étais au champ droit, Stéphane Blouin était au 2B. On faisait le warm up au début de la manche et quand est venu le temps de rentrer la balle, Steph m’a pas entendu et je lui ai lancé la balle avant qu’il se retourne. Il l’a mangé direct sur la tête et a eu une commotion cérébrale. On s’en parle encore en joke maintenant mais méchant malaise quand c’est arrivé et dans les semaines suivantes.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. J’ai une hésitation entre les frères Blouin. Patrick était tout un frappeur mais honnêtement je crois que je prendrais Stéphane dans ses bonnes années. Ce qui me fait pencher pour lui c’est sa capacité d’envoyer la balle au champ opposé, et dans son champ aussi, avec puissance. Pour vider les buts rien de mieux que de mettre la balle en jeu où la défensive s’en attend le moins.</p>
<p class="question">33.Quel genre de coéquipier tu es ? Un joueur qui met l’équipe avant mes performances individuelles. Je préfère gagner en ayant une saison médiocre que d’être champion frappeur dans une équipe perdante. J’essaye d’être un exemple sur le terrain et surtout de véhiculer du mieux que je peux le message du coach. J’adore aussi enseigner ce que je sais aux plus jeunes avec moins d’expérience. Comme champ centre j’ai eu la chance d’apprendre à certains joueurs comme Simon Larin, Alexandre Beaudry ou Mathieu Ouellet-Doré qui en étaient à leurs premiers pas dans la ligue et j’ai adoré les voir progresser à chaque match.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? Je n’oublie pas le sport, mais je ne suis pas un gros fan des cages de frappeur</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Je pense que le ketchup est rendu plus populaire que les bon vieux moutarde-chou</p>
<p>Il y a de la graine de coach ici … ça se sent. Une autre bonne personne que j’ai rencontré cette été, un condor un gagnant !! Voilà, je l’ai dit !!</p>
<p>16 saisons complétées dans la LBMA, 341 parties jouées, 1106 apparitions au bâton, 459 coups sûrs, 19 circuits, 349 points comptés, 282 points produits pour une moyenne à vie de 0.415.</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('ali-sabrah', 'Ali Sabrah', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<h3>Ali Sabrah</h3>
<p>Quand j’ai regardé le draft au mois mai dernier, j’ai été surpris ! Pour moi c’était une première et très honnêtement je me suis dit « lui il ne vient pas du lac st-jean » ! C’est fou les préjuger que l’on peut se faire sans connaitre la personne. Pourtant il a le sang bien plus bleu, blanc, rouge que moi et bien d’autres. Jamais vu de chameaux stationnés dans le parking ou de tapis volant en double sur Jarry, jamais vu non plus ses 40 voleurs !La seule chose que j’ai vraiment remarqué, c’est les Bombes … qu’il frappait !</p>
<p>Je vous présente Ali Sabrah,</p>
<p class="question">1.Je t’ai taquiné plus haut dans ton introduction, je sais que la LBMA est assez respectueuse envers tout le monde mais est-ce que ça t’ai déjà arrivé de vivre de mauvaise expérience dans des équipes sportives ?</p>
<p>a.Malheureusement oui. J’habitais à Saint-Léonard dans le temps et je jouais dans une équipe de Baseball à chaque été. En 2005, nous avons déménagé à Laval et je cherchais une équipe de Baseball locale. J’en avais trouvé une dans mon coin et durant quelques pratiques, je ne me sentais pas accueilli par certains des joueurs. J’ai failli quitter l’équipe et arrêter le Baseball complètement pour cet été, mais le Président de l’association m’a convaincu de rester. Mais je peux vous dire que les choses ont changé avec ces « certains joueurs » après qu’ils ont appris à me connaître.</p>
<p class="question">2.J’ai vu que tu voyageais beaucoup pour des évènements sportifs, quel sport est ton préféré.</p>
<p>a.C’est très difficile de choisir entre le Baseball et le Hockey. C’est mes deux sports préférés, mais depuis que les Expos sont parti d’ici, le Hockey est devenu le sport que j’aime aller regarder.</p>
<p class="question">3.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>a.La saison qui vient de passée était ma 4èmedans la ligue et c’est Luke qui m’a fait découvrir la ligue.</p>
<p class="question">4.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>a.Mon amour de la balle à commencer tout jeune. Mon frère, Hassan, qui est 8 ans plus vieux que moi à commencer à jouer au Baseball d’un jeune âge et j’assistais à plupart de ses matchs. J’ai commencé à regarder les Expos depuis que j’avais 7-8 ans et j’ai commencé à jouer dans une ligue de balle en 2001 jusqu’en 2012. J’ai prit une pause des ligues pas parce que je voulais, mais parce que je n’arrivais pas à trouver des ligues qui prenaient des joueurs de 22 ans, ou je n’ai pas assez bien cherché. Et ainsi arrivait 2018, ma première année dans la LBMA.</p>
<p class="question">5.Explique-nous ta passion pour ce sport ?</p>
<p>a.Ça va être difficile pour expliquer ma passion en écrivant, mais je dirais que j’ai tout du Baseball/Softball. Le mental, le physique, les techniques, etc. Le fait de jouer dehors sous une belle température. La bière après un match. Je peux continuer, mais je ne vais pas en finir.</p>
<p class="question">6.Quel est ton premier souvenir de baseball ?</p>
<p>a.Je ne pourrais pas dire le premier souvenir malheureusement, parce que j’en ai eu plusieurs. Je vais en nommer quelques-uns qui me viennent en tête :</p>
<p>i.La saison de 39HR/40SB de Vladimir Guerrero où j’ai assisté à une des dernières rencontres de la saison dans une loge, et il avait frappé le top de la clôture pour un double. Il était si proche d’avoir sa saison de 40/40.</p>
<p>ii.Les matchs que j’assistais tout seul quand j’avais 10-11 ans après une journée à La Ronde, parce qu’on prenait le Métro Pie-IX et je voyais les partisans aller en direction du Stade.</p>
<p>iii.Quelques matchs que mon père m’a amenés et il s’était endormit parce que pour lui, il n’a jamais aimé le Baseball. Mais il assistait à tous mes matchs.</p>
<p>iv.Les BobbleHead Day des Expos.</p>
<p>v.ETC!</p>
<p class="question">7.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>a.Rookie of the Year. Parce que mon rêve était de jouer dans la MLB et ce jeune homme dans le film a pu réaliser son propre rêve et jouer dans la MLB à son âge.</p>
<p class="question">8.Quelle est ta citation de film préférée ?</p>
<p>a.The people should never be afraid of their government. The government should be afraid of their people. V for Vendetta (2005)</p>
<p class="question">9.Quel est ton péché mignon ?</p>
<p>a.Ma charmante épouse.</p>
<p class="question">10.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>a.Ça ne me dérangerait pas!</p>
<p class="question">11.Es-tu superstitieux ?</p>
<p>a.Des fois oui, des fois non</p>
<p class="question">12.Es-tu mauvais perdant ?</p>
<p>a.Non, du tout</p>
<p class="question">13.Pratiques-tu d’autres sports ?</p>
<p>a.Hockey, Soccer</p>
<p class="question">14.En dehors du sport, as-tu d’autre passion ?</p>
<p>a.Le Poker</p>
<p class="question">15.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?a. Brad Wilkerson, je ne sais pas pourquoi mais je trouvais beaucoup de similarité entre nous.</p>
<p class="question">16.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?a. Je dirais l’année que j’ai eue au bâton cet été 2021 ! Ma meilleure saison en carrière autant baseball que softball.</p>
<p class="question">17.Quelle est ta position préférée … au baseball ?</p>
<p>a.Lanceur</p>
<p class="question">18.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>a.Je me décrirais comme joueur « Utility » puisque je peux jouer à plusieurs positions.</p>
<p class="question">19.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>a.Oui j’y crois et je rêve de cette journée.</p>
<p class="question">20.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnel ?Crémeuse</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Thé</p>
<p>Yankees ou Red Sox ?Red Sox</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Ça ne me dérange pas trop😉</p>
<p>Canadiens ou Nordiques ?HABSSSSS all the way!</p>
<p>Sage ou tannant?Sage</p>
<p>Chien ou chat ?Chat</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En bas de zéro</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondial ?oufff… difficile celle-là.. Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">21.Pour toi une journée parfaite c’est quoi ?</p>
<p>a.Une journée avec au moins un événement sportif.</p>
<p class="question">22.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?a. Aucune idée</p>
<p class="question">23.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>a.Je dirais Stéphane Beaudoin, parce qu’il lance bien en sale et je n’aurais pas à l’affronté lol!</p>
<p class="question">24.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>a.200% oui!!!</p>
<p class="question">25.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>a.Il y a deux ans, j’avais foulé la cheville en jouant au hockey cosom et j’étais vraiment déçu d’avoir manqué quelques weekends de balle.</p>
<p>b.En 2012, j’étais revenu de Cuba et j’avais contracté un virus qui m’avait fait avoir une Mio-Péricardite. Le docteur m’a empêché de jouer au baseball et même travailler pour un période de 6 semaines.</p>
<p class="question">26.Comment tu perçois l’avenir de la LBMA?</p>
<p>a.Avec l’addition de deux autres équipes. LBMA Expansion😉</p>
<p class="question">27.Quel est ton point fort à la balle ?</p>
<p>a.Frappeur.</p>
<p>b.Lanceur au Baseball, mais ça fait un bout.</p>
<p class="question">28.Quel est ta faiblesse ?</p>
<p>a.Je sens que j’ai perdu mon touch dans le diamond.</p>
<p class="question">29.Comment te prépares-tu avant un match ?</p>
<p>a.En passant au Tim Horton me chercher un Ice Capp pour me donner de l’énergie, surtout les parties du Samedi matin.</p>
<p class="question">30.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>a.Récemment, je joue beaucoup au 3èmebut, mais ce n’est pas si facile pour un gaucher. Avant cela, ma position préférée de Baseball / Softball était le 1erbut.</p>
<p>b.Un de ces jours, j’aimerais essayer lanceur.</p>
<p class="question">31.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>a.Si tu cherches un gars va donner son 110% à chaque partie et qui peut bien frapper s’il mange un bon souper, qui adore la balle, alors tu devrais me repêcher.</p>
<p class="question">32.As-tu des objectifs personnels dans la LBMA ?</p>
<p>a.Je suis quelqu’un qui aime les statistiques. Autres que gagner le championnat à chaque année, je dirais mes objectifs personnels sont de monter ma moyenne au bâton à chaque année et frapper plus de HR en dehors du terrain :P</p>
<p class="question">33.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>a.Oh boy… celle-là je me rappelle très bien. C’était ma première année dans une ligue, et j’avais 12 ans. Je jouais Pee-Wee A et l’équipe du Bantam A avait besoin d’un remplaçant pour leur tournoi. Je jouais au 3èmebut. Durant le milieu du match, j’ai reçu un ground ball qui était frappé solidement, et ça fait un mauvais bon et la balle m’a frappé sur le cou, mais ça n’a pas vraiment fait mal. J’ai commencé à pleurer parce que j’étais embarrassé du mauvais bon et quand je dis pleurer, je dis brailler lol! C’était des larmes d’embarras et pas des larmes de douleurs.</p>
<p class="question">34.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>a.Éric Collard. Il frappe tout et il peut mettre la balle n’importe où.</p>
<p class="question">35.Quel genre de coéquipier tu es ?</p>
<p>a.Je dirais je suis quelqu’un qui aime encourager ses coéquipiers. Si jamais un de mes coéquipiers fait une erreur, que ça soit coûteux ou non, je l’encourage à oublier et de rester concentrer.</p>
<p class="question">36.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>a.Oui c’est sûr! D’habitude, j’y vais 1-2 mois avant le repêchage.</p>
<p class="question">37.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>a.Je ne comprends pas trop la question, mais là je crave un bon hot-dog au stade olympique durant un match des Expos!</p>
<p>Les statistiques d’Ali; il est à sa 4esaison, 68 parties joués, 211 apparitions au bâton, 94 coups sûrs, 0.445 de moyenne à vie avec 6 circuits et 69 points produits.</p>
<p>Ali est une personne qui gagne à être connu. Je crois qu’il est maintenant parmi l’élite de la LBMA, j’espère que tu vas nous bombarder de grosses claques les étés à venir.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('benoit-hammarrenger', 'Benoit Hammarrenger', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>L’on m’avait dit « tu vas voir il est intense, un tortionnaire, il parle fort, il est intense, tu vas l’entendre crier du champ centre, il est intense, c’est le Kim Jong-un de la LBM » Boff,je n’ai pas eu de misère avec, je l’ai mis dans ma poche. Sans blague, j’ai découvert un bon leader qui a notre sport à cœur, qui essai d’obtenir le meilleur de ces gars à chaque match. Fort sympathique en plus, quoi demander de plus.</p>
<p>Je vous présente Benoit Hammenrenger</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Depuis 2006, donc 16 saisons. Il paraît qu’après 20 saisons on reçoit une montre Rolex de la part de la LBMA. Je reste juste pour ça.C’est Google qui me l’a fait découvrir, je cherchais une ligue pour recommencer à jouer !</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Contrairement à plusieurs, je n’ai jamais joué au baseball. Quand j’étais jeune, dans mon patelin de Deux-Montagnes, c’était de la balle molle même pour les enfants et ados. Je joue depuis que j’ai 11 ans, et j’ai toujours trippé sur ce sport magnifique!</p>
<p>Fun fact pour ceux qui sont dans la ligue depuis moins de 8 ans… Lors de mes 7 premières années dans la LBMA, j’étais un joueur de premier but. J’aimais faire des split et m’étirer pour attraper des relais! En 2013, je jouais dans les Condors de Steph Blouin et on n’avait pas réellement de champ centre. J’ai donc postulé pour le poste et Steph, un fin connaisseur, m’a posé LA QUESTION d’embauche pour le poste de champ centre : «Ouin, ben tu sais-tu pogner un fly?». Tu vois qu’il connaît son baseball. J’ai hésité, j’ai un peu menti pour avoir la job, comme on fait tous en entrevue, et j’ai répondu «oui». J’ai pogné le premier fly que j’ai reçu tout en fuitant un petit peu dans mes pantalons… Steph Blouin m’a crié quelque chose comme «Osti de mange-marde, c’est rien que de la luck!». Faque je joue là depuis 8 ans.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>C’est malade un sport qu’on joue en été, dehors au soleil, ou sous les projecteurs lors d’une douce soirée… Sur un grand terrain qui sent le gazon frais coupé… On peut même y jouer dans le sable et se salir comme un petit gars… Pis on fait ça avec 10 chums, contre un paquet d’autres chums… Trouvez-moi un autre sport aussi beau et cool!!</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>J’avais autour de 10 ans, on avait un grand terrain chez mes parents et je me pratiquais à frapper des balles sur le terrain (à 10 ans, pour un petit gars pas trop sportif qui n’avait jamais joué, ça n’allait pas super loin). Un jour j’ai frappé la balle et elle est montée haut dans le ciel! Si haut qu’elle a rebondi sur les nuages avant de redescendre … et de passer par-dessus la haie de cèdres qui bordait notre terrain. Mon premier coup de circuit !!! C’est là que j’ai décidé de joindre une équipe de softball récréatif à la ville.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Money Ball.Brad Pitt est tellement beau.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>«There’s a difference between knowing the path, and walking the path»- Morpheus dans la Matrice</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Les fruits de mer en général.</p>
<p>J’ai aussi une recette écœurante de chop suey, je vous la partage :</p>
<p>-Dans une poêle, chauffer l’huile à feu moyen. Cuire le boeuf haché 5 minutes.</p>
<p>-Ajouter le mélange de légumes, le gingembre et, si désiré, l’ail. Cuire de 2 à 3 minutes.</p>
<p>-Ajouter la sauce soya, le ketchup et les fèves germées. Saler et poivrer. Prolonger la cuisson de 1 minute. Si désiré, parsemer de persil.</p>
<p>-Sacrer tout ça aux vidanges. C’est fuckin pas bon du chop suey</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Je le suis déjà, et j’adore!</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Pas tant trop très, mais un peu des fois. J’ai une routine très précise où je fais toujours les mêmes mouvements dans le cercle d’attente des frappeurs. Ça me met dans ma zone.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Perdre? «Je ne perds jamais. Sois je gagne, sois j’apprends»- Nelson Interiano. Ou un autre Nelson… je ne sais plus</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Pas tant trop très, mais un peu des fois. J’ai joué pas mal au basketball et j’ai même coaché mon gars et son équipe pendant 4 ans. Je ne joue plus par contre.</p>
<p class="question">12.En dehors du sport, as-tu d’autres passions ?</p>
<p>J’aime beaucoup mon travail.Je joue de la guitare aussi, mais vous ne voulez pas entendre ça.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondue ?</p>
<p>J’ai beaucoup aimé Larry Walker.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Avoir attrapé le premier fly que j’ai reçu comme champ centre en 2013 (voir plus haut).</p>
<p>Sans blague, j’ai une grande fierté de mes titres de MVP des séries en 2019 et 2020. Fier d’avoir contribué de façon significative au championnat et co-championnat de mes équipes lors de ces deux saisons.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Penché un peu vers l’avant, les yeux plissés pour essayer de voir la face du gars qui frappe à partir du champ centre.Ah c’était pas ça la question! Ben champ centre. Mais j’aimerais beaucoup essayer l’arrêt-court. Steph Blouin m’a demandé à ce sujet «Ouin, ben tu sais-tu pogner un roulant?». Je lui ai répondu «Non, mais Collard non plus. C’est quoi ton point?».</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je cours vite, ce qui est une force au champ centre. On dit que les lacs, rivières et océans couvrent environ 70% de la surface de la terre. C’est bon, je couvre le reste.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Mets-en.</p>
<p class="question">18.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Moi je ne prends pas de chance, je choisi Jean-Christian Dionne pour tous les trophées.</p>
<p class="question">19.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire?</p>
<p>Après 16 ans j’ai joué avec pas mal de monde. J’aimerais avoir la chance de rejouer avec Gino Ciarlo. Toute une tête de balle ce gars-là. Je le mets en haut de ma liste en vue du prochain repêchage. (Quoi? Y a un malaise?)</p>
<p class="question">20.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Mets-en</p>
<p class="question">21.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Je pense bien m’être fracturé une côte dans les séries 2020 lors d’une collision avec Sasha Carballada. Je suis revenu du champ et j’ai frappé un circuit. Les blessures et douleurs c’est pour les chochottes comme Steph Blouin.</p>
<p class="question">22.Comment tu perçois l’avenir de la LBMA?</p>
<p>Je sens que bientôt on troquera les pantalons noirs pour des pantalons gris. Ce serait malade.</p>
<p class="question">23.Quel est ton point fort à la balle ?</p>
<p>Je cours vite et je sais pogner des fly</p>
<p class="question">24.Quel est ta faiblesse ?</p>
<p>Je ne sais pas pogner des roulants, mais Collard non plus.</p>
<p class="question">25.Comment te prépares-tu avant un match ?</p>
<p>Je m’assure de mettre mon jack-strap au cas où le coach voudrait m’essayer à l’arrêt-court. Attends… c’est moi le coach…</p>
<p class="question">26.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Devenir une légende</p>
<p class="question">27.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Ouin j’étais embarrassé comme coach… Une fois en série, on est en prolongation, on finit au bâton, c’est l’égalité, deux retraits, On a les buts remplis. Notre frappeur reçoit un but sur balles!! Eh oui, le point de la victoire rentre, bonsoir on a gagné. Sauf que le frappeur en question a célébré avant d’aller toucher au premier but… Keith le fin renard a été lui toucher avec la balle, bam, 3eretrait ! L’arbitre lui-même nous a engueulé parce qu’il ne voulait pas continuer le match mais il n’avait pas le choix! Bon je ne dirai pas c’est qui le frappeur qui a fait ça, mais ça rime avec «Richard Germain».</p>
<p class="question">28.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Je suis le genre à répondre : c’est moi qui veux être au bâton.</p>
<p>Mais je pense que Dave Asselin (que les joueurs appelaient «le Punisher», mais que sa blonde appelait «Ti-brin») serait le meilleur choix.</p>
<p class="question">29.Quel genre de coéquipier tu es ?</p>
<p>Vous le savez, vous avez quasiment tous joué avec moi!</p>
<p class="question">30.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Je recommence après le repêchage!</p>
<p class="question">31.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Dans un hot dog, ceux qui savent en conviendront, ce qu’on doit mettre… c’est de la CHOUCROUTE !!</p>
<p>Vous savez que Benoit depuis qu’il a passé à l’émission de Marilou, il est rendu big ! Tellement big qui ne répond pas à toutes les questions, comme ceux en rafales ! Cela aurait été gênant peut être que Marilou apprenne qu’il aime le coke traditionnel sucré, qu’il est un Yankees, qui prend du thé, qu’il boit du vin l’hiver et de la bière l’été, qu’il bouffe sûrement de la pizza AVEC des ananas, anchois et panet, coupé comme Marilou te l’a montré ! Qu’il est un Nordique tannant, chat, végé, en bas de laine, avec un verre à moitié plein à la série mondiale !</p>
<p>Benoit est à sa 16e saison complété, 366 parties jouées, 487 coups sûrs, 26 circuits, 385 points comptés, 319 points produits pour une moyenne à vie de 0.433</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('carl-olivier-boivin', 'Carl-Olivier Boivin', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Voilà, je vous présente Carl Boivin;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ? Depuis maintenant 3 ans</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai joué quelques années très jeunes, je devais avoir 6 ou 7 ans mais j’ai arrêté la balle vers l’âge de 10 ou 11 ans.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Je trouve que la balle est un sport qui est accessible et permet de profiter de nos étés trop courts.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Manger la crème glacée dans un mini casque aux couleurs des Expos</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Assurément « Major League » qui représente tous les types de personnalités dans un vestiaire.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Plus jeune la crème glacée, aujourd’hui la bière après un match !!</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Celle-là est bonne… NON</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Je dirais un peu quand même…</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Next Question…plus sérieusement je déteste perdre mais je vous laisse juger</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>J’ai beaucoup joué à différents sports mais malheureusement je prends de l’âge et les occasions sont moins nombreuses, mais je n’arrêterai jamais de faire du sport</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Oui mais ça serait trop long a énuméré…</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondue ?</p>
<p>Je crois que je dois y aller avec Tim Raines</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Me lever le Samedi matin…</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Aujourd’hui 1erbut…, jeune receveur</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Non ce n’est pas a moi de faire ça…, mais je peux dire que je vais sur un terrain pour tout donner afin de faire le jeu qui pourrait aider mon équipe.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Je le souhaite de tout cœur mais je n’y crois pas.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Aucun des deux…</p>
<p>Crémeuse ou Traditionnel ?Traditionnel</p>
<p>Sucré ou Salé ?Les deux… pas de préférence !</p>
<p>Café ou Thé ?Café, le thé je laisse ca aux anglos !</p>
<p>Yankees ou Red Sox ?RED SOX !!!!</p>
<p>Bière ou vin ?…..Les deux mais le VIN en premier</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Soyons sérieux…Sans ananas LOL</p>
<p>Canadiens ou Nordiques ?Canadiens mais ils ressemblent drôlement aux Nordiques présentement</p>
<p>Sage ou tannant?Tannant je suppose…</p>
<p>Chien ou chat ?Coudonc… Est-ce un profil de site de rencontre…, CHIEN évidemment !!!</p>
<p>Viande ou végé ?Regarde-moi la grosseur…. Viande !</p>
<p>En bas de laine ou en bas de zéro ?En bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Moitié plein…</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Finale de la coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>C’est trop rare…je ne sais pas !!</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? Il y en a quelques-uns mais je vais les garder pour moi</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Certainement</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? Je crois que la ligue à prouver qu’elle peut résister au temps donc je crois que la LBMA est là pour durer</p>
<p class="question">25.Quel est ton point fort à la balle ? l’après-match…</p>
<p class="question">26.Quel est ta faiblesse ?l’avant match le samedi matin….et mon coup de bâton</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Comme je peux… en me concentrant sur ce qui s’en vient</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>1erbut et j’aimerais un jour essayer de lancer quelques balles</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Parce que je suis un joueur d’équipe</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Oui mais je vais les garder pour moi jusqu’à ce qu’ils se réalisent…</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?Regarder mon co-équipier Mike courir en bobettes autour des buts. Et non, ce n’est pas une « fake new »</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>JC Dionne ou Pat « recordman » Chartrand</p>
<p class="question">33.Quel genre de coéquipier tu es ? Demandez aux autres qui ont joués avec moi…</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Je vais frapper des balles quelques fois mais pas assez souvent</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Non, je crois que la salade de choux fait la différence</p>
<p>Monsieur Boivin est à sa 3e saison complétée, 59 parties jouées, 56 coups sûrs pour une moyenne à vie de 0.320</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('christian-poulin', 'Christian Poulin', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Quand on dit que « je crois que je fais partie des meubles » cette phrase lui va bien. Tellement big le gars qui a contournée mes questions et les a mis à sa saveur à lui. Il m’a quand même divertie avec ses histoires, c’était bien avant que je sois un membre de la LBMA.</p>
<p>Christian Poulin;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA?</p>
<p>Vous pouvez essayer de deviner. Ça date d’une certaine époque où Pat Chartrand jouait au champ centre et était le champion frappeur de la ligue. Parmi mes coéquipiers, il y avait André et Gilles Dandurand, Marcel Morin, Spiro Dermatis et Michel Desjardins.</p>
<p>(C’était en 1996, donc ça fait plus de 25 ans. J’ai manqué plusieurs saisons malheureusement à cause de l’université et des blessures.)</p>
<p>Je me sens très choyé d’avoir eu la chance de jouer avec les membres du temple de la renommée.</p>
<p class="question">2.Qui te la fait découvrir ?</p>
<p>C’est difficile de m’imaginer un monde sans la LBMA. De ma perspective, elle a toujours été là. Étant le fils de l’un des membres du temple de la renommée, je participais déjà aux activités de la ligue dès mon jeune âge en courant après les fausses balles.</p>
<p>J’ai d’ailleurs connu mes premiers succès à un très jeune âge lors du tournoi de poche du pique-nique annuel de l’époque organisé par la LBMA au camping Plage Laliberté à St-Liboire. Je ne pense pas que ce n’était pas prévu qu’un enfant gagne, car le prix étant une bonne bouteille de vin. Étrangement, mon père était très heureux de ma victoire😊.</p>
<p>La famille Poulin a toujours aimé les traditions. Nous y retournons encore aujourd’hui à chaque année pour y disputer notre tournoi de fer annuel familial. Mère nature a récupérée les terrains qui ne sont plus en bon état, mais ça ne nous empêche pas d’éprouver autant de plaisir qu’à l’époque.</p>
<p class="question">3.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Je n’ai pas beaucoup joué au baseball étant jeune, alors ce sont plusieurs membres de la LBMA qui m’ont enseigné comment jouer à travers les années. Je suis conscient qu’il reste beaucoup de travail à faire😊.</p>
<p>Je me considère très chanceux d’avoir eu la chance de passer du temps avec des gens comme Pat Chartrand, Pat Blouin et sa conjointe Kim Sarrazin. Grâce à eux (et bien d’autres), j’ai l’impression de devenir un meilleur joueur à chaque saison (malgré les années qui s’accumulent).</p>
<p>L’autre avantage d’avoir souvent joué avec eux, c’est d’avoir eu des équipes avec des fiches gagnantes la majorité de mes saisons dans la LBMA.</p>
<p class="question">4.Quel style de joueur es-tu ?</p>
<p>Je suis le genre de joueur qui glisse au marbre avec des blessures aux deux genoux sur un squeeze bunt pour gagner faire gagner la finale de championnat 11-10 à son équipe. Je suis également du genre à gagner les séries avec ma femme enceinte dans les estrades à une journée d’accoucher.</p>
<p>On ne pourra pas me reprocher de ne pas toujours tout donner ce que j’ai😊. N’ayant pas le talent naturel de joueurs tel que mon frère, je compense à coup de jeux sacrifices et des présences de qualité avec plus de huit lancers. Je commence à sourire (ça m’arrive parfois) quand les gens commencent à me trouver fatiguant au bâton😊.</p>
<p>Avec mon père qui me sermonne et qui décortique chacune de mes parties, je crois également commencer à comprendre comment « la game » fonctionne. Il me récite le livre du baseball tel qu’on le faisait avec le petit catéchisme à l’époque.</p>
<p>Ça m’a permis de faire des jeux tels que de voler le marbre sans que personne ne s’en rende compte. Ou encore de faire un triple jeu en défensive décrit en temps réel par André Dandurand qui assistait à la rencontre dans les estrades juste à côté de moi au 3ebut (tag du joueur qui allait au marbre, retrait forcé en touchant le 3ebut et un lancer au 1erpour le troisième retrait de la manche). J’étais très fier d’avoir fait 2 triples jeux lors de la même saison cette année-là.</p>
<p>Je ne parlerai pas de la partie des séries qui est allé en prolongation et qui était normalement terminée (ça risquerait de ramener des mauvais souvenirs à certains joueurs). Je suis allé voir l’arbitre pour lui dire que le frappeur n’avait pas touché au premier but sur un but sur balle qui donnait la victoire à son équipe. Mais bon, même si nous avons gagné ce 2 de 3, le karma nous a rattrapé peu après. Nous avons perdu les deux parties suivantes malgré le fait d’avoir compté 35 points au total lors de ces rencontres…</p>
<p class="question">5.Quel est ta faiblesse à la balle?</p>
<p>Je suis peut-être fou, mais je ne suis pas cave au point de répondre à cette question-là😊. Bien que ce ne soit pas un grand secret pour personne car toute la ligue est au courant. (Eh oui, il y en a quelques-unes…).</p>
<p class="question">6.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire?</p>
<p>Sans hésitation, ça serait Stéphane Beaudoin. C’est un joueur extrêmement doué pour lequel j’ai beaucoup d’admiration. Nous n’avons jamais été dans la même équipe malgré toutes ces années dans la LBMA. Ça serait bien de pouvoir jouer avec quelqu’un d’aussi dominant (et ça aiderait ma moyenne au bâton😊).</p>
<p>Je me rappelle quand j’étais encore trop jeune pour jouer, de l’avoir vu et de m’être dit qu’il me faisait penser au Pierre Lambert de la balle-molle avec son talent et sa présence.</p>
<p class="question">7.Quel est ton plus beau souvenir dans la LBMA ?</p>
<p>C’est difficile de choisir, car il y en a tellement. J’ai beau être dans la quarantaine, d’aller à chaque partie avec mon père est sans aucun doute ce qui m’est le plus précieux.</p>
<p>Je me souviens aussi d’une rencontre où mon père lançait contre mon frère et moi. Il y avait également mon oncle qui arbitrait en arrière du marbre. La LBMA, ça a toujours été pour moi une grande histoire avec des familles formidables. C’est toujours plaisant de revoir des gens comme Michel Bureau et Pierre Blouin qui viennent nous encourager très régulièrement.</p>
<p>En termes d’équipes, j’ai eu des superbes saisons avec les rouges de Pat Blouin. Je me souviens d’une année où nous avions gagné le championnat avec Guy Brisebois et mon frère jouaient dans le champ avec moi et qui criaient « championship! » à toute tête en lançant leurs gants dans les airs. Nous voulions tellement gagner cette année-là, après que les « méchants gris » avaient abusé des règles contre nous alors que Pierre Sansregret se soit fait expulser d’une rencontre (à tort selon moi). Nous avions gagné la partie par un point de peine et de misère avec un joueur en moins et des retraits automatiques gratuits pour l’autre équipe. Le lendemain, nous avions tellement le couteau entre les dents que nous avons gagné également la deuxième rencontre par la marque de 16-3 si ma mémoire est bonne.</p>
<p>Mais une de mes plus belles saisons était avec les « Orange Crush » de Denis Charbonneau. Nous avions gagné les séries et c’était probablement le meilleur esprit d’équipe que j’ai vu dans ma carrière. Nous entendions des joueurs tel que Carol Bérubé et Yves Dumontet (« Ben Oui ») à partir du stationnement lorsqu’ils arrivaient au parc. Il y avait d’autres joueurs incroyables et très appréciés dans la ligue comme Michel Forbes, Spiro Dermatis, Vince et Nick Dinicolantonio, Éric Morin et mon frère.</p>
<p class="question">8.Quel est le moment où tu as été le plus embarrassé dans la LBMA ?</p>
<p>Je n’en suis pas très fier, mais je pense avoir un top 3 assez mémorable.</p>
<p>Lors d’une rencontre, je courrais pour attraper une balle frappée à la clôture. Rendu à la piste d’avertissement, je suivais toujours la balle des yeux et j’ai glissé. Malheureusement, mon pied a frappé la clôture très solidement et est resté coincé en dessous.</p>
<p>Lors de la pire rencontre de ma vie, ma belle-famille arrivée de l’Abitibi à mon insu. Ils ont soufflé dans une trompette alors que je m’élançais sur un compte de 3 balles 2 prises. Mon père (jouant pour une autre équipe), les encourageaient à nous déconcentrer durant la partie. J’ai terminé la partie avec 3 retraits au bâton et mon frère 2. Mais bon, même les joueurs de notre équipe trouvaient notre embarras très drôle!</p>
<p>C’est difficile de croire qu’il peut y avoir eu pire que ça, mais oui, c’est arrivé. Lors d’un match où on m’appelait encore le kid car je n’étais pas très vieux, j’affrontais au bâton le très talentueux André Dandurand comme lanceur. Il m’avait atteint accidentellement avec une balle rapide à la tête, J’étais ok. Rectification : j’étais ok jusqu’au moment où ma mère qui était dans les estrades se lève et crie très fort « touchez pas à mon fils! ». Je suis resté étendu au sol car j’essayais de m’enfoncer la tête dedans😊.</p>
<p class="question">9.À quel joueur aimerais-tu ressembler le plus et pourquoi ?</p>
<p>Patrick Blouin est sans aucun doute le meilleur joueur avec qui j’ai eu la chance de jouer dans ma carrière. Il a un talent fou et un QI de baseball incroyable. Je me rappelle l’avoir vu jouer à l’arrêt-court et de retirer un gars au premier but à genoux à partir de la lisière du gazon. Lors d’une pratique au parc André-Grasset (Martucci aujourd’hui), il avait frappé un circuit sur la rue Place des Coopératives. Pour ceux qui ne le savent pas, la rue de l’autre côté de la clôture, c’est Émile-Journault. Place des Coopératives, c’est en arrière des maisons. Je m’en souviens car c’est moi qui étais allé chercher la balle😊.</p>
<p>Cela étant dit, j’avais besoin d’un modèle qui jouait au 3ebut (ma position préférée). J’essaye encore aujourd’hui de ressembler (sans jamais réussir à l’égaler) à Doug Wilson. Un joueur apprécié de tous, qui n’avait jamais froid aux yeux et reconnu pour son esprit sportif (le trophée porte aujourd’hui son nom). Keith Beauregard est également au sommet de ma liste.</p>
<p class="question">10.Est-ce qu’il y a eu des controverses dans ta famille ?</p>
<p>Je ne sais pas si inviter mon frère et mon père qui jouaient contre moi ces années là pour le souper du dimanche et utiliser les trophées de la saison ou des séries comme centre de table compte pour des controverses😊.</p>
<p>Mais nous avons dans ma famille l’équivalent du but d’Alain Côté.</p>
<p>Mon oncle Claude s’était juré de retirer sur décision mon frère au moins une fois avant de prendre sa retraite comme arbitre. C’était un sujet récurrent lors des réunions familiales. C’est finalement arrivé alors que mon père et moi étions en vacances (donc pas de témoin). Mon frère jure que la balle était deux pieds à l’extérieur, mais les autres membres de son équipe jurent à l’unanimité (avec un sourire fendu jusqu’aux oreilles) que c’était bien un retrait un bâton. Qui dit vrai dans cette histoire? Nous ne le saurons probablement jamais.</p>
<p class="question">11.Si tu pouvais faire trois souhaits par rapport à la LBMA ?</p>
<p>Comme tout le monde, je souhaite de pouvoir jouer encore longtemps dans une si belle ligue. Je tiens à remercier tous les gens comme Michel Plante qui se donnent corps et âme pour cette ligue. Ça serait formidable d’avoir la chance de jouer un jour avec mon plus vieux. Il est déjà bien meilleur que moi à 14 ans.</p>
<p>Mon deuxième souhait remonte à ma jeune enfance. Encore aujourd’hui, je rêve de voir un jour un joueur frapper un coup de circuit sur un train qui passe au parc Jarry😊.</p>
<p>Mon troisième serait de pouvoir rejouer à nouveau dans la même équipe que mon frère un jour. C’est ce qui me manque le plus dans la LBMA.</p>
<p>Christian est à sa 19e saison, a 366 parties jouées (32eall time), 1010 apparitions au bâton (51eall time), 270 coups sûrs et une moyenne à vie de 0.267.</p>
<p>Christian, je souhaite le retour de ton frère dans la ligue et que ton fils sois celui qui la frappe sur le train !!</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('danick-jasmin-riel', 'Danick Jasmin-Riel', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous présente Danick Jasmin Riel</p>
<p>Questionnaire général</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Printemps 2022, Mathieu Francoeur</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai commencé très jeune à l’âge de 4 ans, j’évoluais pour St-esprits dans Rosemont jusqu’à l’âge de 14 ans. J’ai dû arrêter pour me concentrer sur le hockey mais l’été je remplaçais dans l’équipe de softball à mon père sous le nom de Stéphane Tremblay le cousin à mon père car je n’avais pas l’âge légal pour jouer. Par la suite, je n’est pas joué de 2001 à 2017, année où j’ai recommencé à jouer.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Ma passion pour ce sport passe par tout; écouter des matchs, aller voir des matchs, collectionner, chandails, gants, bâtons, cartes, ect. Quand on était jeune ont jouaient toujours au parc, même dans les ruelles du cartier Rosemont, ont utilisait les balcons des triplex dans la ruelle comme des balcons de stade pour fair nos homerun derby, (circuit au 3e balcon dans fenêtres de la porte de la madame 5 point hahah!).</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Stade olympique, match à 5$, un hot-dog, une crème glacé dans un mini casque, j’étais assis derrière le marbre parce ont avait changé de place, le match était cool mais ce que je me rappel c’était que le 33 Larry Walker avait sauté sur le lanceur et les bancs s’étaient vidés.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Major league. J’adore les comédies à la base et mixer avec le baseball c’est juste wow ! et les personnages</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>En selle camarade!</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>La viande.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?Oui</p>
<p class="question">9.Es-tu superstitieux ? Hiiii a un niveau assez élevé</p>
<p class="question">10.Es-tu mauvais perdant ? Non (mais jedéteste perdre). Haha !</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Oui le hockey quand je vais pouvoir remette mon équipement qui un peu trop grand, le golf, badminton, basket, tennis, mais pas toute en même temps !</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Oui trop justement, mais je dirais que les montre et tout le côté horlogerie.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Barry bonds</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Je ne l’ai pas encore accomplie.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Receveur</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Polyvalent, bon coup de bâtons, juste quelque kilo en trop</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Absolument.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ? Coke</p>
<p>Crémeuse ou Traditionnel ? Crémeuse</p>
<p>Sucré ou Salé ? Salé</p>
<p>Café ou Thé ? Café</p>
<p>Yankees ou Red Sox ? Yankees</p>
<p>Bière ou vin ? Vin</p>
<p>Été ou Hiver ? Ete</p>
<p>Pizza avec ou sans ananas ? Sans</p>
<p>Canadiens ou Nordiques ? Canadiens</p>
<p>Sage ou tannant? Tannant</p>
<p>Chien ou chat ? Chien</p>
<p>Viande ou végé ? Viande</p>
<p>En bas de laine ou en bas de zéro ? De zero</p>
<p>Ton verre est à moitié plein ou à moitié vide? plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ? Série mondiale</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Quand mais enfants me disent je t’aime papa ça pas de prix</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2022 de chaque catégorie et pourquoi ?</p>
<p>Je ne connais pas toutes les catégories encore, je suis nouveau mais je le flair comme suit;</p>
<p>Joueur le plus utile à sont équipe : Jean-Christian Dionne, Pas besoin de dire pourquoi !</p>
<p>Meilleur frappeur : Jean-Christian Dionne, pas besoin de dire pourquoi ! (mais fait attention chu pas loin )</p>
<p>Meilleur joueur défensif : Mathieu Francoeur, il est excellent à toutes les positions (sauf lanceur )</p>
<p>La recrue de l’année : ( c’est moi ) parce que j’ai décidé</p>
<p>Lanceur de l’année : Sylvain Forgues selon moi, je trouve que c’est lui le meilleur lanceur cette année !</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? Éric collard</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Absolument</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Oui, plusieurs</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Bel avenir, plus de jeunes, le concept est très bien</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Mon coup de bâton</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Mon poids</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Un coke diète pis une cigarette pis je détends l’atmosphère (les 2 premières étapes ce n’est pas toujours un bon exemple mais bon!)</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>3ebut, 1er but, Lanceur, j’aimerais essayer receveur un jour, c’était ma position étant jeune</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Parce que chaque fois que tu vas jouer contre moi je vais te le faire regretter et on va avoir du fun en cr……. Ensemble.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Oui avoir du fun, me faire des amis, aider une équipe à tout gagner et d’être meilleur à chaque année</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>La fois où j’ai glissé au 3iem but il y a deux ans, dans ma tête, je me voyais glisser et avoir un triple. Ca plus donner une collision en forme de scorpion pis un joueur défensif écrasé et un retrait.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Moi, j’aime la pression et je crois que j’y réponds bien (sans prétention)</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>J’ai aucune idée, selon moi cool, faudrait demander aux autres joueurs.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Oui absolument j’ai besoin de ça</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Non, jamais de ketchup juste de la moutarde, ça donne un meilleur angle d’attaque pour contourner les buts et cela garde les balles en jeux hahaha !!</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('daniel-david', 'Daniel David', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<h3>Daniel David</h3>
<p>Ah les bleus, les Condors, les champions !</p>
<p>J’ai joué 4 parties avec les bleus et ce gentil géant à la grosse voix était très sympathique, bruyant, bizarre, sur mon dos, pas méchant, espiègle, mais de bon goût… non pas toujours de bon goût ! loll</p>
<p>VoiciDaniel David</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Je jouais avec les grands de cette ligue vla25 ans dans une autre ligue. Wood, les Blouin, Les Schiller, Le blond et j’ai décidé de me joindre à la LBMA qui a duré un an. Je jouais dans les Condors de Michel Plante. Nous avons perdu en final. Notre lanceur A nous avait lâché en final et j’ai lancé contre la famille Blouin. Pat avait frappé une balle si loin qu’on la pas retrouver. Ha ha ha !! Je suis revenu vla3 ans à la demande de Stéphane Blouin qui devait jouer sa dernière année. En 4 ans dans la ligue, 3 saisons complètes, 2 championnats et une défaite en final, toujours avec les Condors.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai commencé à jouer au baseball vers l’Age de 7 ans au parc Beaubien. Vers 9 ans j’ai passé tous mes étés dans un camping ou j’ai joué. T-Ball, Slow pitch et softball. Pour finir dejouer avec l’équipe de Pat Blouin, les Braves.</p>
<p class="question">3.Explique-nous ta passion pour ce sport?</p>
<p>Je ne suis pas vraiment passionnée. Je veux rester actif et j’aime bien la ligue et les gens. Toujours un plaisir de voir les vieux de cette ligue. Bob Bureau, Steph Beaudoin, Pat Chartrand, etc.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Le Parc Jarry.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Money Ball. J’aime bien les histoires vraies</p>
<p class="question">6.Quelle Est ta citation de film préférée?</p>
<p>If you build it, they will come.</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Ma femme</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non jamais. Mais je pense que la ligue doit considérer Alex Bibeau. Alex a fait un job remarquable avec les Condors l’an passé. A fait des calls judicieux pour nous faire gagner. Je pense qu’a toutes les fois qu’il fait notre line up, on a été victorieux. Pour moi et mes co-équipiers, Alex est un des meilleurs choix.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Un peu. Je prends toujours le même bâton, Je fais les mêmes élans avant d’aller frapper.</p>
<p class="question">10.Es-tu mauvais perdant?</p>
<p>Non. La bière est aussi bonne après une victoire ou défaite.</p>
<p class="question">11.Pratiques-tu d’autres sports?</p>
<p>Hockey, Golf, vélo</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Voyage et voyage de sport. J’ai vue 20 gammes de la NFL et quelques MLB et NHL.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondue ?</p>
<p>Je n’ai pas de joueur préféré. Bien aimer certains joueurs des expos. Raine, Dawson, Walker, Carter etc.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>2 dernières années Champion avec les Condors avec les meilleurs coéquipiers malgré les hauts et les bas (10 défaites de suite en juillet cette année). Rester fort malgré les mauvais commentaires. Pas de vitesse, Pas de lanceur B, Pas d’arrêt court, des loosers, 3 cotes 1 dans l’équipe etc.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>1 er But et champ gauche dans mon jeune temps</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je fais de mon mieux à m’importe quelle position qu’on me fait jouer</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?Non</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ouPepsi?Pepsi</p>
<p>Crémeuseou Traditionnel ?Crémeuse</p>
<p>Sucré ouSalé?Salé</p>
<p>Café ou Thé ?Aucun des deux</p>
<p>Yankees ou Red Sox ?Expos</p>
<p>Bièreou vin ?Bière</p>
<p>Étéou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?All Dress</p>
<p>Canadiens ou Nordiques ?Prédateurs</p>
<p>Sage ou tannant?Drôle</p>
<p>Chienou chat ?Chien</p>
<p>Viandeou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?en bas blanc….règle de la ligue</p>
<p>Ton verre est à moitié plein ou à moitié vide ?quel verre!!</p>
<p>Finale de lacoupe Stanleyou Série Mondial ?coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Trop personnel et rien avoir avec la balle!</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je ne connais pas vraiment les catégories. Je sais que les Condors sont champions pour une 2 ième année. Pour le reste, bonne chance aux gens !</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?C’est une bonne question. J’ai été toujours un Condors. Si j’avais le choix. J’aimerais qu’on est une autre chance de jouer ensemble pour tenter un tripler. On serait plus gros, moins vite et ça laisserais plus de chances aux autres équipes. Mais ça va me faire plaisir de côtoyer d’autre gars.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?Oui</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer?</p>
<p>Oui, 2019 accidents de moto. Fracture de la clavicule et 2 côtes fracturées.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Super bien. Avec ton implication et les gens en place, ça va bien aller.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>J’en ai deux. Mes glissades au marbre. Merci à Aly d’avoir confirmé que j’étais sauf !! Influencer les arbitres au marbre selon les Harfangs</p>
<p class="question">26.Quel est ta faiblesse ?Je ne suis pas un bon frappeur</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Je commence à mettre mon Jack strap, après mes bas, mes atèles aux genoux, mes culottes, mes spikes, pour finir mes chandails</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Cette année je n’ai pas eu de place régulière. Il avait toujours un gars pour me remplacer. J’ai quand même joué à toutes les positions sauf receveur.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Parce que tu n’as pas le choix de prendre tout le monde. L’important pour moi et de venir au parc et d’avoir du fun, gagne ou perd. Si tu es un Coach qui veux gagner à tout prix et que tu n’acceptes pas les erreurs, passe-moi. Sinon je vais faire du mieux que je peux. Ah oui, 3 saisons complètes, 3 finales, 2 championnats ! ;-)</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?Continuer à venir au parc pour avoir du plaisir</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>J’ai frappé un roulant solide au 3ebut. Le gars s’est précipité et à lancé dans l’abri des joueurs.Malheureusement pour lui, j’étais couché au marbre avec une dislocation du genou. Mes chums m’en parlent encore.</p>
<p class="question">32.Un compte de 3 balles, 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Jason Dorrington sans hésiter. En 2 ans dans la ligue, 2 fois champions. L’an dernier, dernière manche, 2 retraits, il a frappé une balle à la clôture pour faire courir Steph Blouin jusqu’au marbre pour la victoire qui nous a envoyé en final. Cette année à la 3e partie de la finale, on a donné un but sur balle 4 fois à un joueur avant lui (Gino je crois) et Jay a frappé 3 en 4. Éric Collard serait mon deuxième choix.</p>
<p class="question">33.Quel genre de coéquipier tu es?</p>
<p>Si tu ne me connais pas, j’ai l’air d’une grande yeule qui parle fort et qui prend toute la place. Pour vrai, je suis un bon gars qui veut avoir du fun. Un peu baveux sur le bord. Mais toujours disponible à jaser si jamais il y a un problème</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport?</p>
<p>J’ai une passe à l’année à Laval. J’y vais de temps en temps.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il soit pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?Trop longue ta question. Je vais me prendre une autre bière.</p>
<p>Merci JC de m’avoir choisi. Ça été le fun à remplir. Je te souhaite la recrue de l’année et j’ai déjà hâte à voir tes photos sur Facebook a défaut d’avoir une photo avec le trophée de Champion des finales !!!!!!</p>
<p>Passez de belles fêtes et bonne Années. On se revoit en mai !</p>
<p>Daniel est arrivé en 1997 et a quitté pour ensuite revenir en 2019. Soit 4 saisons, 68 parties joués, 226 apparitions au bâton, 82 coups sûrs, 0.363 de moyenne à vie et 61 points produits.</p>
<p>Quand tu es champion, tout est permis. Tu as gagné le dernier match de l’année, tu peux taquiner qui tu veux quand tu es champion ! C’est bien ça mon Dan ?;)</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('denis-charbonneau', 'Denis Charbonneau', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Denis est comme un paon, en raison de ses parures majestueuses, tu ne peux le manquer au terrain. Le sourire à 100$, le George Clooney de LBMA. On m’a dit qu’ils ont arrêté les autobus de groupies au parc Jarry à cause que Denis les faisais toutes tomber dans les pommes avec ses fesses dans son pantalons de balle !!loll</p>
<p>Voici Denis Charbonneau</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ? J’ai joint cette superbe ligue en 1997 grâce à mon grand chum Bam, donc je jouerai ma 25e saison en 2022 (j’ai sauté une année en 2013 à cause d’une blessure)</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ? Tout d’abord, je n’ai jamais joué au baseball étant plus jeune, par contre, on jouait pour le fun au softball au camping à tous les jours. D’ailleurs, j’avais 15 ans quand j’ai joué dans une ligue organisée pour la première fois! C’était une ligue d’ados inter-campings et on jouait à la slowpitch (c’était très populaire dans les années 70....) Puis j’ai joué plusieurs années à la slowpitch et à la softball au Camping Rouville le week-end dans les années 70-80...c’est dans le temps qu’on faisait des tournois la gang de chums! Dans ce temps-là, Michel Forbes était un lanceur redoutable (aujourd’hui, il est meilleur au golf!). J’ai aussi joué dans différentes ligues de softball, balle-donnée et même fastball dans les années 80 et 90 à Montréal.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ? J’adore le coté défensif de la game, j’adore le coté stratégique de la game et j’aime aussi courir les buts (malheureusement, j’y vais moins souvent que j’aimerais...) mais surtout, j’aime retrouver les boys semaine après semaine!</p>
<p class="question">4.Quel est ton premier souvenir de baseball ? Prendre l’autobus avec mes chums pour aller au Parc Jarry! Ça coûtait 10 cents pour l’autobus et 50 cents pour voir la partie dans les estrades populaires!!</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ? Field of dreams....c’est le seul que j’ai vu!</p>
<p class="question">6.Quelle est ta citation de film préférée ? Go ahead, make my day....</p>
<p class="question">7.Quel est ton péché mignon ? Je peux-tu dire mon épouse ou ça fait têteux? Sinon pizza!</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ? Been there, done that!! Je laisse maintenant la place aux autres et on a quand même quelques candidats intéressants pour cet important rôle, je pense à Alex Bibeau entre autres.....C’est un rôle qui vient avec beaucoup de responsabilités, ça prend du leadership et on en a eu de très bons au fil des ans. Dans mon livre à moi, les 2 meilleurs coaches que j’ai eus sont les frères Blouin, 2 têtes de balle et surtout, 2 grands motivateurs!!</p>
<p class="question">9.Es-tu superstitieux ? pantoute</p>
<p class="question">10.Es-tu mauvais perdant ? C’est quoi être mauvais perdant? Je suis un gagnant donc je n’aime pas perdre......mais si je perds, je garocherai rien!!! En plus, ça fait longtemps que je n’ai pas ressenti la douleur de la défaite en finale.....tsé les Condors sont quand même champions depuis 2 ans alors je ne me souviens pas de rien d’autre!!!...hahaha</p>
<p class="question">11.Pratiques-tu d’autres sports ? Bien sûr! Golf, vélo, spinning, ski, marche ….je suis encore relativement actif....mais moins qu’avant!</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? Voir mes Amis, Jouer au Scrabble, jouer aux cartes</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ? Je peux-tu en nommer deux?Johnny Bench et Gary Carter</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ? Ma plus grande réussite est de continuer à me débrouiller quand même pas pire malgré les années.....:-)</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? Devine?de très loin, c’est la position de receveur que je préfère, tu ne peux pas être plus dans la game qu’à cette position-là!</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Bon défensivement, très moyen au bâton et bon pour courir les buts.......mais surtout, je suis toujours prêt à donner mon maximum!!</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? Oui! Je prendrais l’autobus pour y aller et je m’assoirais dans les bleachers (mais chu pas mal certain que ça me coûterait plus que 0,60$)!</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Aucun, ça donne des boutons sur les foufounes</p>
<p>Crémeuse ou Traditionnelle ?Traditionnelle</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Expos</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou Hiver ?Les 2</p>
<p class="question">Pizza avec ou sans ananas ?Mets-tu des kiwis sur ton spagatte?</p>
<p>Canadiens ou Nordiques ?Habs all the way mais je souhaite un retour des Nordiques</p>
<p>Sage ou tannant?Je m’adapte!!</p>
<p>Chien ou chat ?aucun</p>
<p>Viande ou végé ?viande</p>
<p>En bas de laine ou en bas de zéro ?C’est la même chose! S’il fait en bas de 0, on porte des bas de laine!</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Il est pas mal toujours plein, je deviens insécure s’il est à moitié!!</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Finale de la coupe Stanley mais je serais probablement autant excité si on était en série mondiale!!</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? Lever 7h00, 2 cafés en jouant au scrabble, game de golf, game de balle ou marche en forêt puis souper avec mon épouse et/ou mes amis, dodo minuit</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ? Dans notre ligue, je crois important de regarder au-delà de la performance sur le terrain; bien sûr les performances et les chiffres sont importants mais il y a beaucoup plus! Est-ce que le récipiendaire représente bien les valeurs de la LBMA? Leadership, attitude, esprit d’équipe, engagement, plaisir etc il y a des noms qui reviennent année après année et c’est bien ainsi! J’ai entièrement confiance aux membres de l’Exécutif pour faire les bons choix!</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? Il y en a plein avec qui je n’ai jamais joué! mais s’il y en a un avec qui j’aimerais rejouer, année après année, c’est mon chum Stef Beaudoin</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Dans le temps, bien sûr! Maintenant, mes chums qui ne jouent pas déjà dans la ligue sont tous rendus trop vieux ahahah</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Ouais, je n’ai pas joué la saison 2013 car je m’étais fracturé la cheville en ski.....</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? Solide! Les membres de l’exécutif (Mike, Pat, Bob, Stef et Serge) sont tous des gens complètement engagés au succès de la ligue; ils sont un bon exemple pour tous quand on parle d’implication....</p>
<p class="question">25.Quel est ton point fort à la balle ? Il y a quelques années, je t’aurais dit les coups filés; maintenant je te dirais mon jeu défensif (chu encore pas pire😊)</p>
<p class="question">26.Quel est ta faiblesse ? Mon coup de bâton; ça toujours été ma faiblesse! Ça fait 47 ans que je joue et je n’ai jamais été un bon cogneur!!!</p>
<p class="question">27.Comment te prépares-tu avant un match ? Je suis très méthodique! J'installe mon équipement à la clôture dans l’abri et au bout du banc des joueurs, le plus près possible du marbre, puis je mets mes spikes, mon jack, mon gant de frappeur main gauche et je pars courir et m’étirer pour 5-10 minutes, quand tout ça est fini, si mon lanceur est prêt, je vais me réchauffer avec lui</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Je joue à la position de receveur depuis plus de 30 ans, je suis relativement mauvais ailleurs dans le losange😊mais j’ai aussi joué au champ extérieur au début de ma carrière donc je me débrouille bien au champ mais tant que mes genoux me permettront de *catcher*, je le ferai!!!!</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Parce que chu beau! Je porte le titre de Miss LBMA, le plus bel homme de la ligue! Tu me veux dans ton équipe!</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Jouer pour un autre 5 ans......</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? Nous sommes en 2000 ou 2001, je joue avec mon chum André Dandurand qui est mon lanceur, nous sommes à nous réchauffer sur les lignes de côté, je ne porte pas de masque bien évidemment; on connait tous la vélocité de la rapide de Bam, je sais qu’il va me lancer une rapide, c’est son dernier pitch de réchauffement...mais la balle arrive un peu plus haut que je prévoyais et *tip* le bout de ma mitaine pour finir sa course sur mon arcade sourcilière.....pi là, le sang qui coule à flots, hôpital, points de suture etc....je vous rappelle qu’il y avait pas de frappeur, on est en réchauffement! J'en ai entendu parler longtemps de celle-là!</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. Je te dirais que ça dépend de qui est au cercle d’attente...si t’as besoin d’un coup sûr absolument pour garder la menace vivante, je te dirais Pat Chartrand ou André Dandurand, si t’as besoin d’un gars qui va la colisser de l’autre bord, Dave Asselin ou Pat Blouin</p>
<p class="question">33.Quel genre de coéquipier tu es ? J'aime que tout le monde donne son 100%, comme moi je le fais; si tu le fais, je vais toujours t’encourager....si tu te traînes les pieds, je vais aussi te le dire....</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? J'oublie complètement ce sport!</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? En partant du fait que le ketchup va avec un seul plat, le pâté chinois, il me semble, à moins que tu en aies mangé avant d’arriver au parc, qu’il ne devrait pas y avoir d’impact sur le nombre de buts volés; par contre, pour la moyenne de puissance au bâton il est important de verser le ketchup sur la portion de droite dans l’assiette (idéalement en forme de losange) pour éviter qu’un simple ne puisse être transformé en double. Pour ce qui est de la proximité des buts, plus ils sont proches, plus l’affaire est ketchup!</p>
<p>Denis est un maudit bon Jack, j’espère pouvoir mieux le connaitre dans le futur.</p>
<p>Denis à jouer 24 saisons dans la LBMA ,499 parties jouer (16eall time) 1450 apparitions au bâton, 517 coups sûrs (28eall time) 455 points comptés (16eall time) 276 points produits, 83 sacrifices (3eall time) et une moyenne à vie de 0.357</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('dominic-deschenes', 'Dominic Deschênes', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<h3>Avec Dominic Deschenes</h3>
<p>J’ai été choisi pour jouer avec les Harfangs cette année et j’y ai fait de belle rencontre. Dès le départ, dans notre groupe privé Facebook, j’ai été intimidé, mais non pas par Monsieur Hammarrenger !J’avais hâte à la première pratique et effrayé en même temps. Je ne savais pas à quoi m’attendre. En bout de ligne, je suis juste un joueur de balle après tout !</p>
<p>Mon prochain entretien est avec un gars qui s’entraine fort et qui fait du « fucking » Iron Man. Tsé, moi le gars qui est essoufflé à attacher mes spikes ! Pendant que je bouffe un cheeseburger avec poutine, lui il court, nage et fait du vélo !!</p>
<p>Dominic Deschenes</p>
<p class="question">1.D’où vient ce désir de torturer ton corps avec ce triple sport ?</p>
<p>Après avoir perdu environ 100 lbs en 2014, je me suis mis à la course en 2015 pour maintenir mon poinds. Après quelques années de course à pieds, j’ai fait mon premier marathon en Arizona. Je voulais un plus grand défi. Je me suis donc mis au triathlon. Depuis, j’adore. Les trois sports m’offrent une variété super intéressante et me permettent d’entretenir mon corps.</p>
<p class="question">2.Tu as surement une discipline en béton, décrit-moi une journée d’entrainement ?</p>
<p>Une journée typique d’entraînement débute avec la natation dès 6h, entre 2000 et 2500 mètres ou une seance de musculation d’une heure. Important de rester actif tout au long de la journée avec la marche. En soirée, ou la course à pieds (10km) ou du vélo (40-50km). Souvent, lors de la journée vélo, on y insère aussi une seance de Yoga.</p>
<p class="question">3.Tes parents étaient-ils des sportifs ?</p>
<p>Du tout!</p>
<p class="question">4.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>J’ai débuté en 2001 et mon chum Denis Charbonneau m’a fait decouvrir la ligue. Merci Denis!</p>
<p class="question">5.Raconte-nous ton parcourt de balle au travers des années ?</p>
<p>J’ai joué au baseball mineur jusqu’au niveau midget A. Ensuite, j’ai joue dans des ligues de garages pendant plusieurs années avant de joindre la LBMA en 2001.</p>
<p class="question">6.Explique-nous ta passion pour ce sport ?</p>
<p>C’est le plus beau sport. On y sollicite autant l’intellect que le physique. Le sport d’ailleurs que lorsque vous êtes en offensive, l’équipe adverse a le contrôle de la balle…. Pensez-y!</p>
<p class="question">7.Quel est ton premier souvenir de baseball ?</p>
<p>Mes parents m’avaient acheté une marionnette de Youppi…. Maudit qu’il était beau!</p>
<p class="question">8.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Moneyball. On y ressent toute l’émotion, le plaisir et la complexité de ce sport.</p>
<p class="question">9.Quelle est ta citation de film préférée ?</p>
<p>Un classique : not over until it’s over!</p>
<p>Ou la citation de Joël Youngblood lors du tournage d’un court métrage jamais publié : when at bat, hit hard, run fast and turn left!</p>
<p class="question">10.Quel est ton péché mignon ?</p>
<p>Popcord ou cacahouète en regardant un match de baseball</p>
<p class="question">11.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Si on évalue que je puisse répondre aux attentes d’un entraineur, bien sûr!</p>
<p class="question">12.Es-tu superstitieux ?</p>
<p>Dans la vie en général, non. Sur un terrain de baseball, oui!</p>
<p class="question">13.Es-tu mauvais perdant ?</p>
<p>Avec l’âge vient la sagesse…. De moins en moins!</p>
<p class="question">14.Pratiques-tu d’autres sports ?</p>
<p>Triathlon, golf, ski de fond</p>
<p class="question">15.En dehors du sport, as-tu d’autre passion ?</p>
<p>Les voyages, bon temps entres amis, apprendre à connaître d’autres cultures. Je suis curieux de nature!</p>
<p class="question">16.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Derek Jeter</p>
<p class="question">17.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Grand chelem en séries à mes débuts dans la LBMA.</p>
<p class="question">18.Quelle est ta position préférée … au baseball ?</p>
<p>Ouffff, j’ai eu peur! 2ebut.</p>
<p class="question">19.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Ma description est bien différente d’il y a quelques années : mobile, polyvalent, joeur d’avant-champs, aimant avoir du plaisir sur un terrain de ball!</p>
<p class="question">20.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Bien sûr! Ce n’est pas une question de oui ou non, c’est une question de quand!</p>
<p class="question">21.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Pepsi</p>
<p class="question">Crémeuse ou Traditionnel ?</p>
<p>Traditionnelle</p>
<p class="question">Sucré ou Salé ?</p>
<p>Sucré</p>
<p class="question">Café ou Thé ?</p>
<p>Café</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Red sox</p>
<p class="question">Bière ou vin ?</p>
<p>Les deux!</p>
<p class="question">Été ou Hiver ?</p>
<p>Été, été et été!!!!</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Sans! Ouache!</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Nordiques</p>
<p class="question">Sage ou tannant?</p>
<p>Tannant</p>
<p class="question">Chien ou chat ?</p>
<p>Chien</p>
<p class="question">Viande ou végé ?</p>
<p>Végé</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p>En bas de laine</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>Rempli à moitié de sa capacité</p>
<p class="question">Finale de la coupe Stanley ou Série Mondial ?</p>
<p>La question ne se pose même pas : Série Mondiale all the way!</p>
<p>Un peu de sérieux…</p>
<p class="question">22.Pour toi une journée parfaite c’est quoi ?</p>
<p>Juste equilibre entre du temps pour moi, atteindre mes objectifs et avoir du bon temps avec les gens que j’aime.</p>
<p class="question">23.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Toute que question…. Les plus méritants bien sûr, mais d’abord et avant tout, les gens démontrant l’attitude recherchée par la LBMA. Nous sommes tous des ambassadeurs de cette magnifique ligue. Comme le disait Otis Nixon après un vol de but contre les Braves, Your attitude defines your altitude.</p>
<p class="question">24.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Michel Plante</p>
<p class="question">25.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Sans hésiter!</p>
<p class="question">26.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Oui, cet été…. Mollet droit…..tendon d’Achile….</p>
<p class="question">27.Comment tu perçois l’avenir de la LBMA?</p>
<p>Très positivement. Nousndevons toutefois asseoir rapidement les bases d’une relėve au sein de l’exécutif.</p>
<p class="question">28.Quel est ton point fort à la balle ?</p>
<p>Attitude et leadership</p>
<p class="question">29.Quel est ta faiblesse ?</p>
<p>Autre que les lanceurs gauchers, mon explosion n’est pas top!</p>
<p class="question">30.Comment te prépares-tu avant un match ?</p>
<p>J’ai ma routine échauffement que je fais no matter what. Toujours ma gourde d’eau et d’électrolytes avec moi, ainsi qu’une barre Clif que je mange une bouchée à la fois entre chaque manche.</p>
<p class="question">31.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>2ebut, et j’aimerais essayer lanceur</p>
<p class="question">32.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p class="question">Parce que…. Je peux partager une maxim par match?</p>
<p class="question">33.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Avoir du plaisir. Aider à la continuité de la ligue.</p>
<p class="question">34.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>À titre de coach, luxation du ménisque droit… trop de graines de tournesol!</p>
<p class="question">35.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>JC Dionne, Christian Schiller</p>
<p class="question">36.Quel genre de coéquipier tu es ?</p>
<p>Bonne question… je pense être ok? Team player.</p>
<p class="question">37.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>À l’occasion, mais je n’oublie pas ce sport….jamais.</p>
<p class="question">38.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Ben non! Moutarde, relish, coleslaw. Merci bonsoir!</p>
<p>Voilà un peu l’histoire de Tony Stark !!! Euh…. Mr Iron Man. Dominic a joué sa 13esaison l’an dernier avec un cumulatif de 220 parties jouées, 182 coups sûrs et 0.319 de moyenne à vie.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('edgar-garcia', 'Edgar Garcia', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire Edgar Garcia</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?C’est ma première année et c’est JC Dionne qui me l’a fait connaitre.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?Du plaisir et de belles rencontres</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?L’esprit de camaraderie</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?Une partie des Expos de Montréal</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?Aucun</p>
<p class="question">6.Quelle est ta citation de film préférée ?Aucune</p>
<p class="question">7.Quel est ton péché mignon ?Les gâteaux</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?oui</p>
<p class="question">9.Es-tu superstitieux ?oui</p>
<p class="question">10.Es-tu mauvais perdant ?oui</p>
<p class="question">11.Pratiques-tu d’autres sports ?oui</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?mon épouse (elle m’a obligé)</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?Moise Alou</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?Avoir remporté 4 trophées dans la même saison</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?Lanceur</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?Passionné et rigoureux</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?Je le souhaite</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?aucune</p>
<p>Crémeuse ou Traditionnelle ?traditionnelle</p>
<p>Sucré ou Salé ?Sucré</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Yankees</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?sans ananas</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?Tannant</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?A moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Finale de la coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?Jouer à la balle et gagner</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?Aucune idée</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?Jérémy Jean Lachapelle</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?oui</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?Prometteur</p>
<p class="question">25.Quel est ton point fort à la balle ?Chaque lancé est très important pour moi</p>
<p class="question">26.Quel est ta faiblesse ?mon épouse</p>
<p class="question">27.Comment te prépares-tu avant un match ?Sérieusement</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?Lanceur, 2ieme but</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?Parce que je suis un joueur d’équipe que l’on gagne ou l’on perde je suis toujours là !</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?Etre joueur de l’année</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?aucun</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.JC Dionne</p>
<p class="question">33.Quel genre de coéquipier tu es ?Qui encourage (oui mon homme!)</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?Oublie complètement le sport</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?Extrêmement important lol</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('felix-hetu', 'Félix Hétu', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire général</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>-Depuis cette année, Stéphane Hétu</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>-Je n’ai jamais joué dû au hockey, mais maudit que j’aurais aimé.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>-J’adore le sport en général, mais plus précisément toutes les différentes stratégies et surtout le travail d’équipe qu’on peut voir et entendre sur le terrain.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>-Allez au Expos avec mon père.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>-Moneyball, un film magnifiquement réalisé et qui fait comprendre tous les aspects du sport.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>-Le Scotch et les cigares.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>-Oui, mais ça va me prendre pas mal plus de knowledge!</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>-Oui</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>-Oui</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>-Oui, tous les sports.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>-La psycho sportive</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>-Vladimir Guerrero</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>-Avoir un impact positif avec les Faucons dans la LBMA</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>-Catcher</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>-Rapide, constant, peut surprendre à tout moment.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>-Non</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Cokeou Pepsi ?</p>
<p class="question">Crémeuseou Traditionnel ?</p>
<p class="question">Sucréou Salé ?</p>
<p class="question">Caféou Thé ?</p>
<p class="question">Yankeesou Red Sox ?</p>
<p class="question">Bière ouvin?</p>
<p class="question">Été ouHiver?</p>
<p class="question">Pizza avec ousansananas ?</p>
<p class="question">Canadiensou Nordiques ?</p>
<p class="question">Sage outannant?</p>
<p class="question">Chienouchat?</p>
<p class="question">Viandeou végé ?</p>
<p class="question">En bas de laine ouen bas de zéro?</p>
<p class="question">Ton verre est àmoitié pleinou à moitié vide ?</p>
<p class="question">Finale de la coupe Stanleyou Série Mondial ?</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>-En autant que je puisse jouer au hockey, à la balle ou au golf!</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>-Je ne connais pas toutes les catégories, mais j’y vais pour Myles for MVP!</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>-J-C Dionne!</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>-Bien sûr!</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>-Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>-Prospère et avec beaucoup de plaisir!</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>-Ma vitesse et ma force physique.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>-Mon knowledge de la game.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>-Petite course, étirements, lancer et catcher la balle.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>-Catcher, et 1erbut.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>-Tu ne seras jamais déçu et tu auras toujours mon maximum!</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>-Tout faire pour aider mon équipe à gagner.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>-Il n’y en pas eu encore!</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>-Eric Collard</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>-Très amical et chercher toujours à rendre les autres meilleurs!</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>-Je vais surement continuer à aller frapper quelques balles.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>-Je crois que le ketchup dans les hot-dogs ça aide à faire des coups de circuit.</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('francis-lachapelle-st-onge', 'Francis Lachapelle St-Onge', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Francis Lachapelle</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>C’est ma première année dans la ligue et c’est Jérémie Jean-Lachapelle qui m’a initié à la ligue.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Mon père ma transmis sa passion pour ce si beau sport à l’âge de 5 ans. J’ai joué 15 saisons de baseball en tout, toutes dans la catégorie B sauf à la fin. Avec mon surplus de poids comparé aux autres je dominais en tant que lanceur. J’ai joué aussi au champ extérieur comme tout le monde mais souvent au 2ebut et au 3ebut.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Cest un sport que tout le monde peut jouer qui rassemble la famille au complet et qui est unique. Il n’y a pas de chronomètre donc ça finit quand ça finit et c’est ce qui rend ça intéressant. La plupart vont trouver ça long et plate mais c’est une partie d’échecs. C’est très stratégique et chaque joueur est important.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>C’est vague parce que j’avais 5 ans hahaha mais sinon je vais toujours garder en souvenir quand mon père m’emmenait aux expos. Je suis tombé en amour avec le sport mais aussi avec ma ville natale et j’étais fier d’être représenté par les expos de Montréal. S’ils reviennent un jour je vais pleurer c’est sûr hahaha</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Moneyball parce c’est vraiment une belle représentation que tout est possible au baseball. C’est un sport très difficile et la saison est très longue pour les joueurs. Il est parti de rien et a monté le classement avec sa stratégie et personne n’y croyait.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>< how can’t you be romantic about baseball ?></p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Je dirais les chips et les desserts hahaha je peux finir un sac en une soirée. Sinon j’aime les courbes hahahah</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Oui pourquoi pas. Je connais bien mon baseball et en mes capacités à montrer aux autres tout en ayant du fun.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Non</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Non</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>J’ai joué au football au secondaire sinon quand j’étais jeune j’ai essayé le karaté et le judo. Mais j’ai toujours aimé les sports en général surtout en éducation physique à l’école.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Je suis chanteur hahaha dans le style crooner genre Frank Sinatra, Elvis ou micheal Bublé. Je chante depuis toujours ça me fait du bien.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Je vais dire Vladimir Guerrero Sr, parce que c’est lui que j’ai vu jouer en grandissant. Son fils est tout aussi spectaculaire et talentueux sinon plus.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>J’ai été au championnat pronvincial à 3 reprises avec mon équipe et j’ai gagné la médaille d’argent une fois.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Je vais dire lanceur au baseball. Pcq c’est la première année que je joue au softball et ce n’est pas la même chose. Sinon je dirais 2ebut et premier but que j’essaye pour la première fois de ma vie et j’aime ça.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je suis un joueur d’équipe qui est là pour ses coéquipiers, je suis un joeur défensif mais qui est capable de faire des bons contacts au bâton. Le problème c’est la constance, je n’ai pas toujours le focus je dois rester dans le game de temps en temps.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Mais bien sûr et je vais acheter des billets c’est certain je vais être tellement heureux! Je vais pleurer.</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Coke</p>
<p class="question">Crémeuse ou Traditionnel ?</p>
<p>Traditionnelle</p>
<p class="question">Sucré ou Salé ?</p>
<p>Les deux mais plus sucré</p>
<p class="question">Café ou Thé ?</p>
<p>Café</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Red Sox</p>
<p class="question">Bière ou vin ?</p>
<p>Bière</p>
<p class="question">Été ou Hiver ?</p>
<p>Été</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Sans ananas</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Canadiens</p>
<p class="question">Sage ou tannant?</p>
<p>Sage</p>
<p class="question">Chien ou chat ?</p>
<p>Chat</p>
<p class="question">Viande ou végé ?</p>
<p>Viande</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p>Je ne comprends pas la question mais j’ai toujours chaud en tout cas hahahaha</p>
<p>Ton verre est à moitié plein ou à moitié vide ? Ça dépend de ce que je vis mais en général il est à moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ? Série mondiale</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>C’est de me lever avec un sentiment de bien-être de réaliser que je suis chanceux je suis bien entouré je suis en santé. J’ai mon chat à côté de moi et ma blonde que j’aurai éventuellement hahahah je passe la journée avec soit mes amis, ma blonde ou ma famille et je fais ce que j’aime faire. Ça ne m’en prend pas beaucoup pour être heureux.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>La saison 2021 je n’étais pas présent donc je ne peux me prononcer mais cette année je ne sais pas trop hahaha.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>J’aimerais bien jouer avec Jérémie lachapelle étant donné que c’est un ami et collègue aussi. Et aussi mon père et mon oncle qui veulent s’inscrire dans la ligue l’année prochaine.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Oui, c’est une belle ligue avec des bonnes personnes qui partagent la même passion. Je me suis senti accueilli dès le début.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Non je n’ai jamais été blessé gravement.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Je prévois que la ligue va continuer longtemps. Il y a déjà une relève pour les membres plus âgés et les exécutifs. C’est bien organisé comme ligue.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Je vais dire mon jeu défensif. J’ai un bon gant en général malgré du cafouillage à l’occasion. Sinon au bâton j’ai un bon swing vu ma carrure. Je me considère un bon atout pour n’importe quelle équipe.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Mon manque de constance et mon manque d’attention. Avec mon TDA j’ai tendance à être dans la lune et je peux créer des erreurs à cause de ça.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Je n’ai pas vraiment de rituel à part courir un peu pour me réchauffer et me lancer avec quelqu’un.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Je joue souvent au premier but avec mon équipe mais j’aimerais bien essayer lanceur.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je me donne toujours à 100% de mes capacités. S’il fait vraiment chaud elles descendent comme tout le monde hahaha mais je suis persévérant. Je connais mon baseball quoi faire avec la balle et même sans la balle. Je vais tout faire pour le bien être de l’équipe.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Je suis présentement une cote 2 dans la ligue et j’aimerais bien me rendre à la cote 3 ou 4. Je suis confiant de mes aptitudes et de ce que je peux apporter à une équipe.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? Faire un mauvais relais ou bien la balle passe entre mes jambes en dessous de mon gant. Manquer des jeux de routine m’embarrasse.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Vu c’est ma première année je me fis sur ce que j’ai vu et je vais dire JC Dionne hahaha</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Je suis vraiment là pour mes coéquipiers j’encourage souvent. Je félicite comme j’aide ceux qui ont plus de misère. Je vais communiquer beaucoup pour qu’on exécute bien les jeux.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>J’y vais quand je peux oui et maintenant que j’ai une auto je vais y aller plus souvent.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Le ketchup est primordial dans un hot-dog. Je ne comprends même pas pourquoi ce n’est pas dans les hot dog all dressed hahahah</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('gino-ciarlo', 'Gino Ciarlo', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous présente Gino Ciarlo;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Je crois que j'en serai à ma 12e saison 1/2. Alors que je jouais au football avec les Blouins, Stef m'a demandé si j'étais intéressé à jouer au softball. Comme j'avais peu joué (j'ai surtout joué au bizball), j'ai répondu oui, mais dans le champ.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Comme tous les flos de ma génération, j'ai commencé vers 5-6 ans. Je mangeais ma mitte et me jouais dans le nez au parc Ovila-Pelletier dans Hochlag. J'ai joué Mosquitos pour St-Barnabé et j'ai lancé à ma 2e année. Nous avons ensuite déménagé dans Tétreaultville où j'ai joué Pee Wee pour St-Donat. Lors de ma 2e année Pee Wee AA, au tournoi du Parc La Fontaine, le meilleur ami (sic) de Scooter, Rodger "la graine de toast" Brulotte, m'a présenté aux entraîneurs d'Élites du Québec, J'ai donc joué Élites du Québec lorsque j'étais Bantam. Nous jouions contre du Midget AA...à Lachine. Je peux te dire que c'est loin en tabouaire de Tétreaulville...surtout que j'y allais à vélo. J'ai joué Junior Élite, avec Ville-Marie à ma 1ère année midget et j'ai joué dans des équipes professionnelles mineures en Floride...pour des pinottes. J'ai aussi joué quelques matchs Sénior.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J'ai beaucoup joué et beaucoup coaché. Je trouve que la balle est une "mind game" où tu dois toujours anticiper ce qui arrivera et porter une attention particulière aux petits détails. Tout doit être prêt dans ta tête avant que le lanceur affronte le frappeur.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>La crème glacée après les matchs que je jouais, mais surtout la 1ère game d'ouverture des Expos au parc Jarry, avec mon grand-père, où il faisait frette, tellement que je me suis gelé le bout du pénis. J'ai assisté à tous les matchs d'ouverture au parc Jarry, avec mon grand-père, mais je portais mon habit de skidoo. C'était vraiment sharp.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Bull Durham. C'est la vraie vie des minor leagues. Pas beaucoup d'argent, mais beaucoup de sexe et de bière.</p>
<p class="question">6.Quelle est ta citation de film préférée ?La dureté du mental</p>
<p class="question">7.Quel est ton péché mignon ?Pizza, pizza, pizza...mais pas d'ananas</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Aucunement, mais j'ai déjà offert de donner de mon temps à l'Exécutif</p>
<p class="question">9.Es-tu superstitieux ?Pantoute</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Non! Par contre, je déteste pratiquer un sport avec ou contre des gens qui se pognent le beigne ou qui chialent pour n'importe quoi. Si ça ne te tente pas, fais d'autre chose</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Comme je n'ai jamais voulu collectionner les nombrils, j'ai toujours essayé de faire du sport à tous les jours. Je dois par contre faire attention à mes genoux de réglisse. J'ai cessé la pratique de certains sports, mais je joue encore au tennis, au hockey, au badminton et fais du snow quelques fois par année...en portant des orthèses...comme à la balle</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>J'ai beaucoup voyagé (et le ferai après la COVID) et j'aime beaucoup la musique: U2, Bowie, The Cure, Sigur Ròs et, comme Bill, Tool et Rush. J'ai vu U2 dans 10 pays différents...et c'était toujours plus qu'excellent</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Greg Maddux, the Master. Trop intelligent le gars</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Pas comme joueur, mais comme coach. J'ai coaché Team Quebec à quelques reprises et j'ai coaché Team Canada au Championnat Mondial des Big Leagues à Fort Lauderdale en 80 ketchoze</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Lanceur, car tu es le Roi de la montagne. C'est toi qui décide, car tu as la balle dans la main avant que le jeu commence</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>J'essaye d'être toujours prêt et d'être un bon teammate. Je pense être bon en défensive, je suis lent, ne glisse pas, mais j'ai un bon gun</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?Non! Pas assez d'intérêt et d'argent</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Rootbeer</p>
<p>Crémeuse ou Traditionnelle ?Traditionnelle</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Thé</p>
<p>Yankees ou Red Sox ?Yanks, mais encore plus les As des années 70</p>
<p>Bière ou vin ?Les 2, mais ça dépend avec qui</p>
<p>Été ou Hiver ?Les 2, à l'extérieur</p>
<p>Pizza avec ou sans ananas ? Sans</p>
<p>Canadiens ou Nordiques ?Habs</p>
<p>Sage ou tannant?Ça dépend. Ça très mal commencé, mais on flétri avec le temps (ou ou où on réalise qu'on s'en va dans le mur)</p>
<p>Chien ou chat ?Chat for sure</p>
<p>Viande ou végé ?Les 2</p>
<p class="question">En bas de laine ou en bas de zéro ???</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondial ?World series</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?Une belle journée de retraite où je me lève et me dis: "Qu'est-ce que je fais aujourd'hui?"</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je ne connais pas toutes les catégories, mais j'y vais quand même:</p>
<p>MVP des séries: Stéphane Proulx: a dominé les frappeurs et a frappé quand c'était le temps</p>
<p>MVP de la saison: Eric Collard: excellent en déf et en off, rapide, clutch et excellent bizball IQ</p>
<p>Meilleure amélioration: Ali: frappe fort, bon bras, de mieux en mieux en déf, se déplace bien et comprend mieux la game</p>
<p>Meilleur lanceur: Stéphane Beaudoin: met la balle où il veut même s'il zippe moins</p>
<p>Meilleur en défensive: Jean-Christian Dionne: couvre du terrain, excellent bizball IQ, anticipe bien le jeu, excellent gun</p>
<p>Meilleur en attaque: Eric Collard: clutch et frappe la balle où il le veut</p>
<p>Recrue: Mathieu des Condors: s'est grandement amélioré tout au long de la saison et applique les conseils des vétérans</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?J'aimerais bien jouer avec Jean-Christian Dionne. Nous ferions un duo 2e but- shortstop à couper le souffle</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>De plus en plus. La ligue redevient amicale et familiale et le calibre augmente un peu. Il n'y a pas beaucoup de joueurs qui se prennent au sérieux...et c'est tant mieux. J'ai souvent raté des matchs de sports, mais pas de saison, à cause de blessures.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?J'ai été pas mal pété de partout: genoux, épaules, coude, doigts, poignets, mâchoire et tout le tra-la-la. Maintenant je prends Vie de velours, Crème Budwig, La'Kota et tout va bien mieux...</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Le calibre augmente et les familles reviennent. Donc, je pense que ça augure bien</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>J'aime anticiper le jeu et être prêt. Je pense que mes forces, dans la LBMA sont mon gun et mon bizball IQ</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Mes faiblesses sont ma lenteur (je ne glisse et ne plonge pas), ma difficulté à frapper la balle où je le veux et le terrain que je peux couvrir en déf</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>À 60 ans (et tout pété), tu n'as pas le choix de t'étirer avant et après les matchs. Je ne vais pas frapper des balles, mais je lance contre des joueurs midgets (habituellement) en hiver</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>J'aime bien l'infield à la softball, mais je préfère, et de loin, être le Roi de la montagne au bizball</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Un coach qui souhaite avoir du plaisir, prendre une bière, avoir un joueur fiable, performer (sans nécessairement gagner) et jouer du inside softball a tout intérêt à me repécher</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?Avoir du plaisir pendant et après les matchs</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>À mon 1er pitch chez les pros, 1 retrait, bases loaded, grand slam. J'étais devenu le roi déchu de la montagne</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Christian Schiller ou The Bammer Dandurand. Patrick Blouin en 3e</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Je suis un teammamte sur qui on peut compter. J'encourage beaucoup et suis prêt à aider...mais pas coacher.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>La balle en hiver se joue à Cuba, en Floride, en Californie et en République dominicaine. Vive le hockey l'hiver</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?Vive la moutarde baseball...même si ça pue.</p>
<p>Gino est à sa 12e saison complètes, 227 parties jouées, 306 coups surs, 215 points produits avec une moyenne à vie de 0.430</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('giovanni-de-michele', 'Giovanni De Michele', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire Giovanni De Michele</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>2022, c’est Jean-David Michaud</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai joué dans ma jeunesse</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’aime le baseball</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Match des Expos</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Field of dreams</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>If they built it, they will come</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?Non</p>
<p class="question">9.Es-tu superstitieux ? Non</p>
<p class="question">10.Es-tu mauvais perdant ? Non</p>
<p class="question">11.Pratiques-tu d’autres sports ? Oui, Football avec des amis</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? Non</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ? Gary Carter</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ? Aucun exploit</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? 2ebut</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Intense</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? non</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ? Coke</p>
<p>Crémeuse ou Traditionnel ? Traditionnel</p>
<p>Sucré ou Salé ? Sucré</p>
<p>Café ou Thé ? Café</p>
<p>Yankees ou Red Sox ? Red Sox</p>
<p>Bière ou vin ? Biere</p>
<p>Été ou Hiver ? Hiver</p>
<p>Pizza avec ou sans ananas ? Sans</p>
<p>Canadiens ou Nordiques ? Canadiens</p>
<p>Sage ou tannant? Sage</p>
<p>Chien ou chat ? Chien</p>
<p>Viande ou végé ? Viande</p>
<p>En bas de laine ou en bas de zéro ? En bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ? Moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ? Série Mondiale</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? Avec ma famille, surtout ma femme</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2022 de chaque catégorie et pourquoi ? ??</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? En croissance</p>
<p class="question">25.Quel est ton point fort à la balle ? Défensive</p>
<p class="question">26.Quel est ta faiblesse ? Vitesse</p>
<p class="question">27.Comment te prépares-tu avant un match ? Exercise</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Tous sauf lanceur</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Au-dessus de la moyenne</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Non</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? Aucun</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. JC Dionne</p>
<p class="question">33.Quel genre de coéquipier tu es ? Loyal</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? Oublie</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Oui</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('guyllaume-doyon', 'Guyllaume Doyon', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Un coéquipier de classe A, le gars a une volonté de fer. C’est un joueur d’équipe, encourage toujours ses confrères de jeu. C’est un gars qui arrive toujours à temps pour ses matchs, ce n’est pas de sa faute… maudit pont ! ;-)</p>
<p>Je vous présente Guyllaume Doyon;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>La saison dernière était ma 3eannée dans la ligue ! J’ai découvert la ligue en fouillant sur internet.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai commencé à jouer très tard dans ma vie et j’ai découvert ce sport quasiment par accident. Donc quand tu ne sais pas jouer en défense, on te place au champ droit. Disons que je n’ai pas trop choisit ma position hahaha. À ma première année, on m’a fait jouer au 3ebut et j’ai adoré ! J’espère pouvoir jouer à temps plein à cette position ! (Je dis ça, je ne dis rien😊)</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Même si j’ai découvert ce sport-là tard dans ma vie, j’ai réalisé, après avoir commencé à jouer dans la ligue, que mes films de jeunesse préférés étaient tous des films de baseball. Pour vrai, j’adore ce sport et je suis déjà en manque de jouer. C’est le sport pour lequel, je veux vraiment travailler à devenir meilleur et que je veux me perfectionner.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Je vais sûrement avoir la réponse la plus bizarre de tes entrevues, mais comme je l’ai dit plus tôt, j’ai découvert le baseball assez tard dans ma vie et par accident. Je suis un ‘’gamer’’ depuis tout petit et j’ai découvert le sport en jouant à MLB The Show 15. J’ai commencé à y jouer et j’ai tout suite aimé le sport. Par la suite mon ancien boss, Charles, m’a dit que la compagnie pour lequel je travaillais dans les temps, organisait un tournoi de balle-molle pour ramasser des fonds pour les enfants malades. Il ma donner une place sur l’équipe et j’ai joué mon premier match à vie à 25 ans. La minute d’après, je me suis inscrit dans une ligue de balle-molle et me voilà !</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Le petit champ (The Sandlot) Je le réécoute encore aujourd’hui ! La nostalgie !</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Avec de grand pouvoir vienne de grandes responsabilités (Spiderman)</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Les charcuteries en général. C’est probablement ça qui va me tuer ! hahaha</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p class="question">Oui, mais j’ai clairement encore tellement de choses à apprendre sur la game. Un jour peut-être ?</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Non, pas du tout</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Cela ne me dérange pas de perdre, mais je déteste être mauvais dans un match… Je travaille encore ça chez moi. Le problème c’est que je suis très exigeant envers moi-même.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>NHL 22 ça compte tu ? hahaha Je fais du vélo, sinon va falloir que je décide à être plus actif l’hiver et me trouver un autre sport.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Je suis un passionné de politique, de jeux-vidéo et de sport en général. Je suis aussi un gros mélomane surtout que j’ai fait de la musique longtemps.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>David ‘’Big Papi’’ Ortiz, Quel extraordinaire joueur !</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Mon attrapé contre les condors en demi-finale😉</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>CLAIREMENT LE 3EBUT (Je dis cela, je dis rien)</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je pense être un bon coéquipier qui a à cœur d’aider son équipe ! Je vais toujours mettre l’équipe avant moi.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>J’y crois de moins en moins… Je ne suis pas super emballé par l’idée de la garde partagé</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnel ?Crémeuse</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Red Sox</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Je ne peux pas croire que des gens trouve la pizza hawaïenne est une bonne idée…</p>
<p>Canadiens ou Nordiques ?Canadiens (Le but d’Alain Coté n’était pas bon… hihihi)</p>
<p>Sage ou tannant?Sage</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Les deux</p>
<p>En bas de laine ou en bas de zéro ?En bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?À moitié plein et je veux remplir l’autre moitié</p>
<p>Finale de la coupe Stanley ou Série Mondial ?Série Mondial</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Il pleut, je fais du Netflix and Chill, je game et je soupe avec mes amis !</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je ne connais pas toutes les catégories, mais pour meilleur esprit sportif, il est grand temps que Pat Chartrand le gagne !</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Mes deux meilleurs amis Jonathan Latour et Mathieu Doré</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Oui, j’aime profondément cette ligue ! J’ai fait rentrer Jonathan et Mathieu et j’espère mon autre ami Maxime !</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Non, mais y’a 2 ans j’ai couru sur une jambe pratiquement la moitié de la saison à cause d’une blessure à la hanche.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Je suis convaincu que la ligue dura longtemps parce que la ligue est supportée par des passionnés du sport et de la ligue. L’esprit de famille qu’il y a dans la ligue ne se trouve pas ailleurs et pour ça elle restera toujours vivante.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>J’ai un bon swing au bâton, je n’arrive pas encore à frapper avec autant de régularité que je le souhaite, mais quand je la frappe, je frappe fort. !</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Je dois continuer de m’améliorer en défensive</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Je m’étire, je parle à mes coéquipiers en leur disant que le traffic est horrible à Montréal et je suis parti hahaha !!</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p class="question">Je joue surtout champ droit, mais je l’ai tu dis 3ebut ???</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je suis comme une Trump Card dans un alignement, car j’ai souvent tendance à faire connaitre de très bon match ou de très mauvais…</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Je veux juste continuer à me développer comme joueur et avoir du fun à jouer au baseball</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>J’en ai trop qui me viens en tête, mais juste cette année j’ai donné quelque beau moment cocasse de jeu un peu tout croche…</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Jonathan Desrosiers, pour vrai, il est hallucinant à voir jouer !</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Je suis toujours présent et je vais toujours penser à l’intérêt de l’équipe en premier. Je vais toujours encourager mes coéquipiers et tu vas toujours me voir célébrer les bons coups de l’équipe !</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Oui, normalement un mois avant le début de la saison</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Mes hot-dogs sont toujours All-Dressed</p>
<p>Guyllaume est à sa 3esaison,42 parties jouées, 149 apparitions au bâton et 49 coups sûrs. Avec une moyenne à vie de 0.315</p>
<p>C’est un maudit bon jack, il met tout son cœur et ses tripes au bâton, donne toujours ce qu’il a en défensive, mérite le respect de ses coéquipiers.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jason-dorrington', 'Jason Dorrington', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Vous savez, quand on dit qu’il ne faut pas se fier aux apparences, bien ici, j’ai un des plus beaux exemples. Quand j’ai vu ce colosse jouer à l’arrêt court faire un habile jeu de pied à sa droite et capter la balle et faire un lancer précis au 1er but, j’ai été impressionné !</p>
<p>Voici Jason Dorrington;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Je viens de finir ma deuxieme saison dans la LBMA, Joe Santo m’a fait découvrir la ligue. Ca fait plusieurs années que je joue contre lui dans une autre ligue. En parlant, il a su que je cherchais une ligue les vendredi soir.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai commencé il y a 30 ans (1991) à l’âge de 6 ans, mes parents m’ont demandé « baseball ou soccer », un choix très facile pour moi. Jouer dans les catégories élites toute mon enfance avec St-Leonard. Après mon stage Midget, j’ai tombé dans la balle molle, donc depuis 2003.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Impossible d’expliquer, C’est mon « safe place » dans la vie. Quand je suis sur le terrain ça me permet d’oublier tout les troubles et le stress auxquelles on fait face à tous les jours.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Les matchs des Expos au stade avec mon père. Les matchs de balle molle à mon père et mes oncles. Mon père à 7 frères, ils jouaient tous ensemble donc mes cousins et moi étaient toujours au parc pour les voir jouer. J’aurais adoré avoir la chance de jouer avec eux mais j’etais trop jeune encore quand ils ont pris leur retraite.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>The Sandlot, me fait penser à ma jeunesse, on jouait dans n’importe quel champ qui était libre, mais pour nous c’était toujours comme si on était au Fenway Park ou Wrigley Field.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Lefameuxspeech de Al Pacino dans Any Given Sunday</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Chocolate covered Almonds</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non, Je suis Coach/capitaine dans d’autre ligues, J’apprécie le fait que dans la LBMA je peux me présenter et juste jouer. Pas besoin de m’en faire avec les lineup et les remplacants.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Ouiiiiii … toujours mon bas gauche en premier, toujours mon soulier gauche aussi.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Non, mais j’hais perdre. Vous demanderez à ma blonde, j’suis pas plaisant sur le chemin de retour après une défaite. Je veux toujours gagner.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Golf, Je viens de prendre ma retraite du coaching au hockey après 20 ans de service. J’ai le privilège d’avoir entrainé 2 joueurs de la LNH, Daniel Sprong des Capitals de Washington (anciennement des Penguins et Ducks) et Jeremy Davies des Prédateurs (présentement dans AHL, et impliquer dans l’échange qui a envoyer PK Subban au New Jersey) ainsi que plusieurs autres qui sont en Europe ou encore dans la NCAA.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Les Jeux vidéo, le cinéma, la musique.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>J’en ai deux, Vladimir Guerrero (père) et Larry « Chipper » Jones, drôle qu’un fan des Expos aime un grand des Braves d’Atlanta mais j’ai toujours adoré voir jouer Chipper.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ? Participer à la grande finale du championnat provincial de Gatineau quand je jouais Midget BB. On a perdu 8-7 contre une équipe qui n’a pas perdu une game de l’année.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>3ieme but mais j’ai déjà joué les 9 positions et comme vu dans la LBMA, je suis prêt à jouer n’importe où sauf lanceur et catcher.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Un excellent joueur défensif, très confiant pour attraper des roulant ou des flèche avec un bon bras pour épingler des coureurs rapide. Capable de mettre la balle ou je veux quand les situations se présente. Un bon teammate.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Ceci est un grand rêve que j’ai. Il me manque tellement. À tous les étés avant la pandémie,je faisais un roadtrip pour voir les Blue Jays jouer (Detroit (4x), New York, Boston, Washington, Tampa) I miss baseball in Montreal soooooo much!!</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Dr. Pepper lol … Pepsi si je dois absolument choisir un des deux.</p>
<p class="question">Crémeuse ou Traditionnelle ?</p>
<p>Crémeuse</p>
<p class="question">Sucré ou Salé ?</p>
<p>Salé</p>
<p class="question">Café ou Thé ?</p>
<p>Ni un, ni l’autre, déguelasse</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Red Sox</p>
<p class="question">Bière ou vin ?</p>
<p>Bière, Je suis un bleu !</p>
<p class="question">Été ou Hiver ?</p>
<p>Printemps, la balle commenceJ</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Pas capable les ananas nulle part.</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Go Habs Go</p>
<p class="question">Sage ou tannant?</p>
<p>Tannant</p>
<p class="question">Chien ou chat ?</p>
<p>Je suis ZÉRO un gars d’animaux, ma sœur c’est malheureusement séparé après une longue relation avec deux enfants, j’ai dû garder son chien pendant sept mois, ça se terminait pas, J’suis juste pas capable. Je comprends les gens qui sont attachés à leur chien, mais pour moi, c’est juste non.</p>
<p class="question">Viande ou végé ?</p>
<p>viande, rien de mieux qu’un bon steak sur le BBQ</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p>en bas de zero</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>moitié plein</p>
<p class="question">Finale de la coupe Stanley ou Série Mondial ?</p>
<p>mettons, que depuis 1993, il y a juste une fois que je repondrais la coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Peu importe ce que je fais dans la journee, pour moi une journee parfaite se termine en voyant ma nièce (5ans) mon neveu (20 mois), une game de balle molle et une bonne bière froide.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ? J’suis pas prêt à choisir des favoris, j’pense que le recrue de l’année reviens sûrement à JC Dionne, sans rien enlever aux autres, il a tout simplement été incroyable toute au long de la saison, tant sur le terrain, que en dehors, Je suis fier de lui donner le titre de Rookie of year, après l’avoir gagné l’an dernier. Pour les autres, il y a plein de bons joueurs qui méritent de se faire reconnaitre. Je pense surtout à des gars comme Ali Sabrah qui a eu une saison spectaculaire en offensive.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Pendant 2 saisons, j’ai joué avec pas mal les mêmes joueurs, on était 9 qui ont joué dans les bleus pendant les 2 dernières saisons donc il en a plusieurs avec qui j’aimerais jouer ensemble et se connaitre encore plus comme chum et coéquipier. Vite, vite, les 2 premiers à me venir en tête seraient Eric Collard et JC Dionne, mais il y en a plusieurs d’autre avec qui je m’entends super bien au parc.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Absolument, sans aucun doute.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>La saison qui vient de finir, j’ai dû manquer une couple de game à cause de mon dos.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>J’espère que ça continue comme ça, Juste 2 ans mais honnêtement, j’ai toujours du plaisir, une grande famille la LBMA.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Joueur d’équipe, prêt à tout faire pour gagner. Ma défensive est à point. J’adore quand la balle est frappée vers moi et que la pression revient sur mes épaules de réussir le jeu nécessaire.</p>
<p class="question">26.Quel est ta faiblesse ? Ma vitesse.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>C’est bizarre mais j’aime ça juste resté seul avec moi-même, pas de lancer de pratique, pas de diamond. Je m’étire seul et j’suis prêt à jouer. Peut-être une superstition mais je trouve quand je me prépare en équipe, je joue mal.Très bizarre vu que je suis un gars d’équipe.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>3ieme but, je me sens tellement à l’aise quand la balle est frappé fort vers moi. J’aimerais jouer CG ou CD mais je n’ai pas la vitesse pour le faire.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je ne sais pas quoi répondre donc je vais prendre un passage d’un coéquipier qui a joué avec moi les 2 dernières années, que je respecte énormément et qui a prit le temps de tout dire ses pensées à propos des bleus après la grande finale.« Jason, tu es une vraie encyclopédie de la game. Autant comme joueur, coach, arbitre, partisan, coéquipier, tu excelles dans tout ce qui concerne la balle. Un gars intense, sûr de lui mais dur avec lui-même, tu vises toujours plus haut. Malgré ton caractère bouillant tu seras toujours derrière tes chums et tes coéquipiers et j’apprécie cette qualité de toi. J’adore jaser de sports avec toi et j’apprécie beaucoup te côtoyer sur le terrain et en dehors. »</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Gagner des championnats, je suis 2 en 2 dans la LBMA, la première fut partagée avec les gris. Très clair que Coach Ben Hammarrenger sait se construire des équipes gagnantes.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Je n’ai jamais été embarrassé sur un terrain, des erreurs, tous les joueurs en font. Il n’y en a pas de joueurs parfaits.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA?</p>
<p>JC Dionne ou Eric Collard, d’après moi, les 2 meilleurs joueurs de la ligue. J’aurais vraiment aimé voir jouer Stéphane Blouin dans son prime. 30 ans que je suis impliquée dans la balle et jamais j’ai rencontré un joueur aussi passionné et éduqué. Ce fut tellement un plaisir de jouer pour lui les deux dernières saisons et un grand honneur de faire partie de son dernier championnat dans la LBMA, il est un LEGENDE, First Ballot Hall Of Fame dans mon livre à moi.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Un joker, j’aime ça me détendre quand je suis au terrain, mais en même temps, je veux toujours gagner.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Il n’en est pas question d’oublier le baseball/softball. Je vais à la cage assez souvent, je joue aussi dans une ligue intérieure les Dimanche pendant l’hiver.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Ketchup, Mayo, Relish.</p>
<p>Jason a complété sa 2eannée dans la LBMA , 30 parties, 106 apparitions au bâton avec 49 coups sûrs. Une moyenne à vie de 0.462. Recrue de l’année en 2020 et co-joueur des séries 2020 avec Benoit Hammarenger.</p>
<p>On pourrait faire des blagues longtemps sur son poids, il ressemble plus à un lutteur qu’un joueur de balle, mais je jouerais volontiers à ses côtés ! J’aime mieux dire que c’est un grand joueur de balle.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jean-christian-dionne', 'Jean-Christian Dionne', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire général</p>
<p>Ça ne fait pas longtemps qu’il est dans la LBMA (seulement 1 an) et déjà tout le monde parle de lui.Non pas parce qu’il frappe comme un démon, ou qu’il est tout un joueur défensif.Ce n’est pas non plus parce qu’il ne dit jamais non pour remplacer (sauf le samedi matin à 08 :30), mais par son enthousiasme, sa bonne humeur, sa générosité.C’est un vrai gars de ligue, un diamant brut.</p>
<p>En plus, il faut qu’il fasse sa propre entrevue.J’ai nommé :</p>
<p>Jean-Christian elle est partie Dionne</p>
<p>J-C n’a pas fait son introduction, c’est Dart Vader</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Je suis flambant neuf de l’année 2021 et c’est mon chum Sylvain Longtin qui m’a parlé de la LBMA.</p>
<p class="question">2.Raconte-nous ton parcours de balle au travers des années ?</p>
<p>J’ai commencé à 5 ans à jouer, toutes mes petites catégories jusqu’au junior pour la même organisation, les Loisirs St-Stanislas. J’ai toujours joué dans le A jusqu’au junior.On m’a souvent offert d’aller dans le 2 lettres, mais faute de moyen de mes parents et aussi que je préférais jouer avec mes chums. 3 années juniors AA et une dizaine de matchs dans le junior élite comme frappeurs désignés. Quand on vous dit qu’à 21 ans qui faut laisser les plus jeunes jouer bien c’est ce que j’ai fait, j’ai laissé ma place. J’ai été 2 saisons à ne pas jouer du tout, mais j’ai profité un peu de la vie. La balle me manquait alors j’ai regardé les petites annonces et trouvé une équipe de balle dans Ahuntsic, pour le dépanneur Marcoux. Première expérience avec une grosse balle et de la 6-12 !!À 24 ans, plein d’orgueil et de fierté, pas capable de frapper une balle qui arrive comme un arc-en-ciel !!Avec un cardio de feu, des jambes rapides et un bras canon, ils m’ont gardé pour ma défensive. Quand j’ai finalement compris le truc pour frapper ce genre de lancer, ils étaient contents de m’avoir ! ;)Après cela, j’ai découvert la balle orthodoxe que je joue encore aujourd’hui avec vous. J’ai joué un peu partout, Ligue des Voyageurs, ligue de balle molle Anjou, Ligue des Diplomates, Ligues des Mordus, Ligue de Lorraine, ligue des bons voisins de Saint-Sulpice. Peut-être que j’en oublie et au travers de tout cela, les tournois de fin de semaine !!Pour ceux qui ce demanderais pourquoi autant de ligue ? J’ai souvent joué pour plus d’une ligue en même temps, ce n’était pas rare que je jouasse à 19h à Lucie Bruneau, Anjou et à 21h à Saint-Sulpice, rouler 130km sur l’autoroute pour arriver au moins en 2emanche à Saint-Sulpice.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Ça c’est dur pour moi à expliquer, je dirais que la balle c’est mon tout ! C’est la première chose que j’ai faite de bien dans ma vie et sans trop forcer, j’étais bon. Ce jeu m’ai venu naturellement étant jeune et avec les années, j’ai bien saisi les stratégies et la complexité qui met la balle dans un monde à part parmi les sports. C’est à cause de la balle que l’on a commencé à me respecter, à voir que j’existais. Tout tourne autour de la balle dans ma vie, ma blonde des 14 dernières années que j’ai connues sur un terrain, mes meilleurs et plus vieux amis sont des chums de balles, mes plus beaux souvenirs sont de la balle. La balle n’est pas juste une passion chez moi c’est le centre de mon univers ! Vous ne me croyez pas…. Prenez 5 minutes pour jaser à ma blonde.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Vous allez capoter !On me l’a raconté, car j’avais 3-4 ans avant que je commence à jouer. J’étais devant la télé et les expos jouaient. J’étais fasciné par l’arbitre au marbre. Je ne comprenais pas comment cet homme faisait apparaitre des balles dans ses poches une fois que le frappeur frappait des fausses balles !!C’est un magicien ! Moi quand je lançais une balle fallait que j’aille la chercher après ! Non, lui, les faisait apparaitre dans sa poche ! Ouin je sais c’est spécial comme souvenir, mais c’est mon premier !</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>En réalité, j’en ai 3, les « bads news bears » la version originale avec Walter Matthau, premier film de balle que j’ai vu.« Hardball / l’enjeu » avec Keanu Reeves, rien de spécial, mais un film touchant et « The Natural » avec Robert Redford, qui n’a pas rêvé de frapper une balle dans les spots.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Le baseball c’est romantique !Moneyball</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Une bonne pièce de viande au BBQ,une bonne pointe de pizza bacon oignon, du homard frais en mai, une bonne lasagne que ma mère fait, les côtes levées du défunt Bar-b-Barn, un steamé all dress après une pratique ! Je suis gourmand.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non ! Car à chaque fois que je l’ai fais, l’équipe passe avant moi, je connais des saisons de marde, car je ne fais que penser au bien être de l’équipe, les Line-ups, ou placer les joueurs, les stratégies à opter contre certaines équipeset j’en passe. Je deviens désagréable envers moi-même et ma conjointe vit avec mon côté Hyde ! « Jekyll et M. Hyde ».Juste comme exemple, regardez tout ce que je fais présentement pour la ligue et je n’ai même pas été mandaté à faire quoi que ce soit.Alors non je ne veux pas être entraineur.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Un peu, pour moi l’été dernier c’était une première de frapper avec les bâtons que la ligue fournie. J’ai eu de la misère à me décider à choisir. J’aime beaucoup mes bâtons personnels.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>En partant je déteste perdre, je crois que personne sur la planète va faire son sport favori en se disant « allons encore perde ce soir ça ne me dérange pas ! » Ok, vous avez raison, le Canadien pense comme ça, mais …. Loll !!Ce que je veux dire, perdre un match en 7emanches 4-3 j’ai aucun problème avec ça. Perdre 14-2 parce que l’équipe ne se concentre pas sur ses jeux à faire ou sont trop nonchalant, je bouille à l’intérieur. J’ai toujours dit qu’il y avait une manière de perdre, la deuxième option je ne l’aime pas.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Je n’ai pas confiance aux autres sports, je pourrais me blesser et m’empêcher de jouer à la balle ! C’est qui le cave ? Pelleter, manger, dormir, me lever le matin sont des sports extrêmes alors….</p>
<p class="question">12.En dehors du sport, as-tu d’autres passions ?</p>
<p>Oui, je suis aussi fan des super héros, films, BD, figurines. Pourrais me ruiner facilement.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toutes époques confondues ?</p>
<p>Elle est très dure pour moi cette question, car au départ ce n’est pas moi qui devais y répondre !! J’en ai trop aimé pour en avoir seulement un. Mes premiers Amours, Carter, Raines, Dawson, Wallach et Cromartie . La deuxième vague, Grissom, Walker, Lansing, Alou père et fils, Pedro, Rojas et Wetteland.Lenny Dykstra pour sa fougue sur le terrain, Ken Griffey Jr pour le plus beau swing et swag du baseball, Derek Jeter pour l’homme de classe qu’il est et bon ambassadeur pour le sport. Aujourd’hui c’est Mike Trout mon joueur préféré. J’aime bien aussi Fernando Tatis Jr, bourré de talent, bon vendeur pour le sport, mais juste un peu trop cocky pour moi !</p>
<p class="question">14.Quel est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>J’en ai 2, j’étais Bantam en tournoi à Sherbrooke, j’ai lancé un match d’un coup sûr. Le 2ec’est en 2017 dans la ligue de Lorraine un dimanche après-midi de journée caniculaire comme je les aime, j’ai frappé 5 en 5 dans une victoire de mon équipe 19-10. 4 circuits et un double pour 11 points produits. C’est une journée qui allait très bien.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>À la minute que je pose les pieds sur un terrain de balle, je suis dans mon élément, j’ai joué à toutes les positions. Mes préférées sont 2ebut et arrêt-court.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je suis polyvalent, peu importe, ou je vais jouer, je ne ferais pas mal à mon équipe. Je donne mon 110% à chaque moment, même après un 6ematch dans la même journée !! (Hein monsieur Longtin). Je suis un leader silencieux, je laisse mes frappes et mes jeux défensifs donner du pep à mes coéquipiers. Je suis un compétiteur sain, une force tranquille, j’ai un très bon bras, je ne suis pas le plus rapide, mais je sais bien courir les buts, j’analyse beaucoup le jeu et j’ai un sens de l’anticipation élevé.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Je le souhaite de tout mon cœur, je n’aime pas l’idée de garde partagée, car comme avec un enfant, un des 2 parents va payer pour que l’autre s’en tire mieux !!</p>
<p class="question">18.Questions en rafales…ouff… ce n’était pas destiné à moi ces questions-là …loll</p>
<p class="question">Coke ou Pepsi ?</p>
<p>En réalité, moi tout ce qui a des bulles et sucré… J’adore !!</p>
<p class="question">Crémeuse ou Traditionnelle ?</p>
<p>Crémeuse</p>
<p class="question">Sucré ou Salé ?</p>
<p>Si ça se mange sucré ou salé, je le mange !</p>
<p class="question">Café ou Thé ?</p>
<p>Café</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>2 magnifiques équipes que je respecte, mais qui s’achètes des championnats, alors pas eux ! J’ai un faible pour notre belle jeune équipe des Blue Jays, très le fun à regarder jouer. Mais si nous avons un retour des Expos, ce sera eux mon équipe.</p>
<p class="question">Bière ou vin ?</p>
<p>Comme je le dit toujours, je suis déjà mêlé sans alcool alors ….Mais oui des fois je prends un bloody cesars, un verre de vin que je vais siroter jusqu’à la fin d’un repas juste pour dire qui a quelque chose dans ma coupe. Une bière froide si mon équipe passe une série à une autre ! Des fois, ça motive les troupes.</p>
<p class="question">Été ou Hiver ?</p>
<p>Été bazouelle !J’ai tu l’air d’un pingouin !!</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Pouvez-vous croire que c’est un Canadien qui a inventé ca la pizza Hawaïenne !! Mais on comprend, car c’est un Ontarien en 1962 !!Quelle cave !!</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Ramenez-moi les Nordiques que je puisse faire encore plus chier les fanfanes du Canadien !En réalité, je regarde le hockey, car y a rien à tv l’hiver. Mais j’aime mieux le hockey que les téléromans de matante, les occupations doubles, la voix, les stars académies de ce monde.</p>
<p class="question">Sage ou tannant?</p>
<p>Plutôt sage, mais peut être crissement tannant aussi !!</p>
<p class="question">Chien ou chat ?</p>
<p>Chien !Ça ne sert à rien un chat !</p>
<p class="question">Viande ou végé ?</p>
<p>Vive la viande ! Je vous laisse le gazon les végés ! Un de mes futurs hamburger va avoir fait caca dans votre salade!</p>
<p class="question">En bas de laine ou au-dessous de zéro ?</p>
<p>En bas de laine, je vous ai déjà dit que je n’aimais pas l’hiver !</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>Eh bien, pour être parfaitement honnête, à mon humble avis, bien sûr, sans offenser quiconque qui pense différemment de mon point de vue, mais aussi en examinant cette question dans une perspective différente et sans condamner ces opinions et en essayant de les objectiver et en considérant l’opinion valable de chacun, je crois honnêtement que j’ai complètement oublié ce que j’allais dire.</p>
<p class="question">Finale de la coupe Stanley ou Série Mondial ?</p>
<p>Je déteste les séries de la coupe Stanley, car il y a toujours des bozos qui veulent faire annuler des matches de balles, car leur équipe est en série !!</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Déjà me réveiller à chaque matin c’est déjà une bonne journée ! La balle est un facteur important dans ma vie. Que ce soit une game de saison le soir, que je me lance dans ma cour au printemps avec ma blonde, que je vais voir des chums jouer ailleurs à l’autre bout de la planète ! Un feu dans ma cours, un repas avec ma fille, soirée entre amis, un nouveau film de super héros qui sort. Arrêter dans un parc et regarder des ti-bout jouer à la balle.</p>
<p class="question">20.D’après toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>J’ai placé cette questions ici pour savoirs ce que vous en pensiez !! Je ne connais même pas les catégories !!</p>
<p>Et pas beaucoup de monde se mouille dans cette réponse!</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Bien j’ai eu la chance de remplacer dans toutes les équipes l’été dernier, je veux bien continuer sur cette lancée. Pour l’instant je suis neutre à cette question, attendons encore une couple de saisons pour être plus objectifs.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Oui certainement, j’ai déjà un chum qui devrait venir lancer l’an prochain !</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Claquage à une cuisse, 2-3 semaines sans jouer, une pierre au rein, une semaine. La même journée que j’ai pissé la pierre (douleur incroyable que je ne souhaite à personne) j’ai mis mon uniforme et suis allé au parc. J’étais sur le line-up mais ma blonde n’était pas d’accord que je joue ! J’ai quand même un ballon-sacrifice en fin de match comme frappeur remplaçant !</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Je crois que les gens en place font que cette ligue est en santé, tant et aussi longtemps que les joueurs suivront et continueront à maintenir cette esprit de famille tout en étant dans une compétition saine. Ca ne peut que bien aller !</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Mon sens de l’anticipation du choix de lancers de mes adversaires et aussi en défensives. J’ai un bon bras, un bon coup de bâton. Comme le jus d’orange je suis concentré.</p>
<p class="question">26.Quelle est ta faiblesse ?</p>
<p>Je suis toujours de bonne humeur alors me faire rire est facile ! Ma patience au bâton aussi.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>J’arrive toujours tôt à mes matchs, plus souvent qu’à mon tour, je regarde tous les matchs de la soirée même si je me dis que je vais rester pour 2-3 manches. Avec le temps, j’ai compris qu’il fallait m’étirer plus si je voulais continuer à jouer longtemps encore. Et beaucoup de lancer de réchauffement.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Ma position naturelle est le 2ebut, j’aime beaucoup l’arrêt court. J’ai été voltigeur longtemps, car dans les clubs que je jouais, il n’y avait pas de place pour moi dans le diamond ! J’aurais aimé lancer à l’orthodoxe, autant j’ai un bon bras par-dessus, autant que par en dessous, j’ai plus l’air d’un joueur de poche !</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Pour ma constance, connaissance du jeu, ma polyvalence, je vais te faire gagner plus de matchs que d’en faire perdre. Je suis un joueur d’équipe qui va trainer tout le monde du même bord.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Gagner le dernier match de l’année; c’est beau d’être champion de la saison, mais pour moi ça ne veut rien dire. Le dernier trophée lui est plus important. Rester en forme et pas me blesser.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>J’en ai 2, mon premier, junior AA première année, coureur au premier but, aucun retrait, je suis au bâton, le coach au 3ebut me fais des signaux, (Faut savoir ici que j’ai la mémoire d’un maringouin encore aujourd’hui) me demande l’amortie, le lancer … balle, le coureur se fais presque retirer au premier. Une autre série de signaux, même chose, l’amortie est demandé. Le lancer boum ! Circuit de 2 point !! En contournant le 3ebut, mon coach me dit « ce n’est pas ce que j’ai demandé ! »Devant tous les autres il me dit, « Dionne sur le banc, Ranger tu prends sa place »! Outch l’égo !Mon 2emoment, je suis champ gauche à la balle molle, la balle est frappée dans l’allé entre moi et le champ centre, ont cours comme des lapins pour atteindre la balle, vous savez la balle impossible à attraper, eh bien, hop je pogne la balle comme Kevin Pillard !! Le superman dive !Le frappeur suivant me frappe une chandelle, j’ai 2 pas à faire devant moi, bing, la balle touche mon gant, tombe par terre !Je souris comme Allard avant de remettre la balle à l’arrêt court. À la fin du match sur quoi on m’a parlé vous croyez !</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Très humblement, je vous dirais moi, car je veux être là à ces moment-là. Collard est un choix logique, mais mon choix s’arrêterait sur Pat Chartrand. Je ne l’ai jamais vu avoir une mauvaise présence au bâton et il place la balle ou il veut. Pas obliger d’y aller avec la puissance, mais le coup sûr opportun.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>J’ai un sentiment d’appartenance énorme envers mon équipe, je suis prêt à jouer partout, je suis plutôt silencieux comme coéquipier, mais je dis ce que j’ai à dire. Je vais encourager jusqu’au dernier lancer même si on se fait rincer. Je vais donner des conseils à qui veux bien les entendre, je suis très exigeant envers moi-même et j’ai appris avec les années à ne plus l’être pour mes coéquipiers. J’ai une bonne humeur contagieuse, je ne me prends pas au sérieux dans la vie, juste sur mon jeu que je suis sérieux. Je suis un joueur d’équipe avant tout même si parfois j’ai tendance à prendre l’équipe sur mes épaules. J’ai le surnom d’Hollywood, mais je n’aime pas trop le Spotlight ! La balle c’est un sport d’équipe avant tout, mais souvent ce sont des jeux individuels qui font la différence.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Je respire la balle, messieurs, alors oui. Cette année je joue ma première année dans une ligue intérieure, c’est magique. Par le passé et pour plusieurs années j’avais une passe hivernale à coups sur à Laval. Je frappais 300-400 balles par semaine.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>C’est bizarre dans mon cas, un hot dog rôtie ca me prends ketchup, moutarde, oignons mais dans un steamer all dress jamais de ketchup !</p>
<p class="question">Question de Martin Lambert, Joue-tu avec ou sans jack strap ?</p>
<p>À la balle-molle, je joue sans.</p>
<p class="question">Question de Sébastien Marchand, combien de championnat de frappeur et de séries as-tu remportés ?</p>
<p>Je n’ai jamais fini premier dans une ligue au bâton, très souvent dans les 5 premiers. Et j’ai un championnat seulement en série dans la ligue de Lorraine en 2016. Quelques-uns au baseball mineur, mais je ne pourrais vous dire quand !</p>
<p class="question">Question de Keith Beauregard, D’où sors ta volonté de t’impliquer à 200% comme tu le fais ?</p>
<p>C’est quelque chose qui me viens tout seul, je l’ai fait dans toute les ligues et équipes avec qui j’ai joué. Premièrement, je le fait car j’aime ça ! Pour avoir été dans quelque comité, des idées nouvelles qui viennent de l’extérieur sont toujours les bienvenues. Pas toujours facile de plaire à 60 ou 120 grand enfants ! J’ai beaucoup d’imagination, aussi des fois, faut que ça sorte ! J’aime faire plaisir, je suis serviable de nature. Quand j’aime, je donne. De plus, j’en profite autant que vous. En passant, si vous avez des idées pour la ligue, que vous croyez qu’elles pourraient être un plus à la LBMA, faut pas ce gêner et le mentionner au comité.</p>
<p>Question de Sylvain St-George, quelle est ta vision à toi pour la LBMA ? Par exemple aimerais-tu que l’on forme nos arbitres ? Ou tout autre changement qui pourrait augmenter encore plus l’esprit de famille de cette superbe ligue ?</p>
<p>Je crois que la LBMA a une très bonne fondation, les gens du comité qui ont à cœur la ligue et une soixantaine de boys qui jouent pour le plaisir avant tout. Oui, il y a place à des améliorations, des règlements à révisées peut-être, genre les bas blancs !! ;)J’ai vu que dans le passé, il y avait plein d’activités qui se faisaient au parc, BBQ,tournois de balles, etc. Toutes des activités qui pourraient revenir si les boys se donnent la peine de participer. Le succès d’une ligue tissée serré, c’est de participer à ces évènements et pas toujours les même 12 personnes. Pour la question des arbitres, oui c’est une bonne idée par contre encore une fois faudra que les boys sois indulgents envers ses personnes qui vont donner de leur temps. Ne pas croire qu’ils font du favoritisme. Ce sont des êtres humains avant tout. Avec la pandémie, ça été compliqué partout d’avoir des arbitres. Peut-être que cet été 2022 ça iras mieux.</p>
<p class="question">Question de David Monette, quels sont votre ou vos surnoms à la balle ?</p>
<p>Pour commencer, j’ai eu le surnom JC dès l’âge moustique. Mon entraineur était anglophone et dire Jean-Christian lui faisait mal au visage ! À mes débuts à la balle molle, j’ai eu le surnom de Pirate, car je jouais souvent en tournoi avec un bandana. Dernièrement, c’est Hollywood, car j’ai souvent le spot light sur moi pour un jeu ou une bonne frappe. (Sans vouloir la gloire et pas parce que je suis une vedette…Hollywood…sans prétention !);-)</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jean-christophe-noel', 'Jean-Christophe Noël', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Le spaceman (Bill Lee) des Harfangs, celui qui apporte ses plats de pâtes pour ses fringales d’après matchs. Celui qui apporte son hamac pour une sieste entre deux matchs. Un joueur polyvalent qui a de la musique dans la tête car il danse en défensive !</p>
<p>Monsieur Jean-Christophe Noel;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Depuis la saison 2016. C’est Alain Moro qui m’a fait entrer dans la ligue.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Avant la LBMA, j’avais joué seulement deux étés en quelque part au primaire. L’été dernier, j’ai fait mes débuts dans laLigue de softball Montréal.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>On est dehors, c’est relax et intense à la fois, on est en équipe. C’est un état d’esprit général ponctué de vives émotions. Lancer, attraper, frapper, courir. Faire un jeu. Wow. Les petits détails.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Aller voir les Expos avec ma grand-maman.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Moneyball. C’est le seul que j’ai vu.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Dur à dire...</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>La poutine.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Je ne pense pas, non.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Non, mais je trouve que les routines d’avant-match sont importantes. Pour se préparer le corps et l’esprit.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Je ne pense pas. J’espère que non en-tout-cas.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Oui, je cours, je joue au tennis et je fais de la planche à neige. Je joue un peu au golf.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Oui, notamment le camping et le plein-air, la lecture (littérature, essais et bds) et les jeux de société.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Gary Carter</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Bonne question. Je pense que je m’améliore de saison en saison. Globalement, je dirais que c’est ce que je considère comme ma plus grande réussite. C’est motivant et c’est encore mon objectif en vue de la prochaine saison.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>2ebut. On reçoit pas mal de balles, on doit bouger beaucoup et les jeux à faire sont variés. On a plus de temps de réaction qu’au 3ebut. J’ai adoré lancer aussi, et je souhaite obtenir quelques départs au monticule l’été prochain !</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je pense que je suis un joueur d’équipe. La bonne ambiance et l’esprit d’équipe sont très importants pour moi et je cherche à y contribuer. J’aime encourager mes coéquipiers. J’essaie de toujours donner mon 110% et quand je fais une erreur ou manque un jeu, ça me fait chier pour vrai.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Bonne question. Je l’espère de tout coeur, mais je serais surpris que ça arrive. Dans la prochaine décennie du moins.</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Aucun des deux.</p>
<p class="question">Crémeuse ou Traditionnelle ?</p>
<p>Traditionnelle.</p>
<p class="question">Sucré ou Salé ?</p>
<p>Salé.</p>
<p class="question">Café ou Thé ?</p>
<p>Café.</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Red Sox</p>
<p class="question">Bière ou vin ?</p>
<p>Bière.</p>
<p class="question">Été ou Hiver ?</p>
<p>Les deux.</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Sans ananas.</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Les Canadiens.</p>
<p class="question">Sage ou tannant?</p>
<p>Les deux.</p>
<p class="question">Chien ou chat ?</p>
<p>Chats!</p>
<p class="question">Viande ou végé ?</p>
<p>Les deux.</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p>Je ne comprends pas la question.</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>Ça dépend du point de vue du moment.</p>
<p class="question">Finale de la coupe Stanley ou Série Mondial ?</p>
<p>Finale de la coupe Stanley.</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Je pense que ça n’existe pas. J’en ai beaucoup de très belles, par contre ;)</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Hum... Il y a plusieurs excellents candidats... ;)</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Pat Chartrand.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Oui, bien sûr.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Je dirais pas grave, mais un claquage au mollet m’a fait manquer environ 3 semaines.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Dur à dire. Ça va dépendre de ceux qui reprendront le flambeau...</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Les simples frappés au 3ebut ;)</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Frapper au champ extérieur (attention, j’y travaille!).</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Beaucoup de réchauffement et d’étirements. De la course légère et des sprints. Se lancer la balle. Le classique, quoi!</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>2ebut, 3ebut.Champ gauche des fois. J’aimerais lancer.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Voir les réponses aux questions 10, 14, 15 et 16.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>M’améliorer d’une saison à l’autre.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Me faire retirer parce que je pensais que le jeu était arrêté et que je ne touchais pas mon but (1reannée, un relais du catcher Olivier Martin au 3ebut). Je me suis promis que ça m’arrriverait juste une fois.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Jean-Christian Dionne, c’est un joueur exceptionnel dans une équipe ordinaire ;)</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Voir question 16.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Oui, quelques fois. Je vais aussi prendre des cours pour lancer!</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Je ne comprends pas la question. Ce que je peux dire, c’est que du ketchup ça ne va pas dans un hot-dog.</p>
<p>JC Noel est à sa 6esaison, 105 parties jouées, 360 apparitions au bâton avec 147 coups sûrs. Une moyenne à vie de 0.408.</p>
<p>Monsieur Noel est un cadeau en soit, tu vois l’emballage mais tu ne connais pas le contenu. Le parfait exemple du joueur talentueux, naïf et sympathique.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jean-david-michaud', 'Jean-David Michaud', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Jean-David Michaud</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>1èresaison, Site web et média sociaux</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Déjà joué 1 saison dans le même genre de ligue il y a 10 ans approximativement</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Toujours eu un intérêt pour ce sport particulièrement lorsque les Blue Jays ont fait les séries en 2014…ce fut un sport que j’ai découvert sérieusement.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Dernier match que j’ai été voir les Expos contre les Braves. C’était déjà 1-0 pour les Braves lorsque je me suis assis à mon siège et le match a fini 9-0 je crois (2 coups surs dans le match complet pour les Expos)… une dégelé reçu et ce fut le triste sort de notre équipe dans les dernières années de leur existence.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Babe Ruth… bien fait ce film et bon acteur</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non, je n’ai pas de connaissanceet mes réflexes de joueur ne sont pas au rendez-vous.</p>
<p class="question">9.Es-tu superstitieux ? Oui, j’ai plusieurs routines et superstitions qui m’accompagnent cette saison.</p>
<p class="question">10.Es-tu mauvais perdant ? Non, pas tant que ça mais un orgueil quand même !</p>
<p class="question">11.Pratiques-tu d’autres sports ? Hockey</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? Oui, Hockey, les voyages, le cinéma, l’entrainement et le jardinage.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ? Un double et quelques attrapés spectaculaire dans une autre saison.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? Champs gauche mais l’arrêt court serait aussi une position que je désire essayer.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? rapide, spectaculaire, coriace, compétitif</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? Certainement</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ? Pepsi</p>
<p>Crémeuse ou Traditionnel ?Crémeuse</p>
<p>Sucré ou Salé ? Salé</p>
<p>Café ou Thé ? Café</p>
<p>Yankees ou Red Sox ? Aucun, c’est 2 clubs que je déteste qui s’achètent des championnats à chaque année</p>
<p>Bière ou vin ? Vin</p>
<p>Été ou Hiver ? Été</p>
<p>Pizza avec ou sans ananas ? Sans</p>
<p>Canadiens ou Nordiques ? Nordiques</p>
<p>Sage ou tannant? Tannant</p>
<p>Chien ou chat ? Chien</p>
<p>Viande ou végé ? Viande</p>
<p class="question">En bas de laine ou en bas de zéro ? ??</p>
<p>Ton verre est à moitié plein ou à moitié vide ? Plein !</p>
<p>Finale de la coupe Stanley ou Série Mondial ? Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? Accomplissement de mes objectifs personnels réussi</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ? N/A</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Bien sûr</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? oui mais pas très grave</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? Ça serait intéressant d’ajouter 2 autres équipes</p>
<p class="question">25.Quel est ton point fort à la balle ? Courir</p>
<p class="question">26.Quel est ta faiblesse ? Le bâton</p>
<p class="question">27.Comment te prépares-tu avant un match ? Entrainement à coups sur à laval, étirements et échauffements standards</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Champs mais aimerais essayer arrêt court</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Rapidité, polyvalence et compétitif… toujours bien préparé</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Oui, être au milieu de peleton au bâton et être fiable défensivement, aider l’équipe, ne pas nuire</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? Frustration après une mauvaise présence au bâton</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. JC Dionne des Vautours</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Agréable je crois, je tente d’établir un bon lien avec chacun de mes coéquipiers et cela même dans une saison difficile</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? Oui je me pratique</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Certainement, je suis maniaque du Ketchup !</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jonathan-desrosiers', 'Jonathan Desrosiers', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Monsieur Desrosiers est un des plus rapides sur un terrain mais pas pour remplir une entrevue …;)</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Ca fait quelques années déjà, environ 5 ans et c’est Sylvain Lamontagne qui mis a introduit.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai joué au baseball toute mon enfance de 5 ans à 15-16 ans,J’ai compris que c’était la fin, en fait une « fin », après avoir été retranché du midget AAA. Avec raison, je n’étais pas de calibre hehe ! Le deuil a été assez long à faire, je ne voulais même plus assister à des parties de mes amis ou aller jouer pour le fun durant plusieurs années. J’ai repris contact avec le sport - mais la balle molle cette fois - il y a environ 8 saisons en jouant dans la ligue des voyageurs notamment.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?Le sentiment de liberté et d’être à l’extérieur durant les belles soirées d’été. J’ai toujours apprécié l'esprit d’équipe et de camaraderie du baseball vs le hockey.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?Les petits uniformes de l’ABAJ</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Feverpitch avec Jimmy Fallon. C’est une comédie romantique, mais c’est vraiment bon haha</p>
<p class="question">6.Quelle est ta citation de film préférée ?(son de criquet)</p>
<p class="question">7.Quel est ton péché mignon ?(se regarder dans le miroir) ;-)</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?oui !</p>
<p class="question">9.Es-tu superstitieux ?Un peu, mais pas tant hehe</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>C’est une bonne question; probablement un peu. En fait, je déteste perdre mais j’aime tellement ce sport que ça passe rapidement.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Je joue au golf l’été, au dek hockey l’hiver et j’aimerais beaucoup reprendre le tennis à l’année longue.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>C’est difficile d’en choisir un seul, je dirais Biggio, Maddux et Pedro Martinez. J’étais trop jeune pour apprécié Carter, mais il aurait été assurément un de mes préférés.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Ma principale fierté, c’est d’avoir atteint la finale de la LBMA à plusieurs reprises et d’avoir gagné 3 championnats.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?2eme but.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Joueur plutôt défensif, qui fait contacte régulièrement avec la balle et qui aime être agressif sur les buts.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Beaucoup moins c’est temps-ci, malheureusement…</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi Esti !!</p>
<p>Crémeuse ou Traditionnelle ?Traditionnelle</p>
<p>Sucré ou Salé ?les 2</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Red Sox (fuck les Yankees)</p>
<p>Bière ou vin ?Vin (j’entends déjà les bleues rire de moi)</p>
<p>Été ou Hiver ?Été fuck l’hiver</p>
<p>Pizza avec ou sans ananas ?Sans ananas !</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?Sage</p>
<p>Chien ou chat ?Chien, fuck les chats !</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En bas de laine en télétravail dans le sous-sol</p>
<p>Ton verre est à moitié plein ou à moitié vide ?À moitié (ou précisément sa quantité relative)</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? (son de criquet)</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ? (son de criquet)</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?Stéphane Beaudoin</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Définitivement, méchante belle organisation</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Fracture du bras durant un été suite à une chute en roller hockey</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Certains défis comme le départ et le vieillissement (on ne peut y échapper!) de certains joueurs, mais il faut maintenir le cap sur les principes de la ligue comme l’aspect amical, la rigueur sur les horaires et le comportement sur le terrain, notre magnifique parc Jarry, etc</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Ma compréhension du jeu; positionnement défensif et les décisions à prendre sur les buts.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>La puissance au bâton. On peut tu avoir de nouveaux bâtons pour compenser :P</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Petit jogging, étirements des jambes et réchauffement du bras avec des lancers à différentes distances</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Arrêt-court et receveur. J’aimerais joueur au 3eme but, je pense que ça serait bien! Sinon ma position naturelle est le 2eme but</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Pour l’assurance que je donne toujours mon meilleur sur le terrain</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Non, mis à part gagner le gros trophée à la fin de l’année !</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Des hots dogs du Lafleur qui n’ont pas passés durant un tournoi mineur au parc Lafontaine, j’ai dû manquer un tour au bâton!</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.Asselin ou Collard.</p>
<p class="question">33.Quel genre de coéquipier tu es ? (son de criquet)</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Je fais une coupure complète. Je reprends seulement quelques semaines avant le début de la saison, mais rien d’intense.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?Parle-pas de hot-dogs, je vais encore avoir la chiasse!</p>
<p>Joueur redoutable, hausse son jeu d’un cran en série, voici les statistiques de Jonathan. Il est à sa 7esaison, 120 parties jouées, 195 coups sûrs, 179 points comptés, 144 points produits pour une moyenne à vie de 0.495.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jonathan-latour', 'Jonathan Latour', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous présente Jonathan Latour;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Je suis entré dans la ligue avec mon coloc de l’époque Guyllaume Doyon en 2015</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai commencé à jouer à la balle à mon entré dans la ligue. L’année avant mon entré j’avais joué à la balle donnée mais j’étais catcher donc je n’ai pas fait grand chose cette année là pour que je la raconte</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’aime bien le fait que n’importe qui peux contribuer et que c’est un sport d’équipe et individuel en même temps</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Mon père m'a amené voir les expos dans leurs dernières années au stade olympique mais j’étais trop jeune pour bien comprendre la game…</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Le film Sandlot avec le gros chien qui avait en otage la fameuse balle</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>I have à machine gun ho ho ho (die hard, le meilleur film de Noël)</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Une bonne lasagne au smoke meat</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non même si j’ai bien aimé faire un line up cette année</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Oui, je prends toujours le même bâton si ça va bien et je mange la même chose le soir si j’ai eu une bonne game</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Non mais je n’aime pas perdre</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p class="question">Sport virtuel, ça compte tu ?</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Jeux vidéo, séries, films</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Je n’ai pas beaucoup suivi le baseball mais j’ai suivi le parcours des blue jays quand ils sont rendu loin et j’aimais bien Kevin Pillar</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Je dirais ma première présence au bâton contre les condors après mes 3 premières années avec eux, j’ai frappé un circuit intérieur sur la ligne contre Stéphane Beaudoin</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? Dans le champ</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Joueur rapide qui donne son max à tous les matchs</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? Oui et non</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnel ?Crémeuse</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Red sox</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?SANS</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?Sage</p>
<p>Chien ou chat ?Chien, même si j’ai un chat</p>
<p>Viande ou végé ?Viande, c’est quoi ça des légumes</p>
<p>En bas de laine ou en bas de zéro ?N’as pas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Verre à moitié</p>
<p>Finale de la coupe Stanley ou Série Mondial ?Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Les vacances, il fait beau et on fini avec une bonne game de balle avec de la bière après</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Mvp playoff Steph Proulx, recrue JC Dionne, le plus amélioré Mathieu Doré, esprit d’équipe Pat Chartrand</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?Mon ami Guyllaume Doyon</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Je voie cette ligue encore loin tant et aussi longtemps qu’il aura du monde dans l’exécutif qui font une aussi bonne job</p>
<p class="question">25.Quel est ton point fort à la balle ? Rapidité</p>
<p class="question">26.Quel est ta faiblesse ? Tête de balle</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Met mon équipement, je m’étire, je fais le tour du terrain en joggant et ensuite je lance la balle avec un coéquipier</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Dans le champ droit et gauche, j’aimerais bien être au centre un jour</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Joueur rapide, toujours de bonne humeur qui donne son maximum</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Devenir une meilleure cote</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>J’en ai trop pour en nommer</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Je prends Jason Dorrington qui élève son jeu d’un cran quand c’est important</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Encourage et j’essaye de trouver le côté positif même dans la défaite</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? Oui des fois</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Oui hot dog ketchup avec un peu de sel</p>
<p>Jonathan est à sa 6e saison, 133 parties jouées, 124 coups sûrs, 99 points comptés avec une moyenne à vie de 0.318</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jeremie-lachapelle', 'Jérémie Lachapelle', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous présente Jérémie Lachapelle :</p>
<p>Je dirais cette année, le circuit intérieur était assez satisfaisant!</p>
<p>3iem but … et pour faire plaisir à certain je commence à apprécier catcheur</p>
<p>Bien sûr! Mon guess serait de dire qu'il y aura une équipe à Montréal en 2028</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnel ?aucune beurk</p>
<p>Sucré ou Salé ?salé</p>
<p>Café ou Thé ?thé</p>
<p>Yankees ou Red Sox ?red sox</p>
<p>Bière ou vin ?bière</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Sans</p>
<p>Canadiens ou Nordiques ?Canadiens (trop jeune pour avoir bien connue les nordiques)</p>
<p>Sage ou tannant?Tannant plus jeune et un peu plus sage maintenant</p>
<p>Chien ou chat ?chien</p>
<p>Viande ou végé ?viande</p>
<p>En bas de laine ou en bas de zéro ?En bas de zéro</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Les deux, une après l'autre</p>
<p>Un peu de sérieux…</p>
<p>Très bonne question, je ne serais pas en mesure de répondre à cela, désolée!</p>
<p>Sois Éric Collard ou Pat Blouin, c’est sure qu'il la met l’autre bord sans pression</p>
<p>Bon fallait finir avec la meilleur question ! Je suis quelqu'un qui mange ses hot-dog juste ketchup et fromage, donc oui!! Il faut du ketchup dans les hot-dog!!</p>
<p>Fils du légendaire Jean Lachapelle, Jérémie est à sa 5e saison, 100 parties jouées, 87 coups sûrs pour une moyenne à vie de 0.311</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('martin-lambert', 'Martin Lambert', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Une autre recrue de la cuvée 2021 … une bonne année</p>
<p>Voici Martin Lambert,</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>L’été 2021 était ma première année. J’ai découvert la ligue par un concours de circonstance. Après plusieurs années d’inactivité, c’est en cherchant sur facebook que je suis tombé sur le groupe de la ligue. Après avoir harcelé Denis, j’ai reçu un coup de fil de Michel puisqu’un membre avait quitté à la dernière minute.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai joué toute ma jeunesse, alternant hockey l’hiver, baseball l’été. J’ai abandonné le sport pour des ‘’problèmes de santé’’ vers 17 ans. J’en ai aujourd’hui 36, et j’ai réglé ce qui avait à régler côté ‘’santé’’. Dans mon cas, la pandémie a été favorable, après 150lbs en moins, je peux enfin recommencer à m’amuser.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Comme beaucoup de p’tit gars, j’ai grandi avec le hockey et le baseball. Les fds aux expos étant plus accessibles, c’est au stade qu’on sortait en famille… entre hommes tsé !Mon grand-père mon père et moi. Sans doute mes plus beaux souvenirs.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Comme joueur, je jouais pour les Relishs de Montréal-est ! La thématique des équipes de couleurs, j’connais ça ! Les relishs, les ketchups, les moutardes hahaha</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Major League !! WIIIILD THING !!!</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Le script complet de slapshot !</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Jerky !! (Allô Bob !!!)</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non j’ai trop à apprendre ! Mais si un jour y’a un poste de mascotte…</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Très. Je soupçonne encore un gars d’avoir oublié sa p’tite carte de France d’Amour pendant les playoff ! En tk !!!! Les Aigles comprendront !</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Non</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Le poker, ça l’Air que c’est rendu un sport ! ;P</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p class="question">Ma job, ça comptes tu ?</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Ricky Vaughn</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>J’ai déjà été ami avec un arbitre ! :D</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>J’ai toujours aimé jouer dans le champ… quand j’avais mes deux chevilles ! hahaha</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Ponctuel LOL</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>J’aimerais beaucoup mais malheureusement, avec les terrains de balles transformés en terrains de soccer je vois mal comment le baseball reviendrait à Montréal sans susciter l’intérêt des jeunes pour l’avenir de la concession.</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Amène-moé un coke, un orangeade toute sauf d’l’ostie d’root-beer !</p>
<p class="question">Crémeuse ou Traditionnel ?</p>
<p>Crémeuse voyons</p>
<p class="question">Sucré ou Salé ?</p>
<p>Les deux en même temps !!</p>
<p class="question">Café ou Thé ?</p>
<p>Café</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Red Sox !!!</p>
<p class="question">Bière ou vin ?</p>
<p class="question">Yé ou l’Fort ???</p>
<p class="question">Été ou Hiver ?</p>
<p>Été</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Juste le fait de poser la question… je te juge !</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Dans la victoire comme dans les beaucoup de défaites, GO HABS GO !</p>
<p class="question">Sage ou tannant?</p>
<p>Toujours sage, voyons !</p>
<p class="question">Chien ou chat ?</p>
<p class="question">ATCHOUUUM !!! Hein ? Tu disais ?</p>
<p class="question">Viande ou végé ?</p>
<p>Faut savoir être ouvert dans la vie… Un bon frite steak !!</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p>Depuis 1 an, j’veux un onepiece en laine l’été svp !!!</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p class="question">Ça dépend, j’ai commencé à le boire ou j’viens de me l’verser ?</p>
<p class="question">Finale de la coupe Stanley ou Série Mondial ?</p>
<p>La coupe Stanley!</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Une journée d’été ensoleillée qui débute avec un bon café, une game de balle, un BBQ pour souper et un feu avec un drink pis du Barry White pour finir la soirée 3:)</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Peu importe qui remportera quoi, je ne connais pas personne qui ne mérite pas de félicitations et de reconnaissance dans cette ligue-là ! Vous êtes beaux et bons les gars peu importe le p’tit chiffre qu’on nous donne !</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? 2021 étant ma première année, je ne pourrais pas dire. Une chose est certaine c’est que chacun de mes coéquipiers de cette saison-ci, y’en a pas un avec qui je ne voudrais pas être en équipe une seconde fois.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Mets-en !!!</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>À ma première pratique dans la LBMA je me suis fait une entorse à la cheville qui m’a suivie toute l’année. La course et la rotation des hanches au bâton rendait mon expérience un peu douloureuse. Heureusement j’ai ‘’pogné’’ un bon deal sur le duct tape qui m’a servie d’attelle durant la saison hahaha !!!</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>À écouter les vieux d’la vieille parler du passé de la ligue, sachant que les gars qui forment le cœur de la ligue sont là pour longtemps encore, je n’ai pas d’inquiétudes pour l’avenir ! Les ingrédients du plaisir, de la compétition, de la confrérie, de l’entraide et j’en passe, quand tu mélanges ça ensemble, ça peut juste donner une bonne recette ! Pas comme tes ananas sur ta pizza -_-</p>
<p class="question">25.Quel est ton point fort à la balle ? J’fais fitter mes gants avec mes spikes aux couleurs de ma chemise ? ou Mon retard sur mon swing qui fait que je frappe inverse ! hahaha !!!</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Mon retard sur mon swing qui fait que ma moyenne au bâton monte dans le sens … inverse !</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Faut savoir ou on va souper après entre boys ! Ben important pour la préparation du match !</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Dans le champ. Si non, un jour j’ai le fantasme de lancer… Mais bon, la sécurité avant tout ! M’a rester dans l’champ ! hahaha</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je pense être un bon gars d’équipe qui encourage tout le monde (même si on n’a pas la même couleur de chemise). J’aime qu’on puisse tisser des liens entre coéquipiers. Je suis persuadé qu’avec la santé, je puisse être en mesure d’aider mon équipe à gagner et à avoir du plaisir.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>À long terme je dirais de toujours avoir du fun et que mes boys en aient aussi en ma présence. À court terme et plus personnel je dirais, être plus compétitif.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Probablement ma glissade inutile sans finesse au marbre cette année ! J’suis trop vieux et trop lourd pour ces acrobaties là hahaha</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Y’en a tellement mais je vais prêcher pour ma paroisse, Keith ou Bob ! 2 bons cogneurs de confiances qui sont capable de lever leur jeu d’un cran quand c’Est le temps !</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Malgré que je sois loin d’être un Derek Jeter, je pense être un bon coéquipier. Un gars d’équipe qui accepte la critique et qui tente de mettre en pratique les conseils qu’on lui donne. Je vais toujours défendre un gars s’il est victime d’injustice peu importe sa cote ou sa couleur de chemise. Je pense qu’au-delà de la compétition le but commun qui nous unis c’estqu’on veut tous avoir du fun et faire le vide en faisant un sport qu’on aime en restant ben loin du drama !</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? Toujours partant pour frapper des balles !! On se rejoint ou et quand ?! :D</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Sauf si tu as 5 ans, LE KETCHUP DANS UN HOT DOG C’EST NON ! Merci de m’avoir donné la chance de m’exprimer ! Lâche pas ta bonne job J-C.😊</p>
<p>Martin a obtenue 60 présences au bâtons avec 21 coups surs, 12 points produits avec une moyennes de 0.350</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('mathieu-francoeur', 'Mathieu Francoeur', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Un nouveau dans la ligue tout comme moi, allons mieux le connaitre ensemble.</p>
<p>Je vous présente Mathieu Francoeur;</p>
<p>L'année dernière était ma première saison dans cette magnifique ligue que mon beau-père Mike Ménard m'a fait découvrir.</p>
<p>Comme plusieurs j'ai joué au baseball organisé de l'âge de 5-6 ans jusqu'à l'âge de 14-15 ans. J'ai complètement arrêté de jouer jusqu'à l'âge de 22-23 ans, quand un de mes chums m'a demandé de remplacer dans son équipe de balle donnée. Je n'ai jamais arrêté depuis.</p>
<p>Très jeune mon père m'a apporté voir mon premier match des expos au stade, et la passion est née là!</p>
<p>Mon premier souvenir de baseball est un évènement organisé par l'organisation des expos sur le terrain du stade olympique avec quelques joueurs, Youppi et d'autres mascottes.</p>
<p>42, pour l'histoire absolument incroyable de Jackie Robinson et aussi le jeu d'acteur impeccable de Chadwick Boseman et Harrison Ford.</p>
<p>Life is like a box of chocolate, you never know what you're gonna get.</p>
<p>La gourmandise!! J'ai bin de la misère à résister à une pointe de pizza.</p>
<p>Pour l'instant, ce n'est pas une ambition. Mais je ne ferme pas la porte à ce qu'un jour je puisse diriger une équipe.</p>
<p>Pas du tout!</p>
<p>Je déteste perdre, mais je ne crois pas être mauvais perdant.</p>
<p>J'essaie le plus possible. Surtout le hockey, le tennis et le golf.</p>
<p>Je suis passionné par la cuisineet pas mal tout ce qui a trait à l'art en général, mais plus précisément la musique, le cinéma et la littérature.</p>
<p>Sans aucune hésitation,Ken Griffey Jr.</p>
<p>Je n'ai pas vraiment d'exploits ou de grandes réussites à mon actif étant donné que j'ai joué à la balle donnée depuis les 10 dernières années. Cela dit, le fait d'avoir pu faire ma place et d'avoir quand même assez bien performer à ma première saison à vie au softball orthodoxe, c'est selon moi mon meilleur exploit jusqu'à présent.</p>
<p>Shortstop</p>
<p>Je dirais intense, avec un désir de gagner mais surtout d'avoir du fun!</p>
<p>J'y crois et je le souhaite de tout coeur. J'aimerais beaucoup pouvoir vivre la frénésie du baseball majeur à Montréal avec mon fils un jour.</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Coke</p>
<p class="question">Crémeuse ou Traditionnel ?</p>
<p>Crémeuse</p>
<p class="question">Sucré ou Salé ?</p>
<p>Les deux...</p>
<p class="question">Café ou Thé ?</p>
<p>Café</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Fan fini de Derek Jeter, Yankees</p>
<p class="question">Bière ou vin ?</p>
<p>Vin</p>
<p class="question">Été ou Hiver ?</p>
<p>Été</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Très certainement avec</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Canadiens</p>
<p class="question">Sage ou tannant?</p>
<p>Anciennement tannant qui devient sage tranquillement.</p>
<p class="question">Chien ou chat ?</p>
<p>Chien</p>
<p class="question">Viande ou végé ?</p>
<p>Viande</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p>En bas de laine si y fait en bas de zéro. Sinon en bas de baseball.</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>Plus souvent qu'autrement à moitié plein.</p>
<p class="question">Finale de la coupe Stanley ou Série Mondiale ?</p>
<p>Série Mondiale.</p>
<p>Un peu de sérieux…</p>
<p>Du beau temps, les gens que j'aime et une game de balle.</p>
<p>Joueur offensif : Éric Collard, parce qu'il a encore une fois fini au premier rang des frappeurs. Joueur défensif : Keith Beauregard, car peu importe où il joue sur le terrain il est solide défensivement. Recrue de l'année et esprit sportif : JC Dionne, avec la saison qu'il a connu, ai-je vraiment besoin de justifier?! Le plus amélioré : première année dans la ligue, je ne peux pas juger. Champion frappeur: Éric Collard. Meilleur lanceur: Joe Santo, pour sa fiche en saison régulière, et parce qu'il est celui contre qui j'ai eu le plus de difficultés. MVP: Éric Collard pour l'ensemble de son jeu. Instructeur de l'année : Benoît Hammarrenger, pour ce qu'il a fait avec son équipe tout au long de la saison.</p>
<p>Sans aucune hésitation.</p>
<p>Oui, déchirure de l'aine et de l'ischio-jambier l'année passée.</p>
<p>Je l'espère long et aussi plaisant que j'ai eu l'opportunité de la voir l'an dernier.</p>
<p>Je dirais ma polyvalence. Je suis capable de me débrouiller pas mal à toutes les positions.</p>
<p>Mon manque de puissance au bâton.</p>
<p>J'essaie d'arriver avec beaucoup d'avances et jaser avec mes coéquipiers. Je n'ai pas vraiment de rituel ou de préparation pré établie.</p>
<p>L'an dernier j'ai beaucoup évolué au champ, mais j'aimerais beaucoup un jour essayer de lancer quelques manches.</p>
<p>Ma polyvalence, mon intensité,mon désir de gagner et d'avoir du fun.</p>
<p>Jouer dans la ligue le plus longtemps possible et un jour jouer avec mon fils.</p>
<p>Il y a quelques années, jecourais pour faire un catch dans le champ, en arrivant à la balle je me suis enfargé dans mon propre pied, tombé en pleine face et j'ai reçu la balle sur la tête… ce n'étais pas mon moment le plus glorieux.</p>
<p>Pour ce que j'ai vu cette saison, un gars qui a toujours sorti fort dans les moments importants et un gars que je respecte et que j'aime beaucoup. Keith Beauregard.</p>
<p>J'essaie le plus possible d'être celui qui ne se laisse pas abattre peu importe la situation et qui cheer up ses coéquipiers tout au long du match. Pour moi l'équipe est plus importante que moi, c'est comme ça que je le vois.</p>
<p>Mathieu était à sa première saison dans la LBMA. Il a obtenu 50 apparitions au bâtons, 26 coups sûrs et 22 points produits. Pour une moyenne 0.520 !!</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('mathieu-ouellet-dore', 'Mathieu Ouellet-Doré', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous présente Mathieu Ouellet-Doré</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>C’est ma 2esaison dans la LBMA et c’est Guyllaume qui m’a fait découvrir la ligue</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Je n’ai pas une super grosse feuille de route mais c’est à Boucherville que ma carrière de futur MLB superstar a commencé quand j’avais +/- 4-5 ans. J’ai rapidement eu la piqure pour le sport et j’ai continué jusqu’à 13-14 ans avant de sombrer dans l’enfer de la drogue et des bonbons surettes. Cette descente aux enfers a mis fin à ma jeune carrière et à tous mes rêves de gloire. Suivant cet échec professionnel, j’ai fait profil bas plusieurs années avant de faire mon retour dans la LBMA en 2020.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Ma passion vient tout simplement du plaisir que j’ai à jouer et de tous les aspects stratégiques du sport (que je ne maitrise toujours pas😊)</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Un peu comme tout le monde, une game au stade olympique en famille !</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Je dirais que Moneyball est l’un de mes préférés, je suis une personne de chiffre et de statistique😊</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Say hello to my little friend(Scarface) ouJe ne soy David Wozniak (Starbuck)</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Les chips</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Cette année le coach nous a donné la chance de faire le line up 1 fois dans la saison et l’expérience était super enrichissante mais non je ne voudrais pas être entraineur, je laisse ça au pro😊</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Non pas vraiment dans la vie de tous les jours MAIS anecdote je m’étais acheté une nouvelle paire de gant de frappeur pour la saison 2021 et après mon début de saison moyen je suis retourné avec la vieille paire et je n’ai plus utilisé les nouveaux!</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Noui ! un judicieux mélange de oui et non, si on perd à cause de nos erreurs oui je vais être un peu mauvais perdant mais à l’inverse si on perd parce que l’autre équipe était ça coche alors non c’était eux la meilleure équipe sur le terrain.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Oui, je m’entraine 3-4 semaines. Je fais un peu de jogging, de tennis et du badminton.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Oui évidemment, j’aime boire de l’alcool #condors 2 ans de suite mais plus sérieusement j’aime découvrir des nouvelles bières de microbrasserie et je ne dis jamais non à un bon verre de vin.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondue ?</p>
<p>Denis Charbonneau parce qu’il est tellement beau !!!</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Si je me base sur mon expérience avec les condors, je te dirais que courir c’était un exploit, après ça, dans mon cas, courir et touché le 2ebut fut très gratifiant et finalement caller un TIME au 3ebut avant de commencer à me relever aussi😊</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Peu m’importe, mais c’est sûr que j’ai bien aimé les quelques matchs au 3ebut cette année</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je me donne au maximum, je veux apprendre le plus possible pour aider l’équipe à gagner</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Non pas vraiment malheureusement</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Aucun des deux, c’est de l’eau ou de la bière</p>
<p>Crémeuse ou Traditionnel ?Aucune des deux je suis au régime …</p>
<p>Sucré ou Salé ?Salé all the way</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Red Sox</p>
<p>Bière ou vin ?Les deux ça dépend du souper</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Sans ananas</p>
<p>Canadiens ou Nordiques ?le mini-putt</p>
<p>Sage ou tannant?Un mélange des deux</p>
<p>Chien ou chat ?Chat</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En bas blanc c’est la règle de la ligue</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Mon verre est souvent vide mais je le rempli rapidement !!</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Série Mondiale</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Peu importe, je m’arrange pour que toutes mes journées se rapproche de la perfection selon les priorités du moment</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Écoute, écoute, écoute !!!!!!! J’en ai aucune idée, je ne sais pas vraiment quel sont les prix mais je sais que les récipiendaires mériteront leur nomination.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Il y en a plusieurs : Ali Sabrah, Eric Collard, Guyllaume Doyon, Marc Ménabo (l’homme carrousel), Stéphane Hétu, Jonathan Desrosiers, Mathieu Francoeur, Patrick Chartrand et plein d’autres, il a tellement de bons joueurs</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Certainement</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Je ne connais pas le passé de la ligue mais je trouve qu’il y a du bon monde qui s’implique pas mal alors j’aurais tendance à dire que l’avenir sera prometteur</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Je me donne à 110% sur le terrain peu importe ou je joue</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Mon manque d’expérience et de connaissance sur le terrain😊</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Je bois un café Starbucks aux épices d’automne …</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Je suis plus souvent au champ (gauche ou droite) et j’ai joué 4-5 matchs cette année au 3ebut et j’ai bien apprécié</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Option 1 : tu veux un joueur polyvalent qui travaille fort pour apprendre et s’améliorer le plus possible pour aider l’équipe.</p>
<p>Option 2 : parce qu’il ne reste pas d’autres joueurs😊</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Avoir du fun et continuer de devenir un meilleur joueur (+ de constance au bâton et meilleur reflexe en défense)</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Il y en a plusieurs😊</p>
<p>i.Pas touché le 2ebut</p>
<p>ii.Pas caller de time au 3e</p>
<p>iii.Voler le 3ebut pis me dire rendu au ¾ du chemin - bah trop facile je retourne au 2e</p>
<p>iv.Restons à l’affut pour d’autres beaux moments en 2022</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Je dirais Jason, il a quand même réussi à faire un courir/marché/boiter Stéphane Blouin du 1erjusqu’au marbre pour nous faire gagner un match de série😊Blague à part, il sort toujours fort dans des moments comme ça donc 100% confiant avec Jay.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Un coéquipier de 5p6 180lbs qui fait des blagues et qui reste positif malgré le score😊</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Oui, j’essaye d’aller frapper des balles une ou deux fois par mois</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Excellente question, je dirais que si la tangente séparent les but est en scorpion et que dans la longueur de l’hypoténuse est égale à A2 + B2, nous pouvons donc déduire que le ketchup est le seul condiment qui devrait se retrouver dans un hot-dog😊</p>
<p>Mathieu à 2 saisons complétés, 27 parties joués, 49 coups sûrs pour une moyenne de 0.457</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('michel-lariviere', 'Michel Larivière', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Pas eu le temps de connaitre beaucoup Michel pour les raisons que l’on connait, mais il est, je crois, un bel exemple de ténacité.</p>
<p>Je vous présente Michel Larivière;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?J’évolue depuis l’année 2000 et je l’ai découverte parce que j’étais arbitre.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?Dans ma jeunesse je jouais au baseball dans la catégorie A fort et par la suite je me suis converti à la balle molle.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ? Moi et mon père allions au stade Jarry voir les Expos.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ? Quand j’étais en 4ièmeannée au primaire et que j’ai vu avec mon père à la télévision un match des séries mondiales en 1968.A cette époque les matchs de séries mondiales étaient de jour.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ? Champs de rêve (Field of dream) pour l’Histoire.</p>
<p class="question">6.Quelle est ta citation de film préférée ?Apporte-moi un coke, une orangeade n’importe quoi sauf de l’ostie de Root beer(citation du film Slap Shot)</p>
<p class="question">7.Quel est ton péché mignon ? Biscuit Oreo (l’original)</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ? J’ai déjà été 2 fois, dont un championnat de saison en 2014</p>
<p class="question">9.Es-tu superstitieux ? Oui</p>
<p class="question">10.Es-tu mauvais perdant ? 50/50</p>
<p class="question">11.Pratiques-tu d’autres sports ? Plus maintenant</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?Lecture et musique</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?Rusty Staub</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ? En juin 1971 lanceur au niveau pee-wee, partie parfaite</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?lanceur</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? intense et gars d’équipe mais avec l’âge moins performant</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? Oui</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnelle ?Traditionnelle</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Red sox, haut la main.</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?sans</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant? Sage</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?à moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Séries mondiales</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?Bonne humeur et calme</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?Étant donné mon absence prolongé les récipiendaires seront surement méritants.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? Eric collard</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Au hockey, déchirure du ménisque droit</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?Bien si le baseball ou balle molle est valorisé auprès des jeunes.</p>
<p class="question">25.Quel est ton point fort à la balle ? L’esprit d’équipe</p>
<p class="question">26.Quel est ta faiblesse ? Impatient</p>
<p class="question">27.Comment te prépares-tu avant un match ? Prend mon « char » pis je me rends au parc</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? lanceur ou voltigeur, tous sauf receveur.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Parce que je suis positif et pour mon âge je ne suis encore pas si mal.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Avoir du plaisir</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? 3 gars sur les buts, compte complet et faire un coup retenu (avec André Dandurand dans le cercle d’attente). On m’en parle encore après plus de 10 ans.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.Eric Collard</p>
<p class="question">33.Quel genre de coéquipier tu es ? Drôle, de bonne humeur</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? J’oublie</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Non, le ketchup ne vas pas dans un hot-dog</p>
<p>Michel a joué 22 saisons, pour un total de 477 parties (20eall time), 1504 apparitions au bâton, 566 coups sûrs, 399 points comptés et 322 points produit pour une moyenne de .376 à vie. Il a lancé 175 parties pour 56 victoires et 67 défaites.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('michel-menard', 'Michel Ménard', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je crois que c’est la bonne personne quand on dit;« lui c’est un vrai boys de la ligue » !!!</p>
<p>Voici M. Michel Ménard;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>J’ai joint les rangs de la LBMA en 2010 après avoir placé une annonce sur le site de softball Québec. Je venais d’être « coupé d’un camp d’essai » d’une ligue concurrente parce que j’en donnais pas assez (!) pendant les 3 pratiques auxquelles j’avais participé. Par contre, ici ça m’a pris 2 tentatives avant de faire mon entrée officielle. Lorsque Michel Plante m’a appelé, il m’a expliqué qu’il y avait un système de cotes dans la Ligue et qu’il avait besoin d’un « 2 » pour remplacer un gars (David Monette) qui ne pouvait pas jouer cette année-là. J’ai eu un essai de 2 matches avec les Vautours et… je l’ai « coulé ». Sans me chercher d’excuses, il faut dire que je n’avais pas joué à la balle organisée depuis… 1997 environ. Après m’avoir remercié, Monsieur le Président (un homme de parole comme il ne s’en fait plus) m’avait promis que j’étais #1 (ça, c’est rare) sur la liste d’attente pour la saison 2011. Contre toute attente, le 22 mai, il me lâche un coup de fil pour me dire qu’un joueur de cote « 1 » (Michel Bernard) venait d’abandonner et que je pouvais me joindre à la Ligue dès le lundi suivant, Journée des Patriotes. Cette fois-ci, c’est Marc Vanier (alors coach des Harfangs) qui me souhaite la bienvenue à bord. Je dis toujours que le Destin fait bien les choses et ce fut le cas encore une fois. Les Vautours (pour qui j’avais joué deux matches) terminèrent au dernier rang avec un dossier de 8-17 tandis que les Gris remportèrent le doublé (non, pas grâce à moi) : Champions de la saison régulière (17-6-2) et Champions des Séries. Pas pire pour une 1resaison…😉</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Ayant grandi dans un p’tit village de la Montérégie (St-Polycarpe), il n’y avait ni hockey (on avait juste une patinoire extérieure au village) et ni baseball organisé. Malgré tout, mon père était toujours à l’écoute de ce que je voulais faire comme sport et s’organisait pour que ça arrive. J’ai commencé à jouer au hockey alors que j’avais 7-8 ans à Valleyfield (la plus grande ville la plus proche.). J’étais vraiment très ordinaire et je n’ai joué qu’une saison parce qu’à l’époque, si tu n’étais pas bon, tu réchauffais le banc donc, pas mal impossible de s’améliorer... Pour la balle, c’est arrivé en 1977 alors que mon père a vendu la maison de mon enfance pour déménager à Vaudreuil. Là aussi, ce fut assez difficile et j’ai joué seulement cette saison-là parce que j’ai passé presque toute l’année à regarder les autres jouer, mais j’avais quand même eu la piqûre dont l’effet ne s’est jamais estompé.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Avant d’expliquer pourquoi j’ai une telle passion, je vais te mettre en situation parce que ça part de (très) loin… Je suis né de mère et de père inconnu le 21 décembre 1964. À l’âge d’un an, Eugène et Marthe Ménard, qui avait déjà adopté 2 filles (Monique et Nicole), ont décidé d’adopter un p’tit garçon qui allait se prénommer Michel. Mes parents (pour moi ce sera toujours EUX mes parents) avaient déjà 50 ans lorsqu’ils sont « venus me chercher » comme se plaisait à le dire ma mère donc, c’est comme si j’avais été adopté par mes grands-parents. Malgré cet écart d’âge, je n’ai manqué absolument de RIEN et, surtout, j’ai été aimé et choyé pendant toutes les années qu’ils étaient avec moi. Mon père est décédé en 1983 et ma mère en 1995. Donc, puisque mon père était un peu âgé et qu’il travaillait des heures de fou pour qu’on ne manque de rien, il ne se lançait jamais avec moi et ne laçait encore moins des patins. Il m’a toujours encouragé à faire du sport et ne m’a jamais refusé telle ou telle inscription à condition que j’embarque jusqu’au bout même si je n’aimais pas ça. Par contre, il aimait le hockey, adorait la balle et était un raconteur hors pair. Ses histoires sur Maurice Richard, Doug Harvey ou Gordie Howe en passant par la saison de Jackie Robinson avec les Royaux et les matches qu’il allait voir au stade de Lorimier après la « Grand Messe » du dimanche ont fait que je voulais jouer moi aussi. Plus tard, quand j’étais ado, on allait au stade au moins une douzaine de fois par saison pour voir Gary Carter, Steve Rogers, Bill Lee, Ron LeFlore, Tim Raines, etc. Des moments inoubliables père-fils qui me manquent encore après toutes ces années.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Mon tout premier souvenir de baseball est un dimanche après-midi dans les estrades populaires du champ gauche au parc Jarry. Ce fut le seul match que j’ai vu à Jarry. Malheureusement, je ne me rappelle pas la date exacte sauf que j’y était avec mon père et ma sœur Nicole…</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Hum, hum, pas facile comme question puisque j’en ai 4-5 en tête… Sincèrement, il y en a deux que je suis incapable de séparer : Field Of Dreams et The Natural. Le premier pour l’histoire père-fils qui me fait brailler à chaque fois tandis que le deuxième est pour la « preuve » qu’il ne faut jamais renoncer ou abandonner ses rêves.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Elle provient du film The Natural</p>
<p>-Iris Gaines(Glen Close) : You know, I believe we have two lives.-Roy Hobbs(Robert Redford) : How... what do you mean?-Iris Gaines: The life we learn with and the life we live with after that.</p>
<p>(Traduction libre :Tu sais, je crois que nous avons deux vies / Comment ça… que veux-tu dire par là? / La vie avec laquelle on apprend et la vie que nous vivons après cette dernière.)</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Les patates frites</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Bien sûr, si on veut me « donner une 2echance » puisque je l’ai d’ailleurs été de 2014 à 2017.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Mets-en !!</p>
<p>-J’ai 2 « undershirts » : 1 pour le vendredi et 1 pour le samedi. Dès qu’on perd, je les « switches » la semaine suivante.</p>
<p>-J’attache toujours mon « spike » gauche en premier.</p>
<p>-Je mets toujours mon sac au même endroit dans « l’abris » des joueurs et je change de place si on perd.</p>
<p>-J’ai 2-3 bâtons préférés (ceux de la Ligue) et je change dès que j’ai un K ou si je suis dans une profonde léthargie.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Absolument pas. Je n’aime pas perdre, mais je ne perds pas la carte lorsque ça arrive.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Je suis gardien au hockey-cosom (le hockey sur glace n’est vraiment plus abordable $$$) et je vais au gym 3 fois / semaine.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Je suis un maniaque de films et de livres.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondue ?</p>
<p>Ouin, pas facile celle-là non plus... Bon, j’en ai 3 :</p>
<p class="question">1-Gary Carter :Parce que c’est à cause de lui que je me suis mis à aimer la balle tout en rêvant d’être un catcher comme lui.</p>
<p class="question">2-Pedro Martinez :Je travaillais pour les Expos lorsqu’il est arrivé pendant la Caravane d’hiver de 1994. Je suis tombé en amour avec le gars sans jamais l’avoir vu lancé faque imagine comment il m’a fait tripper dès sa première game. (https://youtu.be/CzEn4ChMuMk)</p>
<p class="question">3-Pete Rose :Il pouvait tout faire sur un terrain de balle et il avait un cœur grand comme le Stade olympique. Mon père l’adorait et me disait toujours que même si mon talent était limité ma détermination devait être 5 fois plus grande que celle des joueurs plus talentueux que moi afin de faire ma place.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Avoir été élu « Joueur le plus valeureux » par mes coéquipiers à ma 1resaison dans la Ligue en plus de remporter le trophée Doug Wilson (élu par l’Exécutif) la même année.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Lorsque j’étais jeune, j’adorais catcher, mais on ne m’a pas beaucoup donné l’occasion à cet âge-là mais, je l’ai été dans mes premières années à la balle-molle pour ensuite jouer au 2ebut plus souvent qu’autrement. Lorsque je suis arrivé dans la LBMA, on m’a collé une étiquette de voltigeur, mais en vieillissant, j’aime bien être au 1erou au 2ebut.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Comme je l’ai dit dans quelques-unes de mes réponses, j’ai toujours été conscient de mon talent limité, mais lorsque j’enfile mon uniforme, je vais faire TOUT ce que je peux pour ne pas nuire à mon équipe et, avec un peu de chance, je les aiderai à gagner.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Oui à 50% mais, NON à 100% si cette joke de garde partagée voit le jour. J’ai été aux premières lignes en côtoyant et écoutant TOUS les commentaires des partisans de nos zAmours de 1992 à 1994 ainsi qu’en 2001. À l’époque (et même dans les années 80), ça prenait pas grand chose pour que les « Fans » débarquent. Donc, imagine un instant que les Rays aient une fiche négative et qu’ils soient dans les bas-fonds du classement lorsqu’ils se présenteront à Montréal pour y jouer leur vingtaine de parties annuelles… Ce « cadeau » que MLB semble nous offrir en laissant planer que ça nous redonnerait une équipe à temps plein plus tard, c’est un leurre. En plus, exiger un stade tout neuf au centre-ville pour que le projet voit le jour est absolument absurde.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?* Sprite</p>
<p>Crémeuse ou Traditionnelle ?*La salade de choux de Mimi</p>
<p>Sucré ou Salé ?*Salé</p>
<p>Café ou Thé ?*Café</p>
<p>Yankees ou Red Sox ?*#Expos4Ever</p>
<p>Bière ou vin ?*Tequila, Heineken, pas l’temps d’niaiser…</p>
<p>Été ou Hiver ?*Été</p>
<p>Pizza avec ou sans ananas ?*SANS</p>
<p>Canadiens ou Nordiques ?*Canadiens de 1974 à 1984 / *Nordiques de 1984 à 1995</p>
<p>Sage ou tannant?*Sage, mais tannant à l’occasion</p>
<p>Chien ou chat ?*Chien</p>
<p>Viande ou végé ?*Viande</p>
<p>En bas de laine ou en bas de zéro ?*Bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?*Mon verre est toujours plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?*Série Mondiale any day of the week</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Une journée avec Mimi, nos filles, leurs chums et Titi-Noah. Si on est dans un stade de balle, c’est sûr que c’est un +.😉</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je ne me rappelle plus de tous les trophées par cœur (Pat Chartrand, le fichier ne fonctionne pas sur le site…) donc, je vais y aller au pif.</p>
<p>-Coach :Guy Brisebois, Ducs(PERSONNE ne voyait les Verts à cette position avant le début de la saison.)</p>
<p>-MVP (saison) :Sylvain Longtin, Vautours(avec TOUT ce qui s’est passé chez les Vautours cette année et connaissant le leadership et le côté rassembleur de ce gars-là, c’est clair qu’il a été un rouage important dans les succès de l’équipe.)</p>
<p>-Meilleur Lanceur :Philippe Laverdière, Ducs(En remplaçant « Mike The River » à pied levé, il a cumulé un dossier absolument exceptionnel dans les circonstances tout en aidant son club à finir au 3erang)</p>
<p>-Joueur le plus amélioré :Mathieu Ouellet Doré, Condors(En plus d’être une personne d’exception, Matt n’a pas cessé de progresser à chaque match tout au long de la saison et ce, des « 2 côtés » du terrain.)</p>
<p>-Meilleur joueur défensif :Jonathan Desrosiers, Vautours(On savait qu’il pouvait jouer derrière le marbre mais, là on sait qu’il peut y exceller.)</p>
<p>-Meilleur esprit sportif :Keith Beauregard, Aigles(Lorsque je suis arrivé dans la LBMA, j’ai joué à ses côtés pendant 3 ans et ce fut toujours plaisant. Un gars avec un cœur sur la main qui sait comment parler et motiver ses boys.)</p>
<p>-Recrue de l’Année :Sérieux, à part mon gendre Mathieu Francoeur, j’en vois pas vraiment cette année. C’est sûr que toi, JC, t’as connu une saison pas trop pire, mais y’a fallu que tu joues pour toutes les équipes pour y arriver. En tout cas…</p>
<p>-MVP (Séries) :Stéphane Proulx, Condors.(Il a absolument TOUT fait pour nous aider, la « Bande de Losers », à mettre la main sur LE Trophée le plus convoité de le LBMA. En plus, jouer avec lui, c’est tellement facile.)</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>C’est sûr que j’aimerais évoluer avec mon gendre en tout temps mais, à part lui, il y a toi JC (pis ce n’est pas une joke) ainsi qu’avec Ali Sabrah.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Bien sûr, c’est un « no brainer ». J’ai évolué dans plusieurs Ligues et elle demeure, et de loin, LA Meilleure.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>À part avoir été blessé à mon orgueil à quelques reprises, il ne m’est rien arrivé de très grave à part un ou deux claquages.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA ?</p>
<p>Très sincèrement, avec l’ajout de personnes dévouées et impliquées dans ton genre, JC, j’entrevoie l’avenir de notre Ligue avec beaucoup d’optimisme.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Ma rapidité et mes glissades légendaires (Demande à Keith et Bob).</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>L’ensemble de mon jeu.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Je pars de la job, j’m’en vas à maison, je monte en haut, je dis bonjour à Mimi et à Pablo, je vais aux toilettes, je m’habille… je m’habille encore… j’ai pas encore fini de m’habiller… bon, j’suis prêt, on descend, on part, on pogne du trafic, obligé de sortir à Lacordaire, calvaire… pis on finit par arriver ben juste. C’était l’fun quand on jouait à Lucie-Bruneau… Blague à part, j’y pense pas mal toute la journée et encore plus quand c’est un match important… Toujours hâte d’être sur le terrain.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Comme je l’ai dit auparavant, je suis pas mal toujours voltigeur et je me sentirais encore mieux au 1erou au 2e.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Parce que tu vas avoir d’la bière gratis toute l’année à moins que… tu boives comme 90% des Bleus de 2021. À ce moment-là, j’aurais plus de compte de dépenses pour ma bière à partir du 3ematch.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Jouer pour encore 15+ ans et, si possible, réussir à jouer une saison avec Noah et son père.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Y’en a tellement, lequel choisir…</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Très sérieusement, c’est impossible pour moi d’en choisir un seul donc, je me dois de tous les nommer (aucun ordre précis) : Patrick et Stéphane Blouin, André Dandurand, Marc Vanier, Patrick Chartrand. Avec n’importe lequel de ces cinq gars-là au bâton, c’est sûr que tu gagnes le match.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>J’essaie d’être toujours là pour toute l’équipe et de détendre l’atmosphère le plus possible lorsque la situation est plus stressante.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>À chaque année, j’me dis que je vais aller frapper quelques balles pour être prêt pis, finalement, je manque de temps.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>La dernière fois que j’ai mis du ketchup dans mes hot dog, la grosse bouteille coûtait 1$ pis j’me sacrais pas mal de la distance entre les buts parce que j’avais des jambes dans ce temps-là…</p>
<p>Merci d’avoir pensé à moi, JC😉</p>
<p>Tout le plaisir était pour nous, tu as su nous divertir avec tes réponses généreuses !</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('michel-plante', 'Michel Plante', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<h3>Deuxième entrevue Michel Plante ( le président)</h3>
<p>Après l’été bizarre 2020, jouer à la balle avec plein de restriction et règlement différent, purrel, lingette et spray désinfectant, je me questionnais déjà si je restais dans les ligues ou je jouais (Lorraine et Charlemagne). Durant l’hiver 2020-21, j’ai échangé quelques textos avec mon chum Longtin à savoir où il jouait maintenant car ça faisais un petit bout que l’on se voyait pas. Je voulais savoir aussi s’il aimait sa ligue. Réponse; que du positif ! Je lui demande alors s’il y aurait de la place, même si le samedi matin 8h15 me faisais déjà peur ! Il m’a répondu qu’il donnait mon nom au président de la ligue et d’espérer qu’il m’appelle.</p>
<p>Début février je crois, le téléphone sonne,« Jean-Christian? », « oui », « Michel Plante de la LBMA », parait que tu voudrais venir jouer avec nous ? Il m’a parlé de sa ligue pendant 45 minutes, comment il en était fier, de son fonctionnement, du draft, des règlements et particularités, l’esprit sportif est de mise et un pantalon noir et des bas blancs ! « Pardon des bas blancs en 2021 ??!! ». Je me suis dit que je pouvais m’y faire ! Il m’a répété au moins 3 fois pendant notre discussions que ça faisais 36 ans qu’il évoluait pour la ligueJ</p>
<p>Alors comme vous vous en doutez,ma première entrevue; le grand manitou Michel Plante.</p>
<p class="question">1- Alors pour ceux qui ne le saurais pas encore, depuis quand évolues-tu dans la LBMA en tant que joueur et président ?J’évolue dans la LBMA depuis 1986, soit l’annéeoùla ligue a monté de 4 à 6 équipeset comme président,je dirais au début des années 2000.</p>
<p class="question">2- Avant la LBMA, as-tu joué au baseball mineur ou une autre ligue de balle-molle ? Pour qui et à quelle position tu évoluais ?Aussi loin que je peux me souvenir,j’ai toujours joué au baseball au début dans mon petit village natal en Mauricie(St-Justin). Si je me souviens bien, je jouais au 3ebut, ensuite j’ai joué au baseball adulte dans la ligue de baseballrurale Albert Gaucher en Mauricieet ensuite j’ai commencé à jouer à la balle molle au début des années 80.</p>
<p class="question">3-Comment es-tu devenu président de la LBMA ?Bien humblement, je pense que ça c’est fait naturellement, un certain moment donné les joueurs ont commencé à dire que j’étais le président de la ligue, mais pour être honnête avec vous, tous les membres de l’exécutif sont sur un même pied d’égalité.</p>
<p class="question">4-Je vois que la balle prend beaucoup de place dans ta vie, est-ce qu’il y a autre chose qui te passionne ?J’aime les voyages et j’adore écouter de la musique.</p>
<p class="question">5-Les gars veulent savoir, les bas blancs, c’était un règlement avant que tu deviennes président ?Oui, je pense que le port des bas blancs date du début de la ligue soit 1976.</p>
<p class="question">6-Pendant toutes ces saisons, as-tu eu une blessure grave qui t’as empêché de jouer ?J’ai été assez chanceux du coté blessure, après toutes ces années, aucune blessure grave.</p>
<p class="question">7-Quel est ton premier souvenir de baseball ?Wow, mon premier souvenir de baseball, c’était lorsque j’étais gamin, j’allais voir jouer le club de baseball de mon village, les Étincelles de St-Justin avec mon père. Dans les années 60, ces rencontres entre les équipes de baseball des villages voisins étaient trèsimportantes.</p>
<p class="question">8- Explique-nous un peu ta passion pour la balle ?Comme je disais tantôt, ma passion pour le baseball vient de mon enfance et cette passion n’a jamais diminué avec le temps.</p>
<p class="question">9- Qui est ton joueur du baseball majeur favori, toutes époques confondu ?Gary Carter</p>
<p class="question">10- Quel est ton film de baseball préféré ?Field Of Dreams, c’est unfilm qu’on se tanne pas de regarder.</p>
<p class="question">11- Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?Je pense que pouvoir jouer encore à mon âge (68 ans) est ma plus grande réussite.</p>
<p class="question">12- Crois-tu au retour du baseball majeur à Mtl ?Pour être bien honnête non, surtout avec l’idée du partage avec les Rays de Tampa Bay, je pense que ça va être difficile de s’identifier à une équipe que nous pourrons aller voir une couple de mois par année seulement.</p>
<p class="question">13- Tu en a vu passer des joueurs de balle dans la LBMA, peux-tu nous nommer quelques joueurs qui t’on marqués ?Je ne m’aventurerai pas à nommer des joueurs de peur d’en oublier. Mais, je dirais que chaque joueur que j’ai vu passer dans la LBMA et Dieu sait que j’en ai vu passer en 36 ans, m’ont marqué chacun à leur manière.</p>
<p class="question">14-D’après toi, l’invention du bas blanc date de quelle année, 1720-1938 ou 1959 ?1938</p>
<p class="question">15- Questions en rafale :</p>
<p>Coke ou Pepsi?Pepsi</p>
<p>Crémeuse ou traditionnel ?Crémeuse</p>
<p>Sucré ou salée ?Sucré</p>
<p>Café ou thé ?Café</p>
<p>White Sox ou Red Sox ?White Sox</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Sans ananas</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Finales de la coupes Stanley ou Série mondiale ?Série mondiale</p>
<p class="question">16- 93% des joueurs de la ligue portent le pantalon long, aujourd’hui, les bas blancs,tu as une « plug »pour les avoir pas cher ?Non, pas vraiment</p>
<p class="question">17-Plus sérieusement, ton implication dans la ligue est sans égal, y a-t-il une chose dont tu es particulièrement fier lorsque tu penses à la LBMA ?Oui, qu’après toutes ces années, j’ai vu se créer beaucoup d’amitié qui durent et qui dureront, j’espère encore pour plusieurs années.</p>
<p class="question">18- J’ai des espions qui mon dit que la saison prochaine sera ta 37e, un record que tu partageras avec Serge Schiller. Que représente ce fait pour toi ?Je suis très fier de faire partie de cette grande famille qu’est la LBMA et j’espère durer encore une couple d’autres années</p>
<p class="question">19- Pour conclure, comment tu perçois l’avenir de la LBMA ?J’espère que la ligue durera encore plusieurs années et quele côté amical/familial et une saine compétition resteront encore, car c’est,je crois, pour cette raison que la ligue a 46 ans d’existence.</p>
<p>Voici un peu l’histoire du grand boss. J’ai une grande admiration pour ce monsieur. Pour tout ce qu’il fait pour la LBMA et tout ce qu’il a accompli par le passé pour la ligue.</p>
<p>J’espère pouvoir jouer aussi longtemps à ce sport que l’on aime tant. Michel a à son actif 666 partie jouées (3eall time), 2094 apparitions au bâton (4eall time), 809 coups sûrs (5eall time) et 510 PP (8eall time).</p>
<p>Merci</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('myles-o-reilly', 'Myles O''Reilly', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire Myles</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ? It’s been 3 years now and Jo Santo brought me to LBMA</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ? I played a couples of years. Mostly played baseball at the park with friends (pickup games) Played more softball. Started off as a centerfield for about 15 years. Played catcher and some infield then switched to pitcher. One team our pitcher went on vacation and another team the pitcher couldn’t throw strikes so I ended up pitching. I played on 3 or 4 teams every year. I played in a lot of different leages.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ? Just enjoy playing it just for fun.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ? The natural !</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p class="question">7.Quel est ton péché mignon ? Chocolate, ice cream and sometimes cake.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ? No</p>
<p class="question">9.Es-tu superstitieux ? No</p>
<p class="question">10.Es-tu mauvais perdant ? No</p>
<p class="question">11.Pratiques-tu d’autres sports ? Yes</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? Music, hockey</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ? Hank Aaron</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? Pitcher !</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Team player</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? No</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ? Pepsi</p>
<p>Crémeuse ou Traditionnel ? Traditionnel</p>
<p>Sucré ou Salé ? Sucré</p>
<p>Café ou Thé ? Thé</p>
<p>Yankees ou Red Sox ? Red Sox</p>
<p>Bière ou vin ? Wine</p>
<p>Été ou Hiver ? Summer</p>
<p>Pizza avec ou sans ananas ? Without !</p>
<p>Canadiens ou Nordiques ? Canadiens</p>
<p>Sage ou tannant? Sage</p>
<p>Chien ou chat ? Chien</p>
<p>Viande ou végé ? Meat</p>
<p class="question">En bas de laine ou en bas de zéro ? ????</p>
<p>Ton verre est à moitié plein ou à moitié vide ? Full</p>
<p>Finale de la coupe Stanley ou Série Mondiale ? Stanley cup</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? World series Playoff</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Yes</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? No</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? Same as it is.</p>
<p class="question">25.Quel est ton point fort à la balle ? Patience</p>
<p class="question">26.Quel est ta faiblesse ? Hitting</p>
<p class="question">27.Comment te prépares-tu avant un match ? Stretching and warm-up</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Pitcher but would be interested in trying the 2ndbase</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? I’ve strong knowlegde of baseball</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? No</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? When i had a broken belt !</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. JC Dionne</p>
<p class="question">33.Quel genre de coéquipier tu es ? I’m kind</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? No, i forget the sport</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? No !</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('patrick-chartrand', 'Patrick Chartrand', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Pat Chartrand, un futur membre de la renommée LBMA. Un chic type que j’ai appris à connaitre l’an dernier et j’espère connaitre encore mieux les années avenir.</p>
<p>Avant de débuter, j’aimerais te remercier pour ce que tu fais et pour ton désir de t’impliquer dans notre belle ligue. Je sais que plusieurs membres de la ligue ont soulignés ton beau travail mais je trouvais important de le faire, moi aussi. De nourrir le lien avec les autres durant la saison hivernale est absolument génial. Les gens qui liront ceci ne savent pas, mais je m’excuse aussi de t’avoir fait attendre. Il y a longtemps que tu m’as envoyé le questionnaire mais j’ai été élu président de mon syndicat en octobre dernier, et depuis, je suis occupé comme je ne l’ai jamais été. La négociation a repris son court et j’ai réussi, avec mon équipe, à rétablir un canal de discussion avec mon employeur et je pousse très fort pour faire avancer les choses dans le but que l’on voit un peu moins ma grosse face à la télévision. Bref, j’ai l’intention de me racheter avec mes réponses et que tu puisses me dire que l’attente en a value la peine (j’aimerais que tu laisses ce paragraphe pour que les autres le lisent même s’il s’adresse à toi JC. Merci)</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>J’ai fait mes premiers pas dans la ligue en 1992, il y a 30 ans. Mon père Yves y évoluait depuis 1991</p>
<p>Je venais le voir jouer de temps en temps au parc Jarry 3, le terrain à côté de celui ou on joue actuellement. À l’époque, il y avait une activité annuelle familiale dans un camping. Tous les joueurs s’y rassemblaient avec leurs familles. On se baignait, jouait aux fers, passait du bon temps ailleurs que sur un terrain de balle. Cette année-là, j’y suis allé avec mon père et il m’a présenté au président et membre fondateur de la ligue, Robert Tourangeau. Comme on dit : The rest his history.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Aussi longtemps que je me souvienne, j’ai joué au baseball. J’ai commencé à jouer dans des ligues organiser à l’âge de 10 ans, catégorie moustique. Un début assez tumultueux. À ce moment-là, j’embarquai sur mon vélo et je roulais jusqu’au parc, et il y avait du monde qui jouait au baseball. C’était facile comme ça. Beaucoup de mes amis jouaient déjà dans des ligues et un d’eux me dit que je devrais m’inscrire, il me disait que je ferais l’équipe facilement. Nous étions au printemps et les camps d’entrainements étaient déjà commencer. Mon ami me dit qu’il a parlé de moi au coach et qu’il m’invite à la prochaine pratique. J’accepte. La première balle que je frappe va directement sur la clôture, à quelque pouce de la mettre l’autre côté. Pour vous mettre en situation, c’était une équipe élite et personne n’a frapper de circuit de l’autre côté de la clôture de l’année…sauf moi….14 fois. J’ai fait l’équipe. Je me souviens à quel point j’étais heureux en me rendant chez moi pour annoncer la nouvelle à mes parents. La première partie était quelques jours plus tard. Ma joie s’est transformée en un énorme malaise à mon arriver au terrain. Aucun signe de mon ami. J’ai compris assez vite qu’il avait été retranché pour me faire une place. J’étais complètement déchiré. J’étais surtout un enfant. Je ne savais pas comment réagir. Je faisais partis d’une équipe de baseball. J’en rêvais. Le malaise ne s’arrête pas là. Le père de mon ami se pointe au terrain, furieux. Il s’en prend au coach mais pire que ça, à moi. Il est resté toute la partie. Me passait des commentaires pour m’intimider. Il m’a même suivi en voiture après la partie pour une partie de mon trajet de retour. Histoire vraie. Croyez-le ou non, il est revenu lors du match suivant. Cette fois-ci, je n’étais pas seul. Mon père y était. Je n’ai jamais revu ce trou de cul. Je n’ai aucune idée ce que mon père lui a dit, mais ça implique sûrement sa collection de carabine. Mon père adore la chasse. Je n’ai jamais revu mon ami. Son nom est Ian. À ce jour, je pense à lui de temps en temps. J’aimerais lui parler. J’aimerais aussi recroiser son papa…pas pour jaser. Après cette année-là, j’ai toujours joué avec des joueurs plus vieux que moi et ce, jusqu’à la catégorie junior ou j’ai fait l’équipe à l’âge de 17 ans. J’ai pris ma retraite du baseball à 19 pour faire mon entré dans la LBMA.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>C’est difficile à expliquer mais quand j’aime quelque chose, je m’investis à 100%. Je me suis calmé un peu en vieillissant en ce concerne la balle mais avant, je jouais dans plusieurs ligues, aucune mieux que la LBMA. Je dormais pratiquement avec mon gant. C’est à peine exagérer. Nul part ailleurs qu’un terrain de balle entourer de mes chums ou je suis plus à ma place.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>J’avais 5 ou 6 ans, pas certain. Mon père veut me montrer à frapper une balle. Il m’achète un de ces gros bâtons de plastique, vous savez? Du genre qu’il y avait dans l’émission ‘les Flinstones’. Du genre très gros avec une balle de plastique. J’habitais la ville de Lorraine et un de nos voisins était Richard Morency, ex-annonceur des Expos. Son fils Michel (Mimo), certain de vous le connaissez. Il joue dans plusieurs ligues de balles. Il est sourd et muet. Vous comprendrez plus tard pourquoi je vous donne ce détail. Nous sommes dans ma cours, mon père, Michel et moi. Mon père nous enseigne comment tenir le bâton et comment s’élancer. Je me place alors et mon père est devant moi, pas très loin et me lance la balle comme à la balle-molle, par en dessus. Me voyez-vous venir? Et oui, ma première victime. Je claque une flèche en pleine gueule de mon père. Directement sur l’œil. Mon père met le genou au sol et prononce plusieurs mots inappropriés pour des garçons de notre âge. Mon ami Michel part aussitôt dans la maison chercher ma mère. Je me souviens très bien de l’image de Michel qui essai d’explique à ma mère ce qui venait d’arriver avec des sons et de gestes que ma mère avait du mal à comprendre. De toute beauté. Ce n’est pas d’hier que je fais des victimes chez les lanceurs.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Il y en a tellement. Fields of dreams pour la passion du sport. Moneyball, Cobb, Eight men out, 42 et 61*pour le côté biographique de ces films. J’adore l’histoire du baseball en général. Finalement, Major leagues et Bull Durham pour le plaisir et l’humour.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p class="question">‘I see dead people’ Sixth Sense. La pognez-vous?</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Ayoye. Possiblement la question la plus difficile de ce questionnaire. Je ne sais pas trop quel choisir mais mon docteur voudrait sûrement que j’arrête d’en consommer !</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Mes plus belles années dans la LBMA furent comme coach. Le plaisir de bâtir une équipe et d’essayer de la conduire à un championnat est quelque chose que j’ai beaucoup aimé faire. Il ne faut jamais dire jamais, mais considérant que j’ai coacher pendant de nombreuses années et que je fais partie de l’exécutif et que j’y mets toute mon cœur, je crois qu’il est correct que je laisse ce rôle à d’autre. Je dois avouer que plusieurs fois par saison, on me dit que je devrais revenir et ça me touche de savoir qu’il y a des joueurs qui on aimer jouer dans mes équipes.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Beaucoup moins qu’avant. Je fais encore des petites choses comme avoir deux paires de bas pour la saison. Une pour les vendredis, une pour les samedis. Je fini la saison avec quoi qu’il arrive. J’ai déjà eu le gros orteil qui sortait de mon bas troué, mais nous étions en séries. On va jusqu’au bout. J’utilise aussi une seule paire de gant de frappeur par saison. Des petites niaiseries comme ça.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Encore une fois, beaucoup moins qu’avant. Je donne beaucoup de crédit à la LBMA pour ça. Plus jeune, je refusais de perdre. Ce n’était même pas une option. En arrivant dans la ligue, à 19 ans, sortis du junior élite ou la compétition était intense même à l’intérieur d’une équipe, j’avais beaucoup de misère à comprendre comment tu peux éprouver du plaisir avec un gars qui ne porte pas le même chandail que toi après un match. Faire une joke après avoir commis une erreur. Sourire après se faire retirer sur trois prises. J’étais incapable de faire ces choses-là. Je sais, j’aurai dû consulter. Aujourd’hui, je suis toujours compétitif. Je veux gagner mais j’apprécier aussi tout ce qui entoure la game, spécialement dans notre ligue. Une gang de chum qui compétitionnent mais une fois que c’est fini, le plaisir continu parce que la vérité c’est que nous sommes chanceux de pouvoir pratiquer un si beau sport. J’espère pouvoir le faire encore longtemps.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>J’ai recommencé à jouer au tennis, un sport que je pratiquais beaucoup plus jeune. J’aime le golf mais je ne joue pas assez souvent à mon goût. J’aime nager. Je suis très à l’aise dans un trou d’eau.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Plein. J’aime m’impliquer socialement. Vous savez déjà que je suis délégué syndical et j’ai beaucoup appris sur le droit, particulièrement le droit du travail. J’ai travaillé sur une tonne de dossier de santé et sécurité au travail, un sujet tellement intéressant. Ce qui me passionne le plus dans le syndicalisme est de venir en aide à des gens qui on subit des injustices ou simplement de s’assurer que tout le monde soit bien et heureux dans son milieu de travail. Dans un autre ordre d’idée, j’aime cuisiner. Je dirais que je ne suis pas pire pantoute. D’ailleurs, j’aime tellement ça que j’aime faire l’épicerie. C’est le seul type de magasinage qui ne me rend pas malade. Je dirais que ma plus grande passion à l’extérieur de la balle, c’est la musique. Elle est toujours présente dans ma vie. J’aime toute sorte de genre de musique aussi. Très ouvert et très heureux quand je découvre quelque chose de nouveau. Vive Spotify.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Le premier qui me vient en tête est Tim Raines. J’ai eu la chance de le rencontrer en plus. Comme plusieurs, j’ai aussi capoté sur Ken Griffey jr. Un phénomène. J’ai mentionné que j’aimais l’histoire du baseball et j’ai beaucoup lu sur le sujet. J’aurai tellement aimé voir Ted Williams à l’œuvre. Son parcours chez les professionnels est délirant. Pour ceux qui ne le connaissent pas, faite une recherche sur lui, ça vaut la peine.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Un double. Je suis dans le midget. J’ai 15 ans. Championnats provinciaux à Hull. Je n’avais jamais joué dans un endroit comme ça. Ça ressemblait à un petit stade. Des estrades de bétons qui font le tour du terrain du premier but jusqu’au troisième but. Les estrades étaient hautes. Il y avait du monde. Des centaines de personnes. Les estrades étaient pleines en plus d’avoir des spectateurs partout autour du terrain. Je joue pour la région Montréal-Bourrassa. Des joueurs de Montréal-Nord, St-Léonard et d’Anjou…comme moi. On affrontait Québec. Personne ne nous donnait une chance. Dernière manche, on perd 4-2. Les buts remplis. C’est mon tour. J’ai un peu gâché le punch mais j’ai effectivement frappé un double qui a vidé les buts. Victoire 5-4. Honnêtement, je ne me souviens pas du nom de tous mes coéquipiers mais ce dont je me souviens, c’est la foule. La vibration. Les gens qui applaudissent, c’était complètement fou. J’avais l’impression que le sol tremblait. Je n’oublierai jamais ce moment. Un double.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Lanceur. Pour vrai. J’ai lancé très longtemps et j’ai adoré. Tu es en plein contrôle du match à cette position.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je visualise et absorbe tout ce que je vois. J’apprends encore aujourd’hui, après toutes ces années. J’analyse la façon dont les lanceurs m’affrontent et je fais des ajustements en conséquence. Mon focus est une de mes plus grandes forces, spécialement au bâton. Je pense être un leader, du moins j’essai d’aider et de supporter mes coéquipiers au meilleur de mes capacités.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Je suis positif de nature et j’ai espoir que oui. Je le souhaite de tout cœur.</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Le Coke a longtemps été ma drogue. Cause principale de mon diabète.</p>
<p class="question">Crémeuse ou Traditionnel ?</p>
<p>J’aime les deux. Je suis la famille. Pas de chicane.</p>
<p class="question">Sucré ou Salé ?</p>
<p>Je suis diabétique, donc je devrais répondre sucré mais je suis incapable de refusé un sac de chips.</p>
<p class="question">Café ou Thé ?</p>
<p>Je préfère les boissons froides. J’aime quand même le café et le thé mais je bois très peu des deux.</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Quand on s’intéresse à l’histoire de ce sport, ces deux équipes en ont de très riches. Cependant, je serai toujours un Expos.</p>
<p class="question">Bière ou vin ?</p>
<p>Bonne bière froide avec mes chums et une super bonne bouteille de vin avec un bon repas avec ma douce.</p>
<p class="question">Été ou Hiver ?</p>
<p>Je déteste l’hiver. De plus en plus à chaque année.</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>J’adore les ananas mais je n’ai jamais eu envie d’en mettre sur ma pizza.</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>C’était pas mal plus le fun quand les deux existaient.</p>
<p class="question">Sage ou tannant?</p>
<p>Je suis sage. Je sais que vous m’avez déjà vu tannant mais dans la grosse majorité du temps, je suis sage.</p>
<p class="question">Chien ou chat ?</p>
<p>Rien contre les chats mais définitivement chien.</p>
<p class="question">Viande ou végé ?</p>
<p>Viande assurément mais étant amoureux de la cuisine j’admets découvrir plusieurs mets végé qui me plaisent beaucoup. Je suis très ouvert. Si ça se mange, ça m’intéresse.</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p>J’ai dit tantôt que je déteste l’hiver mais le bas est le vêtement qui selon moi est le plus inutile. Chez moi, je suis toujours nu pied. Je ne possède aucune paire de bas de laine. Je le jure.</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>J’aime mon verre plein mais il ne le reste jamais longtemps.</p>
<p class="question">Finale de la coupe Stanley ou Série Mondiale ?</p>
<p>Sans aucune hésitation, la série mondiale.</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Il y a tellement de chose qui me vienne en tête. Chose certaine, il fait chaud. C’est l’été. Il y a de la bouffe. De la musique. Des gens que j’aime. Probablement de la boisson. Genre.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Si je réponds à cette question, je devrai te tuer. Sérieusement, soyez patient. J’ai très hâte de vous les annoncer.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Je dirais que malgré mes 30 saisons dans la ligue, c’est toujours un plaisir de voir qu’il y a encore des joueurs avec qui je n’ai pas jouer. Il y a quelques joueurs qui me viennent à l’esprit. C’est difficile à croire mais je n’ai jamais joué avec Bob Bureau et Denis Charbonneau et j’aimerai bien que ça se concrétise. D’autre avec qui j’aimerai jouer un jour qui on pas mal d’ancienneté dans la ligue sont, Keith Beauregard et Stéphane Barsalou. J’ai très hâte de rejouer avec mon bon chum Richard Germain, avec mon cher cousin Alex Bibeau et mon acolyte et très cher ami Michel Plante avec qui j’ai joué avec pour la dernière fois en 2008. J’ai été touché de voir mon nom sortir dans certains questionnaires. Merci et sachez que c’est réciproque.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Bin là? Franchement.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Je suis mieux d’avoir mal en ostie pour m’empêcher de jouer. Évidement, d’avoir une blessure qui me donnerai l’impression de nuire à mes coéquipiers, je me retirerai sans hésiter.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Très bonne. Il est important de toujours nourrir et travailler sur l’aspect de ligue amicale. C’est la clé à mon humble avis. Une ligue de balle, ce n’est pas compliquer à créer mais de l’amener à exister pour une 47esaison, c’est une autre chose. Il faut qu’il y ait quelque chose de plus. Je pense que de promouvoir et sensibilisé tous les joueurs de la ligue sur les valeurs de celle-ci est très important et essentiel pour que la LBMA reste unique et qu’elle existe pour de nombreuses années à venir.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Ma vitesse. Euh, point fort? Désolé. Je dirai ma vision du jeu.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Voir question 25.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Un petit caca d’avant-match est essentiel avant de me mettre en route. Disons que les toilettes ne sont pas très accessibles au parc Jarry. De la bonne musique dans la voiture quand je suis en chemin. Et finalement, de la visualisation et concentration. Fuck les étirements.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>J’ai été longtemps un joueur de champ-centre mais plus mon tour de taille a pris de l’expansion, plus je me suis rapproché du premier but, position que j’occupe depuis un petit bout. J’ai joué au 3ebut l’an dernier et j’ai beaucoup aimé. Merci à Tiger pour sa vision et sa confiance.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je pense apporter de la constance à une équipe. Tu sais ce que tu vas avoir avec moi. Je suis très rarement absent. Je crois être un bon coéquipier qui peut définitivement aider au niveau du coaching. En gros, c’est ça.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>J’adore les statistiques mais le seul objectif que j’ai au niveau individuel en ce qui les concerne, c’est de frapper pour une moyenne au-dessus de mon poids, ce qui est quand même élevé. Mon docteur essai fort de me faciliter la tâche. Cela étant dit, mon seul et unique objectif est vraiment d’aider mon équipe à gagner.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Je n’ai pas de réponse le fun à vous donner. Rien ne me vient à l’esprit. Cependant, quand tu t’élance de toute tes forces et que tu lèves la tête pour voir que tu as frappé une chandelle au lanceur par exemple…pas le fun.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Je ne veux pas que ce soit perçu comme prétentieux mais je répondrai moi. Je vous explique pourquoi. Je vous ai parlé de visualisation dans mes réponses précédentes, c’est en lien avec ça. Je veux vivre ces situations, je carbure à ce genre de moment. Vraiment. Si j’avais à choisir quelqu’un, je voudrais quelqu’un de difficile à retirer, un joueur qui met la balle en jeu. Actuellement, il y a Collard et Barsalou. Et dans notre histoire, je choisirai n’importe qui de la famille Blouin, et j’inclus Pierre. Des Machines de balles. Honnêtement, je prendrai une chance avec Joanne, la maman, tellement j’aurai confiance. André Dandurand est un choix facile. Richard Dupuis et David Asselin me donnerai aussi beaucoup de confiance.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Comme j’ai déjà dit, je crois être un bon coéquipier. J’ai du plaisir sur le terrain et j’essai de le transmettre. J’appui aussi mon coach du mieux que je peux en encourageant, en prodiguant des conseils et en soumettant des observations pertinentes pour aider l’équipe.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Je n’oublie jamais ce sport. En temps normale, hors covid, je vais effectivement frapper des balles habituellement une fois que les fêtes passent et plus le printemps se rapproche.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Relish, moutarde, chou. Un classique. Disons que peu importe la garniture, plus j’en mange, mois son les chances que je vole un but.</p>
<p>J’ai eu la chance d’être sur le terrain quand il a battu le record de coups sûr, voici l’ensemble de ses prouesses. 30 saisons, 682 parties jouées (1erall time), 1016 coups surs (1erall time), 779 simples (1erall time), 538 points comptés, 688 points produits (3eall time) pour une moyenne à vie de 0.476.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('robert-bureau', 'Robert Bureau', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<h3>Avec Bob Vegas Bureau</h3>
<p>Un des piliers de la ligue et membres du comité. Celui qui se peigne comme moi avec du « pledge », celui que l’on surnomme, Bob, bobe, bobby, babe, babu ou desk ! ;)</p>
<p>Voici Robert Bureau</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Depuis j’ai 16 ans. Mon père était membre fondateur de la ligue.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Je jouais au baseball quand j’étais jeune mais quand j’ai eu la chance de venir jouer avec mon père, j’ai profité de l’occasion. J’ai dû quitter pendant 2 ans à deux reprises différentes à cause du travail mais je n’ai jamais perdu l’amour pour la game ou la ligue.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>C’est la première chose dans ma vie que j’ai fait où j’étais bon. L’amour est venu immédiatement.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Stade Olympique avec mon père et ma tante qui m’amenait voir les Expos.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Bull Durham : un mot…hilarant. La relation entre Kevin Costner, Tim Robbins et Susan Surandon et EPIC!!</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>”You couldn’t hit water if you fell out of a fucking boat”</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Vegas!!!!!</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>J’ai déjà été coach pendant plusieurs années avec mon père et j’ai eu l’option de retourner à plusieurs repris mais je pense je suis biens comme membre de l’exécutif.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Pas vraiment</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Pas vraiment mais si c’est moi qui nous coûte la game oui je vais être fâché après moi-même.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Je jouais au Football back in the day! lol</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Voyager, Poker, film</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Ken Griffey Jr. Le plus beau swing EVER!!!Le joueur que j’ai essayé d’imiter le plus pendant toute ma carrière de balle.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Il y a beaucoup de moment individuel et comme équipe qui me viens en tête. Je pense être respecté par les membres de la LBMA et c’est celle dont je suis le plus fier.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Centre Field…..comme je disais, Ken Griffey JrJ</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Présentement je suis une fraction du joueur que j’étais. Avant j’aurai pu te sortir un longue liste. Là, je pense que je vais aller avec un joueur intelligent qui connait la game qui va toujours être là pour ces co-équipiers.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>J’espère !</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnel ?Crémeuse</p>
<p>Sucré ou Salé ?Sucré</p>
<p>Café ou Thé ?Thé</p>
<p>Yankees ou Red Sox ?Red Sox</p>
<p>Bière ou vin ?Vodka</p>
<p>Été ou Hiver ?l’automne</p>
<p>Pizza avec ou sans ananas ?Devrait être un crime mettre des ananas sur une pizza</p>
<p>Canadiens ou Nordiques ?0% intérêt pour le hockey</p>
<p>Sage ou tannant?Dépend ou et avec qui ;)</p>
<p>Chien ou chat ?Allergique aux deux</p>
<p>Viande ou végé ?Steak all the way</p>
<p>En bas de laine ou en bas de zéro ?bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?ni-un ni- l’autre. Le verre est simplement deux fois plus grand qui devrait être pour le contenu. ;)</p>
<p>Finale de la coupe Stanley ou Série Mondial ?Super Bowl</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>En vacance avec des chums. Relax. Bonne bouffe. Game de baseball ou football à regarder live et savoir que demain je vais être à Vegas.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je les connais tous, donc je dis rien ! lol</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Pat Chartrand. Je suis entré dans la ligue deux ans avant lui, je pense, et on a toujours joué les mêmes positions. On a tous les deux commencé comme champs centre et là on est tous les deux rendu premier but. Donc oui, j’aimerais bien joué avec mon ami avant que nos carrières prennent fin.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>100% C’est le meilleur mix d’ambiance familiale et compétition que tu peux avoir.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Ce n’est pas un gros secret qu’il y a 7 ans j’étais diagnostiqué avec la sclérose en plaque. C’était une dure épreuve à passer. J’ai dû réapprendre à marcher. Donc histoire courte, ça a beaucoup diminué mes capacités de jouer. Comme j’ai dit plus tôt, je suis une fraction du joueur que j’étais. Je peux dire par contre qu’en aucun moment qu’il y a eu un coéquipier qui m’a fait sentir que j’étais moins important qu’avant et je remercie tout le monde que j’ai joué avec pour ça.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Super bien, j’espère. La fondation est là. Les valeurs sont là. Le nouveau sang est là. Là, faut juste mettre tous ensemble. Faut pas oublier on est là pour jouer à un jeu qu’on voulait toujours aller jouer quand on était jeune. Pas pour revenir sur la question d’avant mais quand j’étais à l’hôpital et je faisais ma physio, j’étais loin de pouvoir jouer à la balle. C’est un privilège et faut pas l’oublier. On est gâté qu’on puisse se lever le matin ou le vendredi soir et aller au parc.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>En ce moment, je dirais ma connaissance de la balle et les joueurs de la ligue.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Je n’ai pas assez de GIG de Ram pour répondre lol ! Je pense ma grosse faiblesse est que je suis très dur sur moi-même et par moment ça affecte mon mental sur le terrain. J’ai encore de la difficulté à accepter que je ne suis plus le joueur que j’étais.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>À mon âge….stretching</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Premier but. Pour le moment thats it thats all.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Expérience, connaissance du jeu et je vais toujours donner tout ce que j’ai pour l’équipe. Aussi j’ai un IN avec l’exécutif ;)</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Sur le terrain être meilleur que la semaine d’avant</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Me faire caller une troisième prise par Donald qui est assis au deuxième but</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Moi…à 22 ans ;)lol J’aime la façon tu as posé la question parce que si j’ai juste besoin d’un hit ma réponse serait différente mais là on parle de pur puissance. Je vais aller avec Dave Asselin. J’ai rarement vue une balle voyager si loin.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Je suis dur sur moi-même mais jamais envers un coéquipier. Donc je dirais, je suis un bon coéquipier qui est toujours là pour aider et écouter dépendant de quoi tu as de besoin. Je suis fiable, je manque rarement des games et je donne tout ce que j’ai.</p>
<p class="question">34.Pendant la saison morte, va-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>A partir de janvier. Après la saison, j’ai besoin d’une couple de mois de repos mental de la balle.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>C’est tu vraiment un hot dog si y’a pas de ketchup???Come on ketchup all the wayJ</p>
<p>27 Saisons, ses 16 premières avec les Éperviers, équipe coaché par son père Michel, un des fondateurs de la ligue. 661 parties joués (4eall time), 2055 apparitions au bâton (5eall time), 808 coups sûrs (6eall time) et 0.393 moyenne à vie, 89 triple (1erall time), 68 circuits (3eall time) et 634 points comptés (4eall time), 656 points produits (6eall time) ….. Une Légende à la LBMA !!!</p>
<p>Alors Robert Bureau … en gros ;) c’est un mec avec le sourire qui t’accueille toujours de bonne humeur au parc.Mister, change pas !</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('sebastien-marchand', 'Sébastien Marchand', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Sébastien Marchand</p>
<p class="question">1. Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ? C’est ma 4e saison et plus ça va, plus j'apprécie cette ligue...c'est Phil Laverdiere et Guy Brisebois</p>
<p class="question">2. Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Je n’ai jamais vraiment été très assidu avec ce sport, j’ai joué un peu dans ma jeunesse jusqu'à 16-17 ans mais juste pour le plaisir avec mes amis dans le parc en arrière… j’ai été courtisé par Tiger et Phil Laverdiere pendant quelques années et j’ai fini par embarquer il y a 4 ans</p>
<p class="question">3. Explique-nous ta passion pour ce sport ?</p>
<p>C'était loin d'être une passion pour moi mais plus ça va et plus j’apprécie le sport et me retrouver avec les boys les fin de semaines</p>
<p class="question">4. Quel est ton premier souvenir de baseball ?</p>
<p>Quand Cecil Fielder a frappé l’anneau au Tiger stadium dans les années 90</p>
<p class="question">5. Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Les indiens avec Charlie Sheen parce que c'est le premier film de balle que j'ai vue</p>
<p class="question">6. Quelle est ta citation de film préférée ? Si tu le bâti, ils viendront (field of dream)</p>
<p class="question">7. Quel est ton péché mignon ? Tartare de bœuf</p>
<p class="question">8. Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Pourquoi pas!! Si un jour j’acquiers assez d’expérience</p>
<p class="question">9. Es-tu superstitieux ? Oui quand même, surtout dans mon habillement</p>
<p class="question">10. Es-tu mauvais perdant?</p>
<p>Je ne suis pas mauvais perdant mais je déteste perdre</p>
<p class="question">11. Pratiques-tu d’autres sports ? Hockey, disc golf, tennis</p>
<p class="question">12. En dehors du sport, as-tu d’autre passion ?</p>
<p>J'adore les animaux et en particuliers les baleines...j'en connais autant si ce n'est plus que plusieurs biologiste marin ainsi que la rando en montagnes (je marche en moyenne 100 km par été en montagne)</p>
<p class="question">13. Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ? Cecil Fielder</p>
<p class="question">14. Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle?</p>
<p>À ma première saison, quand j'ai joué au champ gauche contre les gris et grâce à ma défensive de feu ce soir-là (rien ne passais dans mon champ), nous avions réussis à égaliser la série et se rendre au match ultime en de la finale</p>
<p class="question">15. Quelle est ta position préférée … au baseball ? Champ gauche</p>
<p class="question">16. Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Je suis en constante évolution et j'essaie de m'améliorer chaque partie, rapide, je suis une éponge et prend tous les conseils pour m'améliorer</p>
<p class="question">17. Crois-tu au retour du baseball majeur à Montréal ? Oui mais plus ça va et plus ça me décourage</p>
<p class="question">18. Questions en rafales…</p>
<p>Coke ou Pepsi ? coke</p>
<p>Crémeuse ou Traditionnel ? traditionnel</p>
<p>Sucré ou Salé ? salé</p>
<p>Café ou Thé ? café</p>
<p>Yankees ou Red Sox ? sox</p>
<p>Bière ou vin ? les 2</p>
<p>Été ou Hiver ? les 2 mais été</p>
<p>Pizza avec ou sans ananas ? m'en fou lol</p>
<p>Canadiens ou Nordiques ? nordiques</p>
<p>Sage ou tannant? tres tannant</p>
<p>Chien ou chat ? chien</p>
<p>Viande ou végé ? viande</p>
<p>En bas de laine ou en bas de zéro ? en bas de la ceinture</p>
<p>Ton verre est à moitié plein ou à moitié vide ? plein</p>
<p>Finale de la coupe Stanley ou Série Mondial ? coupe stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19. Pour toi une journée parfaite c’est quoi ? Une journée passé dehors à faire de la randonnée en montagne et finir ca dans un bon resto.</p>
<p class="question">20. D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi? Je ne voudrais pas m'avancer mais je ne crois pas en gagner moi lol...peut être joueur amélioré un jour ...</p>
<p class="question">21. Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? Mes chums (les ducs)</p>
<p class="question">22. Recommanderais-tu la LBMA à tes chums joueurs de balle ? Ça c'est sûr! Tellement une belle gang</p>
<p class="question">23. As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Cette année je me suis blessé au hockey (entorse cheville) je suis obligé de jouer avec une prothèse sinon je ne serais pas capable d'évoluer</p>
<p class="question">24. Comment tu perçois l’avenir de la LBMA? Je pense qu'elle va toujours s'améliorer avec les gens qui s'impliquent comme toi et le comité d'administration</p>
<p class="question">25. Quel est ton point fort à la balle ? Rapide, bon motivateur, gars d'équipe et intense quand c'est le temps</p>
<p class="question">26. Quel est ta faiblesse ? Je joue trop stressé dans l'avant champ, ce qui me fait faire des erreurs par peur d'en commettre</p>
<p class="question">27. Comment te prépares-tu avant un match ? Musique dans le tapis en m'en venant à la partie</p>
<p class="question">28. Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Champ droit et j'aimerais plus souvent être à gauche, je ne sais pas pourquoi mais je me sens plus à l'aise de ce coté</p>
<p class="question">29. Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Parce que je suis un gars d'équipe et que j'essaie de m'améliorer à tous les jours.</p>
<p class="question">30. As-tu des objectifs personnels dans la LBMA ? Frapper en haut de 350 et ne pas être une nuisance pour l'équipe</p>
<p class="question">31. Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? Quand je suis tombé entre le 3e et le marbre cette année lol</p>
<p class="question">32. Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. Éric Collard</p>
<p class="question">33. Quel genre de coéquipier tu es ? Gars d'équipe qui ne rouspète jamais ou très rarement, qui a l'instinct du tueur et qui est là quand ça compte</p>
<p class="question">34. Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? Occasionnellement</p>
<p class="question">35. En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Ça ne fait jamais de tort mais c'est encore mieux avec du beurre😉</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('serge-chausse', 'Serge Chaussé', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<h3>Troisième entrevue avec Serge Chaussé</h3>
<p>Ici,j’ai un peu peur d’en arracher avec cette entrevue. Je ne voudrais pas qu’il ait une dent contre moi. J’ai les gencives sèches juste à y penser. En tout cas, ça molaire d’une bonne personne, je vais essayer de faire le pont entre nous et lui. Je vais faire extraction de questions douteuses. Puiser dans ses racines, le sortir de son palais et ne pas passer pour une tartre ! J’espère trouver des facettes de sa personnalité que l’on ne connait pas. Arrêtons de faire nos faces dentairement et débutons.</p>
<p>Que dieux nous Prothèse !Voici Serge Chaussé</p>
<p class="question">1-Depuis quand tu évolue dans la LBMA et qui t’y a introduit ?</p>
<p>Je suis entré dans cette belle famille en 1985, introduit pas Denis Paradis</p>
<p class="question">2- Avant la LBMA, as-tu joué au baseball mineur ou autre ligue de balle molle? Pour qui et quelle position tu évoluais ?</p>
<p>Je n’ai jamais joué au baseball ni à la balle molle avant 1984. A l’été 1984, j’ai décidé subitement que je voulais devenir lanceur.J’ai dessiné une cible sur un mur et je me suis pratiqué à lancer tout l’été.</p>
<p>A l’hiver, J’ai pris des leçons de lanceur et un de mes patients m’a présenté à Denis Paradis.J’ai continué à suivre des cours durant plusieurs années.Lors de mon interrogatoire avec Robert Auclair, alors président, je me suis inscrit dans la LBMA comme lanceur.Mais avec mon CV de joueur de balle, j’ai abouti au champ droit.</p>
<p class="question">3-Quel est ton premier souvenir de baseball ?</p>
<p>Les expos avec mon père au stade</p>
<p class="question">4-Explique-nous un peu ta passion pour la balle ?</p>
<p>J’ai toujours aimé les sports mais dans ma jeunesse, le sport ne faisait pas partie de notre famille, ferme, garage, seul le travail était important pour mes parents.Ma passion c’est révélé très tard dans ma vie.Match au stade, film de base balle, série mondiale.</p>
<p class="question">5-As-tu toujours été lanceur ?</p>
<p>Non, et comme je le disais précédemment, ma feuille de route n’a pas inciter la ligue à m’installer au monticule.</p>
<p>Mais en 1987, lors de la final, notre lanceur principale se blesse au Quad(Jean Claude Ménard).Le coach m’appelle du champ droit et me demande si c’est vrai que je lançais.Ma chance venait d’arriver après trois ans à pratiquer en solo.Je lui ai dit que oui.</p>
<p>Je vais donc au monticule et je gagne la première partie de la final puis dans l’après-midi nous devions jouer une autre partie pour remporter la final et je l’ai remporté.</p>
<p>J’ai remporté le trophée MVP des séries cette années-là.On m’avait surnommé smiley parce que je souriais en lançant.L’autre équipe ne me connaissait pas comme lanceur et pensait que je riais d’eux.En fait sans lunette de soleil, c’est tout mon visage qui plissait, Je ne riais certainement pas d’eux, j’étais tellement nerveux.</p>
<p>Depuis ce temps je lance dans la ligue, avec de bonne et moins bonnes années.</p>
<p class="question">6- Qui est ton joueur du baseball majeur favori, toutes époques confondues ?</p>
<p>Jackie Robinson</p>
<p class="question">7-Quel est ton film de balle préféré ?</p>
<p>Field of Dreams</p>
<p class="question">8-Est-ce que tu pratiques d’autre sport que la balle ?</p>
<p>Football (dans le passé), squash, tennis, golf , badminton</p>
<p class="question">9-On ne se connait pas beaucoup, comment tu pourrais te décrire en tant que joueur de balle ?</p>
<p>Un joueur très ordinaire qui mange de la balle.Je suis en deuil toute l’hiver.</p>
<p>Avant chaque partie, j’étudie les joueurs adverses afin de mettre en œuvre la meilleur stratégie de lancée.L’été c’est la balle molle qui prime.Je redescend de mon chalet à 2 :30 de route juste pour jouer, même dans mes vacances.Ce qui me chagrine le plus, c’est que mes jours son compter, a 65 ans, il ne reste pas beaucoup de saison.</p>
<p class="question">10- Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>En 1987 a mes premiers débuts comme lanceur, j’ai gagné mes deux premières parties de balle dans la LBMA en relève dans les deux derniers matchs ultimes de la Final et gain du MVP des série.</p>
<p class="question">11-Crois-tu au retour du baseball majeur à Mtl ?</p>
<p class="question">Oui , mais avec Plante ???</p>
<p class="question">12-Tu en a vu des joueurs passer dans la LBMA, si tu pouvais en faire revenir un joueur, qui serait-il ?</p>
<p>Écoute, il y en a tellement, Robert Tourangeau, un chum de longue date, plus pour sa qualité d’homme, que joueur, quoiqu’il fût un excellent frappeur, hypocrite en frappant au champ opposé à mainte reprise.</p>
<p>Christian Schiller, un des meilleurs arrêt court de l’histoire de la LBMA.</p>
<p class="question">13- Questions en rafale :</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Coke</p>
<p class="question">Crémeuse ou traditionnel ?</p>
<p>Traditionnel</p>
<p class="question">Café ou thé ?</p>
<p>Café</p>
<p>Yankees ou Red Sox ?nm</p>
<p>Yankees</p>
<p class="question">Bière ou vin ?</p>
<p>Vin</p>
<p class="question">Été ou hiver ?</p>
<p>Été</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Sans ananas</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Canadiens, mais je n’aime pas le hockey</p>
<p class="question">Finales de la coupe Stanley ou série mondial ?</p>
<p>Série Mondial</p>
<p class="question">14- En tenant compte de la proximité des buts ainsi que de la forme du losange, croyez-vous qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Débile cette question, pas de ketchup dans mon hotdog</p>
<p class="question">15- Encore une fois, ça fait un bout de temps que tu es dans la LBMA, peux- tu nous nommer quelques joueurs qui t’on marqués ?</p>
<p>Christian schiller, Bam, Pat Blouin, Jean Claude Ménard, Maurice junior Richard, et j’en passe tellement il y a eu de magnifiques joueurs dans cette ligue</p>
<p class="question">16-Pour conclure, comment tu perçois l’avenir de la LBMA ?</p>
<p>J’espère pouvoir y voir les fils des joueurs comme c’est la tradition depuis le début, donc faites des enfants les gars.Si nous avons d’autre recrue comme toi, la Ligue va durer et durer.</p>
<p>Notre sympathique lanceur au sourire « Colgate » a joué 454 parties, il a 1406 apparition au bâton et 345 coups sûrs. Comme lanceur, il a lancé 380 parties (3eall time), plus de 2000 manches lancées (3eall time) et 153 victoires (4eall time). L’année 2021 était sa 25esaison avec la LBMA !</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('simon-larin', 'Simon Larin', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Une personne silencieuse, qui ne prend pas beaucoup de place, agréable à discuter et indispensable dans une équipe.</p>
<p>Voici Simon Larin</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ? 7 ans et par hasard sur le net</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ? J’ai commencé dans une ligue de balle molle intérieure et une ligue à Laval puis la LBMA</p>
<p class="question">3.Explique-nous ta passion pour ce sport ? Depuis que je suis petit, on allait au Expos avec mes frères et j’aimais vraiment ça.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ? Un match un lundi soir un match presque parfait par un lanceur des expossous la pluie toute une soirée.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ? Moneyball pour le monde des statistiques avancées.</p>
<p class="question">6.Quelle est ta citation de film préférée ? Le film RUDY : Avoir des rêves est ce qui fait la vie tolérable.</p>
<p class="question">7.Quel est ton péché mignon ? Les Doritos</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ? Peut-Être on ne sait jamais où la vie nous amène.</p>
<p class="question">9.Es-tu superstitieux ? oui</p>
<p class="question">10.Es-tu mauvais perdant ? NonJe suis bon joueur</p>
<p class="question">11.Pratiques-tu d’autres sports ? Le ski, le golf</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? La musique, j’ai commencé la guitare (un nouveau défi)</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ? David Ortiz</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?Rien en particulier je pense que de m’améliorer à chaque année est pour moi une réussite.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? J’ai adoré finir la saison au 3ebut.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Très persévérant et toujours prêt à apprendre de nouvelles choses en vu de m’améliorer. Je suis un gars d’équipe.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? oui.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Coke</p>
<p>Crémeuse ou Traditionnelle ?Crémeuse</p>
<p>Sucré ou Salé ?Sucré</p>
<p class="question">Café ou Thé ?</p>
<p>Yankees ou Red Sox ?Red Sox</p>
<p>Bière ou vin ?Vin</p>
<p>Été ou Hiver ?Eté</p>
<p>Pizza avec ou sans ananas ?sans</p>
<p>Canadiens ou Nordiques ?Canadien</p>
<p>Sage ou tannant?Sage</p>
<p>Chien ou chat ?Chat</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?Bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?A moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Série Mondiale</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? 4 en 4 au bâton et gagner un championnat.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ? MVP : J.C. Dionne (la constance et le sens du jeu), Meilleur Lanceur : Stéphane Beaudoin (Sa détermination à Gagner), Défense : Sylvain Lamontagne : Sa précision dans ses relais, Attaque : Éric Collard (On se comprend).</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? Keith Beauregard</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui sans hésitation</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? Je pense qu’il y a de la relève et que le ligue va encore durée longtemps.</p>
<p class="question">25.Quel est ton point fort à la balle ? Le Bunt</p>
<p class="question">26.Quel est ta faiblesse ? Le reste (ha ha) Je dis toujours que je gagnerais le Beurrier D’OR pour mes retraits au bâton si le prix existait. Il faut savoir rire de nous un peu dans la vie.</p>
<p class="question">27.Comment te prépares-tu avant un match ? Je rêve aux jeux la veille c’est pas des farces, je visualise le terrain et je pense aux jeux à faire.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Le Champ et j’ai bien aimé mon expérience au 3ebut.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Mon attitude, mon esprit d’équipe et ma constance pour faire avancer des joueurs sur les buts.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Obtenir une moyenne de plus de 250 au bâton.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? Mon premier match en série la balle me passe entre les jambes et se ramasse et reste pris dans la clôture, le frappeur fait le tour des buts, une vrai honte, je n’étais pas très fier crois-moi.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. Eric Collard</p>
<p class="question">33.Quel genre de coéquipier tu es ? Toujours de bonne humeur et prêt à sauter sur le terrain. Je suis un gars très très déterminé. Je suis prêt à tous les sacrifices pour mon équipe.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? Il est difficile de d’aller frapper des balles dans mon coin mais je regarde des vidéos pour des trucs afin de m’améliorer et je continue à faire des jeux dans ma tête.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Salut à tous c’était le fun de faire le petit questionnaire. Merci à J.C. pour cette initiative et j’espère que cela va vous aider à mieux me connaître. On continue à suivre le tout sur le site. Joyeux Noël et Bonne année à tous. Simon</p>
<p>Au-delà des performances sur le terrain j’admire beaucoup Simon car il a le cœur à la bonne place. Il se donne à chaque présence au bâton et fait toujours de son mieux en défensive.</p>
<p>Simon a 7 saisons dans la LBMA, 146 parties jouées avec une moyenne à vie de 0.173</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('steve-beaudry', 'Steve Beaudry', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Le Lucky Luke de la parole, Monsieur anecdotes invraisemblables le seul et l’unique …</p>
<p>Steve Beaudry</p>
<p>J'évolue dans la LBMA depuis 2013 et c'est comme arbitre que j'ai découvert la ligue. J'aimais bien l'ambiance lors des parties et j'ai décidé de changer de camp.</p>
<p>J'ai commencé à jouer au base-ball à l'âge de 5 ans dans la catégorie Bébitte(T-ball)pour les loisirs Ste-Lucie, dans le quartier St-Micheljusqu'à l'âge de 12 ans. Ensuite pendant deux étés se fût des déménagements pour finalement aboutir àLaPlaine (maintenant fusionné à Terrebonne) où j'ai fini mes 4 dernières années au baseballmineur. Ensuite un passage à vide jusqu'en 2009 ou j'ai recommencé à joué à la balle molle à Mascouche avec mon frère et nos chums.</p>
<p>Comme j'étais poche au hockey, c'était plus facile pour moi et mes 3 autres cousins (avec nos amis) de jouer à la balle, et ce, pendant tout l'été.</p>
<p>Des premières parties jouées à 5 ans. À frapper sur un T-ball et à courir après la balle en défensive.</p>
<p>MajorLeague…car j'étais aussi badass que Rick Vaughn quand jelançais pour La Plaine… Aucun contrôle sur ma rapide quand je la poussais trop.</p>
<p>"Quand on veut très fort quelques choses, on finit toujours par y arriver" (Marty McFly à son père Georges en 1955 dans back to the future)</p>
<p>Aucune idée</p>
<p>Non</p>
<p>+/- ça dépend des étés</p>
<p>Très…Mais j'essaie de le garder intérieurement</p>
<p>Le hockey...hey oui je me suis amélioré sur le tard mais chu plus un goalerau cosom que j'ai joué pendant une couple d'années.</p>
<p>L'histoire (événement ou personnage).</p>
<p>Pedro Martinez</p>
<p>Ma plus grande réussite fut de faire l'équipe des Cardinaux de St-Michel (AA) à mes 2 dernières saisons à Montréal (moustique et peewee). Mon meilleur exploit fut de la sortir une couple de fois à Jarry.</p>
<p>J'ai bienaimé êtrereceveur/lanceur jusqu'à 12 ans et ensuite, après mes 2 années de cavale, lanceur etchampCentre dans mes dernières années</p>
<p>Polyvalent en défensive et bonne puissance au bâton…Intérieurement chu intense…Parfois trop</p>
<p>Oui</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnel ?Les deux</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Redsox</p>
<p>Bière ou vin ?Non merci</p>
<p>Été ou Hiver ?Printemps</p>
<p>Pizza avec ou sans ananas?Arrrrkkkkk des ananas sur une pizza? Quelle insulte pour ce mets délicieux</p>
<p>Canadiens ou Nordiques ?🤣😅</p>
<p>Sage ou tannant?Ça dépend de comment je me lève</p>
<p>Chien ou chat ?😺</p>
<p>Viande ou végé ?🥓🥩</p>
<p>En bas de laine ou en bas de zéro ?😳</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?World's series</p>
<p>Un peu de sérieux…</p>
<p>Seulement 2…La naissance de mes enfants que j'ai moi-même sortit et prit dans mes bras lors de la dernière poussé de ma conjointe (c'est la docteure qui m’a donné l'ordre de le faire, après m'avoir dit quoi faire)</p>
<p>Aucune idée à part smiley (Éric Collard) qui remporte un autre championnat de frappeur que je vais essayais de gagner l’été prochain.</p>
<p>Oui mais y veulent pas d'un draft...y veulent jouer ensemble</p>
<p>Non</p>
<p>Avec optimiste</p>
<p>Ma puissance et ma volonté de toujours donner monmaximum et d'aider mon équipe à gagner</p>
<p>Ma défensive laisse parfois à désirer</p>
<p>Rien en particulier sauf que plus ça approche, plus que je rentre dans ma bulle</p>
<p>Je n'ai pas de position préférer en particulier maistant que je serais capable d'aider en défensive partout sur le terrain, je joue ou on me dit de jouer... à part receveur</p>
<p>Powerhitter qui frappe pour la moyenne et qui peut frapper 3e ou 4e dans le line-up et polyvalent/fiable en défensive, peut jouer partout… Et aussi, comme dirait coach Ben, toujours une anecdote sur le baseball ou la balle molle!!!🤣</p>
<p>Après avoir flirté avec le recorddes PP en une saison, maintenant détenteur du record du plus de triple en une saison, ça sera toujours de me surpasser et faire de mon mieux.</p>
<p>C'était lors d'une finale au baseball mineur j'étais arbitre au marbre et comme je crie "playball" pour que la game commence, etcommeje me penche derrière le receveur,mon pantalons afendu au complet et j'ai dû arbitrer avec les culottes fendues pendant toute la rencontre exposant mes plus belles bobettes aux spectateurs en arrière du marbre.Le marquer et l'annonceur maison en avait mal au ventre à force de rire. J'en entends parler encore des fois🤣</p>
<p>Je l'ai vu évolué 3-4 saisons et je dis sans hésiter, Le Punisher, David Asselin. Pat Blouin ou Éric Collard serait mes choix suivants.</p>
<p>Bon vivant, prêt à donner des conseils et avec un bon esprit d'équipe.Parle trop des fois 🤣</p>
<p>Vous savez quand vous êtes en groupe et que le coach veut parler et qu’il y a un bruit de fond de quelque chose qui a pas rapport au moment présent et que tu es obligé d’y demander de la fermer, bien c’est monsieur Beaudry. Mais il très sympathique, faut connaitre le personnage.</p>
<p>9 saisons dans la LBMA, 193 partie jouées, 318 coups surs, 16 circuits, 209 points comptés, 277 points produits pour une moyennes à vie de 0.500 (dans le top 10 all time)</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('steve-pelletier', 'Steve Pelletier', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Steve Pelletier</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>C’est ma deuxième année dans la lbma. Invité par Éric Collard.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai commencé à jouer à la balle après avoir arrêté le baseball durant plusieurs années puis un de mes amis avec qui j’ai joué au baseball m’a demandé de venir voir une de ses game de balle. Je suis donc allé avec lui pour me rendre compte que ça me manquait ce sport donc l’année d’après j’ai commencé à jouer à la balle.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Ma passion pour se sport s’est développé au fil des années que j’ai joué. Au début il n’y avait pas assez de joueurs pour faire une équipe donc ils ont passés des dépliants puis ça m’a intéressé d’aller essayer.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Jouer au 500.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Le film de Jackie Robinson sorti en 2013. Premièrement, c’est un très bon film puis mon oncle m’appelait mon petit Jackie quand j’ai commencé à jouer au baseball.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Happy aussi sait faire des rimes avec des A même qu’il y a de l’odorat on verra qui sentira le rat.</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Ce n’est pas dans mes objectifs (non)</p>
<p class="question">9.Es-tu superstitieux ? Oui.</p>
<p class="question">10.Es-tu mauvais perdant ? Non.</p>
<p class="question">11.Pratiques-tu d’autres sports ? Deck hockey.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? Les femmes. Une créature vraiment fascinante.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Vladimir Guerrero.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Défi triple jeux, j’ai fini 2einter équipe 1erégionale puis 5eau provincial.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? Tous les champs ça me convient, shortstop, 2ebut</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Un joueur compétitif</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? J’aimerais bien dire oui mes je ne crois pas.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?: Pepsi</p>
<p>Crémeuse ou Traditionnel ?:crémeuse</p>
<p>Sucré ou Salé ?: sucré</p>
<p>Café ou Thé ?:café</p>
<p>Yankees ou Red Sox ?:Red Sox</p>
<p>Bière ou vin ?: bière</p>
<p>Été ou Hiver ?:été</p>
<p>Pizza avec ou sans ananas ?:sans ananas</p>
<p>Canadiens ou Nordiques ?:canadiens</p>
<p>Sage ou tannant?: tannant</p>
<p>Chien ou chat ?:chien</p>
<p>Viande ou végé ?: viande</p>
<p>En bas de laine ou en bas de zéro ?:laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?:plein</p>
<p>Finale de la coupe Stanley ou Série Mondial ?:coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? Un jour de congé</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Je ne sais pas, ça fait déjà 30 ans donc si le flambeau se passe, ça devrait rester encore des années.</p>
<p class="question">25.Quel est ton point fort à la balle ? Ma vitesse puis mon gant</p>
<p class="question">26.Quel est ta faiblesse ? J’ai eu de la misère au bâton, pas capable de la placer mais ces temps-ci, ça va bien</p>
<p class="question">27.Comment te prépares-tu avant un match ? Je fais le vide</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?: Champs centre : shortstop</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Parce-que je suis un gars d’équipe</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Non</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? Devoir sortir pour aller pisser pendant un match</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. : JC Dionne, Éric Collard.</p>
<p class="question">33.Quel genre de coéquipier tu es ? Encourage son équipe</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Ça arrive rarement d’aller frapper des balles</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Non c’est parfait.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('stephane-barsalou', 'Stéphane Barsalou', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Voici Monsieur Barsalou,</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>C’est Éric Collard qui est mon parrain dans la ligue depuis mes débuts en 2013</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Commencé à jouer au baseball à 8 ans dans les petites ligues à Dollard des Ormeaux (shortstop), Junior AAA (lanceur partant et troisième but) pour Lakeshore et St-Laurent.Ensuite pas de balle jusqu’en 2013!</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’adore ce sport, la radio était ouverte dans toutes les chambres de notre maison en grandissant, nous étions Expos. Après, j’ai appris à aimer le sport lui-même toute ses facettes. Les magazines, This week in baseball, des livres j’y ai puisé beaucoup d’inspiration. En fait, même quand j’étais un peu plus rebelles et que la discussion avec mon père était difficile, nous avons toujours gardé le lien en parlant de balle. Ça nous a permis ensuite de faire de beau voyage de balle ensemble avec mon neveu, à Washington, New York et Boston</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>La crème glacé après la game!</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>42 sur Jackie Robinson,quel inspiration et le lien avec Montréal est très cool</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>‘You can’t handle the truth’Jack NicholsonA few good men.Pas vraiment ma préférée mais la plus mémorable disons</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Sirop d’érable et encore plus de sirop d’érable (le nectar des dieux!!)</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Plus tard oui</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Vraiment, les mêmes bas, bobettes etc… de notre dernière victoire</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Moins avec le temps mais à la base oui.J’ai grandi avec beaucoup de compétition, ça devient une seconde nature de vouloir gagner.Avec le temps c’est sure que les amitiés passe bien avant le désir de gagner à tout pris</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Beaucoup de course à pieds, vélo, volleyball, soccer, hockey cosom</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>L’horticulture, la lecture, la mobilité active, l’implication communautaire</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Ken Griffey pour son sens du spectaculaire, Derek Jeter pour son leadership, Tim Raines pour sa vitesse et Roberto Clemente pour l’ensemble de l’œuvre.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Être choisis lanceur partant en demi-finale du Collegiate world series</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Receveur, j’adorais ‘caller’ la game, de faire équipe avec le lanceur</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Passionnés, rapide et dédié au concept d’équipe</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Je n’en sais pas assez pour savoir les chances mais j’espère de tout cœur retourner voir une game avec mon père</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Coke come on!</p>
<p class="question">Crémeuse ou Traditionnel ?</p>
<p>Hmm les deux</p>
<p class="question">Sucré ou Salé ?</p>
<p>Sucré</p>
<p class="question">Café ou Thé ?</p>
<p>Cafe</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Red Sox</p>
<p class="question">Bière ou vin ?</p>
<p>Biere</p>
<p class="question">Été ou Hiver ?</p>
<p>Été</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Sans</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Canadiens</p>
<p class="question">Sage ou tannant?</p>
<p>Les 2</p>
<p class="question">Chien ou chat ?</p>
<p>Chien</p>
<p class="question">Viande ou végé ?</p>
<p>Végé</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>Plein</p>
<p class="question">Finale de la coupe Stanley ou Série Mondial ?</p>
<p>Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Comme aujourd’hui,à la maison avec toute la famille et un soleil dehors</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je laisse ça au plus qualifié que moi!</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Stéphane Blouin</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Oui certainement mais ça fait tellement longtemps que mes chums de balle ce sont ceux de la LBMA</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Très chanceux de dire non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Une ligue qui a autant d’histoire, de famille multigénérationnelle, dans un parc mythique de Montréal (Le parc Jarry est un grand atout selon moi), the sky is the limit!</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>La lecture du jeu</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Précision des lancers, drôle de problème pour un ex-pitcher</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Ride de vélo</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>J’ai l’habitude du champ centre, shortstop, deuxième et j’aimerais une fois de temps en temps catcher</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je faisce que le coach me demande de faire et je suisun joueur d’équipe</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Difficile à avouer mais j’aimerais joindre Éric Collard, Pat Blouin et autres avec 3 titres demvp ou plus</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>3 erreurs dans une même manche, même Ben Hammaranger en perdait ses pédales!</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Éric Collard</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Celui qui espère le mieux pour tout le monde</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>J’oublie en faisant autre chose mais je n’oublie pas mon amour du sport</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>32 x 23 x 46 x irr2 au carré = la longueur de l'hypoténuse au point médian de la moyenne!</p>
<p>Stéphane Barsalou est une personne que je ne connais pas beaucoup qui n’est pas trop volubile sur le terrain mais qui est très efficace !</p>
<p>9 Saisons dans la LBMA, 180 parties jouées, 288 coups sûrs, 20 circuits, 273 points comptés, 196 points produits pour une moyennes à vie de 0.486 (dans le top 10 all time)</p>
<p>Voici Monsieur Barsalou,</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>C’est Éric Collard qui est mon parrain dans la ligue depuis mes débuts en 2013</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Commencé à jouer au baseball à 8 ans dans les petites ligues à Dollard des Ormeaux (shortstop), Junior AAA (lanceur partant et troisième but) pour Lakeshore et St-Laurent.Ensuite pas de balle jusqu’en 2013!</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’adore ce sport, la radio était ouverte dans toutes les chambres de notre maison en grandissant, nous étions Expos. Après, j’ai appris à aimer le sport lui-même toute ses facettes. Les magazines, This week in baseball, des livres j’y ai puisé beaucoup d’inspiration. En fait, même quand j’étais un peu plus rebelles et que la discussion avec mon père était difficile, nous avons toujours gardé le lien en parlant de balle. Ça nous a permis ensuite de faire de beau voyage de balle ensemble avec mon neveu, à Washington, New York et Boston</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>La crème glacé après la game!</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>42 sur Jackie Robinson,quel inspiration et le lien avec Montréal est très cool</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>‘You can’t handle the truth’Jack NicholsonA few good men.Pas vraiment ma préférée mais la plus mémorable disons</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Sirop d’érable et encore plus de sirop d’érable (le nectar des dieux!!)</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Plus tard oui</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Vraiment, les mêmes bas, bobettes etc… de notre dernière victoire</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Moins avec le temps mais à la base oui.J’ai grandi avec beaucoup de compétition, ça devient une seconde nature de vouloir gagner.Avec le temps c’est sure que les amitiés passe bien avant le désir de gagner à tout pris</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Beaucoup de course à pieds, vélo, volleyball, soccer, hockey cosom</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>L’horticulture, la lecture, la mobilité active, l’implication communautaire</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Ken Griffey pour son sens du spectaculaire, Derek Jeter pour son leadership, Tim Raines pour sa vitesse et Roberto Clemente pour l’ensemble de l’œuvre.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Être choisis lanceur partant en demi-finale du Collegiate world series</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Receveur, j’adorais ‘caller’ la game, de faire équipe avec le lanceur</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Passionnés, rapide et dédié au concept d’équipe</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Je n’en sais pas assez pour savoir les chances mais j’espère de tout cœur retourner voir une game avec mon père</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Coke come on!</p>
<p class="question">Crémeuse ou Traditionnel ?</p>
<p>Hmm les deux</p>
<p class="question">Sucré ou Salé ?</p>
<p>Sucré</p>
<p class="question">Café ou Thé ?</p>
<p>Cafe</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Red Sox</p>
<p class="question">Bière ou vin ?</p>
<p>Biere</p>
<p class="question">Été ou Hiver ?</p>
<p>Été</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Sans</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Canadiens</p>
<p class="question">Sage ou tannant?</p>
<p>Les 2</p>
<p class="question">Chien ou chat ?</p>
<p>Chien</p>
<p class="question">Viande ou végé ?</p>
<p>Végé</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>Plein</p>
<p class="question">Finale de la coupe Stanley ou Série Mondial ?</p>
<p>Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Comme aujourd’hui,à la maison avec toute la famille et un soleil dehors</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je laisse ça au plus qualifié que moi!</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Stéphane Blouin</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Oui certainement mais ça fait tellement longtemps que mes chums de balle ce sont ceux de la LBMA</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Très chanceux de dire non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Une ligue qui a autant d’histoire, de famille multigénérationnelle, dans un parc mythique de Montréal (Le parc Jarry est un grand atout selon moi), the sky is the limit!</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>La lecture du jeu</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Précision des lancers, drôle de problème pour un ex-pitcher</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Ride de vélo</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>J’ai l’habitude du champ centre, shortstop, deuxième et j’aimerais une fois de temps en temps catcher</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je faisce que le coach me demande de faire et je suisun joueur d’équipe</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Difficile à avouer mais j’aimerais joindre Éric Collard, Pat Blouin et autres avec 3 titres demvp ou plus</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>3 erreurs dans une même manche, même Ben Hammaranger en perdait ses pédales!</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Éric Collard</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Celui qui espère le mieux pour tout le monde</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>J’oublie en faisant autre chose mais je n’oublie pas mon amour du sport</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>32 x 23 x 46 x irr2 au carré = la longueur de l'hypoténuse au point médian de la moyenne!</p>
<p>Stéphane Barsalou est une personne que je ne connais pas beaucoup qui n’est pas trop volubile sur le terrain mais qui est très efficace !</p>
<p>9 Saisons dans la LBMA, 180 parties jouées, 288 coups sûrs, 20 circuits, 273 points comptés, 196 points produits pour une moyennes à vie de 0.486 (dans le top 10 all time)</p>
<p>Voici Monsieur Barsalou,</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>C’est Éric Collard qui est mon parrain dans la ligue depuis mes débuts en 2013</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Commencé à jouer au baseball à 8 ans dans les petites ligues à Dollard des Ormeaux (shortstop), Junior AAA (lanceur partant et troisième but) pour Lakeshore et St-Laurent.Ensuite pas de balle jusqu’en 2013!</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’adore ce sport, la radio était ouverte dans toutes les chambres de notre maison en grandissant, nous étions Expos. Après, j’ai appris à aimer le sport lui-même toute ses facettes. Les magazines, This week in baseball, des livres j’y ai puisé beaucoup d’inspiration. En fait, même quand j’étais un peu plus rebelles et que la discussion avec mon père était difficile, nous avons toujours gardé le lien en parlant de balle. Ça nous a permis ensuite de faire de beau voyage de balle ensemble avec mon neveu, à Washington, New York et Boston</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>La crème glacé après la game!</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>42 sur Jackie Robinson,quel inspiration et le lien avec Montréal est très cool</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>‘You can’t handle the truth’Jack NicholsonA few good men.Pas vraiment ma préférée mais la plus mémorable disons</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Sirop d’érable et encore plus de sirop d’érable (le nectar des dieux!!)</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Plus tard oui</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Vraiment, les mêmes bas, bobettes etc… de notre dernière victoire</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Moins avec le temps mais à la base oui.J’ai grandi avec beaucoup de compétition, ça devient une seconde nature de vouloir gagner.Avec le temps c’est sure que les amitiés passe bien avant le désir de gagner à tout pris</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Beaucoup de course à pieds, vélo, volleyball, soccer, hockey cosom</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>L’horticulture, la lecture, la mobilité active, l’implication communautaire</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Ken Griffey pour son sens du spectaculaire, Derek Jeter pour son leadership, Tim Raines pour sa vitesse et Roberto Clemente pour l’ensemble de l’œuvre.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Être choisis lanceur partant en demi-finale du Collegiate world series</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Receveur, j’adorais ‘caller’ la game, de faire équipe avec le lanceur</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Passionnés, rapide et dédié au concept d’équipe</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Je n’en sais pas assez pour savoir les chances mais j’espère de tout cœur retourner voir une game avec mon père</p>
<p class="question">18.Questions en rafales…</p>
<p class="question">Coke ou Pepsi ?</p>
<p>Coke come on!</p>
<p class="question">Crémeuse ou Traditionnel ?</p>
<p>Hmm les deux</p>
<p class="question">Sucré ou Salé ?</p>
<p>Sucré</p>
<p class="question">Café ou Thé ?</p>
<p>Cafe</p>
<p class="question">Yankees ou Red Sox ?</p>
<p>Red Sox</p>
<p class="question">Bière ou vin ?</p>
<p>Biere</p>
<p class="question">Été ou Hiver ?</p>
<p>Été</p>
<p class="question">Pizza avec ou sans ananas ?</p>
<p>Sans</p>
<p class="question">Canadiens ou Nordiques ?</p>
<p>Canadiens</p>
<p class="question">Sage ou tannant?</p>
<p>Les 2</p>
<p class="question">Chien ou chat ?</p>
<p>Chien</p>
<p class="question">Viande ou végé ?</p>
<p>Végé</p>
<p class="question">En bas de laine ou en bas de zéro ?</p>
<p class="question">Ton verre est à moitié plein ou à moitié vide ?</p>
<p>Plein</p>
<p class="question">Finale de la coupe Stanley ou Série Mondial ?</p>
<p>Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Comme aujourd’hui,à la maison avec toute la famille et un soleil dehors</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je laisse ça au plus qualifié que moi!</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Stéphane Blouin</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Oui certainement mais ça fait tellement longtemps que mes chums de balle ce sont ceux de la LBMA</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Très chanceux de dire non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Une ligue qui a autant d’histoire, de famille multigénérationnelle, dans un parc mythique de Montréal (Le parc Jarry est un grand atout selon moi), the sky is the limit!</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>La lecture du jeu</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Précision des lancers, drôle de problème pour un ex-pitcher</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Ride de vélo</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>J’ai l’habitude du champ centre, shortstop, deuxième et j’aimerais une fois de temps en temps catcher</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je faisce que le coach me demande de faire et je suisun joueur d’équipe</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Difficile à avouer mais j’aimerais joindre Éric Collard, Pat Blouin et autres avec 3 titres demvp ou plus</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>3 erreurs dans une même manche, même Ben Hammaranger en perdait ses pédales!</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Éric Collard</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Celui qui espère le mieux pour tout le monde</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>J’oublie en faisant autre chose mais je n’oublie pas mon amour du sport</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>32 x 23 x 46 x irr2 au carré = la longueur de l'hypoténuse au point médian de la moyenne!</p>
<p>Stéphane Barsalou est une personne que je ne connais pas beaucoup qui n’est pas trop volubile sur le terrain mais qui est très efficace !</p>
<p>9 Saisons dans la LBMA, 180 parties jouées, 288 coups sûrs, 20 circuits, 273 points comptés, 196 points produits pour une moyennes à vie de 0.486 (dans le top 10 all time)</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('stephane-beaudoin', 'Stéphane Beaudoin', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Un autre pilier de la ligue, membre du comité,</p>
<p>Je vous présente Stéphane Beaudoin,</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?Depuis 1991, 30eannée l’an passé, et oui je suis un des plus vieux de la ligue encore actif, c’est Gilles Levesque un ancien qui nous as quitté trop tôt, qui m’as fait entrer dans cette ligue, je jouais au football dans la ligue 4-20, je devais attendre l’âge requis pour me joindre n’étant pas un fils d’un membre.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?Je n’ai jamais joué dans une ligue organisé de mon coin de Rosemont, je me rappel m’avoir présenté dans un parc à l’âge de 10 ans tout seul pour jouer mais étant très timide et le fait que je ne connaissais personne j’ai viré de bord..Par la suite j’ai commencé à jouer à la balle molle à 19 ans dans des ligues de brasserie très compétitive et fait plusieurs tournois, dans le B .. Jusqu’à mon entré dans la LBMA..</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?Mon père était un inconditionnel de baseball, il allait voir les Royaux de Montréal au parc Delorimier, on allait au parc Jarry et au stade en famille voir les Expos, on apportait notre lunch pour souper et allais dans les bleacher à $1.00 dans le temps ..</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?Les maudits Yankees</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?Mr Baseball avec Tom Sellek , je me rappelle un passage quand son équipe fait venir ce personnage dans le bureau et qu’il pense qu’il est échangé, il chiale et dis à son patron, pas à Cleveland, son boss lui répond non pire, alors il réplique, pas au Canada …ca m’avais fait bien rire …</p>
<p class="question">6.Quelle est ta citation de film préférée ?GO AHEAD MAKE MY DAY … Dirty Harry Sudden Impact</p>
<p class="question">7.Quel est ton péché mignon ?Les pasta, toute sauce toute forme, toujours les pasta</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?Jamais, j’ai assez de stress dans ma vie, je n’ai pas besoin de courir après des remplaçants un Samedi matin en catastrophe avant ma game de 8h00</p>
<p class="question">9.Es-tu superstitieux ?Pas du tout, comme ma réponse d’en haut, j’ai assez de stress dans ma vie que de me soucier à refaire les mêmes choses avant chaque match, même repas, même bas, même trajet, je serais interné …de toute façon étant un TDA je me rappellerais pu ce que j’ai fait et ça empirerais mon cas .</p>
<p class="question">10.Es-tu mauvais perdant ?Non, perdre n’est pas plaisant mais on est là pour s’amuser,</p>
<p class="question">11.Pratiques-tu d’autres sports ?Non, j’ai déjà assez de misère à me remettre de la balle, j’essaye, je dis bien j’essaye de faire plus de vélo</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?La musique, qui peut vivre sans musique, le seul et unique sujet que le monde peux jaser sans s’insulter et se menacer sur les media sociaux, peu importe le style, Rock, Blues, Jazz, Classique, ca relaxe, il y a le cinéma aussi et bien sur les Pasta …</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?Pete Rose, le gars le plus intense dans tous les aspects du jeu que j’ai vu</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?Bien sûr devenir le lanceur de la LBMA avec le plus grand nombre de victoire, de matchs lancés et de manche lancés, bien sûr que ce n’est pas parce que je suis le meilleur mais juste celui qui a lancé depuis le plus longtemps …</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?3eBut,</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?Humm, difficile celle la car je ne suis pas du genre à parler de moi, ceux qui me connaissent le savent, j’aime mieux parler des autres que de moi, ce que je peux dire c’est que j’ai toujours donné tout ce que j’avais, même si j’en ai moins dans le corps qu’avant</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?Non , la raison est bien simple, il n’y as aucun homme ultra riche au Québec qui vas accepter de perdre de l’argent avec son équipe car il l’as acheté pour sa passion, comme ailleurs , tout le monde ici au Québec ne pense qu’à son portefeuille et au profits, ce ne serait que des groupes d’homme d’affaires et on sait très bien que si les Expos devait revenir il ne ferait pas d’argent avant 5 ou 6 ans .. et je ne crois pas à ce système de garde partagé, c’est bien rare que ça marche ben ca..</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnel ?Beuarkkk .. aucune</p>
<p>Sucré ou Salé ?Sucré</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Red Sox</p>
<p>Bière ou vin ?Bière</p>
<p>Été ou Hiver ?Été (Balle Molle)</p>
<p>Pizza avec ou sans ananas ?Ne comprendrai jamais ca.SANS</p>
<p>Canadiens ou Nordiques ?Canadienspour la vie</p>
<p>Sage ou tannant?Ishhhhh</p>
<p>Chien ou chat ?Chien … j’ai 2 chats chez moi</p>
<p>Viande ou végé ?Hahahaha …Viande, les légumes devrait être illégales</p>
<p>En bas de laine ou en bas de zéro ?Bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Malheureusement moitié vide</p>
<p>Finale de la coupe Stanley ou Série Mondial ?Coupe Stanley, désolé</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?Boire une bière sur le bord de l’eau, Lac, Océan, Rivière peu importe, le son de l’eau est le meilleur calmant, ensuite aller mangé un bon Spag avec des amis</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?Je le sais pas , je ne suis pas au courantJ</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?Après avoir enfin jouer avec Eric Collard l’an passé celui qui me vient en tête est Keith Beauregard, un des plus vieux avec qui je n’ai jamais joué, un chic type, une personne que j’aime beaucoup ..</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?Absolument, mais je n’ai pas d’amis à part les membres de la LBMA ..</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?Mis à part les multitudes de balles frappé sur moi, non j’ai jamais eu de blessure, je prends tellement soin de mon corps ..hehehehe</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?J’aimerais bien te dire que cette ligue vas durer très longtemps mais quand notre grand chef Michel Plante vas arrêter je ne sais pas qui vas prendre les reines comme il le fait, beaucoup de monde ont aucune idée de ce qu’il fait pour cet ligue, moi-même je ne serais pas capable de le faire, j’espère qu’il y as quelqu’un dans cet ligue qui pourras prendre le flambeau, mais pour l’instant il n’as pas le droit d’arrêter je lui ai interdit, j’ai tellement d’admiration pour lui il fait partis de ma vie depuis plus de 30 ans , nous avons un merveilleux groupe dans l’exécutif qu’on vas tout faire pour garder cet ligue tel qu’elle est</p>
<p class="question">25.Quel est ton point fort à la balle ?Pas mes genoux …j’en ai de moins en moins mais j’imagine que c’est mon pitching</p>
<p class="question">26.Quel est ta faiblesse ? Mes genoux ….Je n’ai plus la mobilitéd’antan</p>
<p class="question">27.Comment te prépares-tu avant un match ? J’arrive, thats it</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?Je lance, j’ai joué à toutes les positions dans mes 30 ans, j’ai pu rien à essayer.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?Parce que tu vas bien t’entendre avec moi, je ne suis pas compliqué</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA?A tous les ans les mêmes, aider mon équipe à gagner et pas me blesser</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?Une année je suis arrivé au parc avec les pantalons de balle de mon garçon qui jouais Atome je pense, une chance que Michel Plante avait une 2epaire, je me suis toujours demandé pourquoi il avait une 2epaire dans son auto ..</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.Patrick Blouin, parce que il pouvait la sortir, la frappé dans le gap mais le plus important c’est certain que le frappeur qui le suivais était dangereux comme ça ont pourrais pas le ballé ..</p>
<p class="question">33.Quel genre de coéquipier tu es ?Je le sais pas,j’ai beau te dire plein de choses c’est les autres qui jouent avec moi, ce sont eux qui pourrait dire quel genre de coéquipier, sinon tout ce que je ferais c’est dire ce que je pense que je suis pour les autres .</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?Quelques fois dans les semaines avant les premières pratiques</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?On doit toujours mettre du Ketchup dans un Hot-Dog</p>
<p>C’est une personne que je souhaite mieux connaitre dans les prochaines années.</p>
<p>Stéphane en est à sa 30esaison, il a 507 parties lancés (1erof All Time), plus de 2700 manches lancés (1erof All Time), 966 retraits au bâtons (2eof all time), 259 victoires (1erof all time), 204 défaites, 649 parties jouées (5eof all time), 2026 apparitions au bâton, 869 coups sûrs, 531 points comptés, 667 points produits (5eof all time) pour une moyenne de 0.429 à vie.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('stephane-blouin', 'Stéphane Blouin', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Un rouage important du succès des condors 2021 en séries, le cerveau derrière le personnage sur le terrain. Une autre bonne personne.</p>
<p>Stéphane Blouin</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?depuis 1988 grâce à mon père qui était déjà dans la ligue depuis 1977 si je me souviens bien.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?jouer jusqu’à environ 10 ans dans les petites ligues et j’ai commencé la balle molle à 18 ans</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?j’aime le fait qu’il n’y a pas d'horloge et que c’est toujours des batailles un à un (lanceur vs frappeur, joueurs vs la balle) et que c’est la défensive qui contrôle le jeu.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?mon père a Jarry</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ? 8 men out</p>
<p class="question">6.Quelle est ta citation de film préférée ? Aucune</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ? Hahahahahaahhah</p>
<p class="question">9.Es-tu superstitieux ? Pas du tout</p>
<p class="question">10.Es-tu mauvais perdant ? Plus jeune oui, plus maintenant</p>
<p class="question">11.Pratiques-tu d’autres sports ? Avant je jouais à mon sport favori le football maintenant je laisse ça au jeunes</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? Collectionner des objets de sports</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ? Ty Cobb</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ? D’avoir jouer si longtemps avec mon corps tout decalisser</p>
<p class="question">15.Quelle est ta position préférée au baseball ? J’ai été receveur pendant environ 10 ans dans des grosses ligues de balle, c’était tellement le fun de diriger les matchs.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Je suis plutôt un joueur défensif, polyvalent, pas le meilleur partout mais je pouvais remplacer n’ importe où sans faire mal à mon équipe. Au bâton, je suis un frappeur de simple et de double qui peut frapper n’importe où, assez intelligent pour m’adapter au lanceur.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? Oui</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ? Coors</p>
<p>Crémeuse ou Traditionnel ? Les 2</p>
<p>Sucré ou Salé ? Sucré</p>
<p>Café ou Thé ? Cafe</p>
<p>Yankees ou Red Sox ? Yankees</p>
<p>Bière ou vin ? Hahahahaha</p>
<p>Été ou Hiver ? Ete</p>
<p>Pizza avec ou sans ananas ? Sans</p>
<p>Canadiens ou Nordiques ? Go Habs Go</p>
<p>Sage ou tannant? Ça depends</p>
<p>Chien ou chat ? Ni un ni lautre</p>
<p>Viande ou végé ? Viande</p>
<p>En bas de laine ou en bas de zéro ? Bas de zero</p>
<p>Ton verre est à moitié plein ou à moitié vide ? S’il y a de la bière dedans il est pas mal toujours vide</p>
<p>Finale de la coupe Stanley ou Série Mondial ? Coupe stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? Passer la journée à jouer avec mes enfants et ensuite un bon souper avec ma femme et enfants, le tout sans téléphone cellulaire</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ? Lanceur Santo,Offensif toi,Defensif Tiger,Mvp Collard.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? Stephane Barsalou</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Reconstruction du poignet (raté presque une saison complete)</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? Très bien</p>
<p class="question">25.Quel est ton point fort à la balle ? Patience au bâton ( un but sur balle est la même chose qu’un coup sur ) et aussi mon baseball IQ</p>
<p class="question">26.Quel est ta faiblesse ? Vitesse lol</p>
<p class="question">27.Comment te prépares-tu avant un match ? Rien de special</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Je les ai tous essayés, plus tu es jeune plus tu joue les positions du milieu et plus tu vieilli et grossit plus tu t’approche des lignes</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Ça arrivera pas lol</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?non pu maintenamt</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? Quand je suis aller prendre ma position en défensive au 2iem but avec mon casque de frappeur et pas de mitt ,tout ça après que Alex Bibeau ma garocher une balle en arrière de la tête, c’est tu ça une commotion ???</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. Anciens :Patrick Blouin et Éric Vezina ,Present :Éric Collard et Stephane Barsalou</p>
<p class="question">33.Quel genre de coéquipier tu es ? Demande aux Condors</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? J’oublie la balle jusqu’au premier meeting des coach et je vais jamais frapper de balles</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Non</p>
<p>Ce gentlemen m’a ouvert les portes de son sanctuaire du baseball sans vraiment me connaitre, je crois que lorsque une personne passionné en rencontre une autre pour la même passion, un contact se crée.</p>
<p>Je ne peux penser au jour que je ne pourrais plus enfiler mes crampons pour faire ce que j’aime le plus, je suis déchiré de l’intérieur pour toi Steff.J’espère que tu viendras prendre une frette dans les estrades avec ton père et ton fils et qu’une date pour ton opération aboutira rapidement. J’espère que ce ne sera pas juste les Condors que tu viendras voir ! ;) Un autre grand Blouin, que je n’ai pas eu la chance de connaitre à la bonne époque.</p>
<p>Stéphane a joué 26 saisons, 597 parties jouées, 1804 apparitions au bâton, 874 coups sûrs (3eof all time), 63 circuits (6eof all time), 723 points comptés (2eof all time), 681 points produits (3eof all time) pour une moyenne à vie de 0.484.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('stephane-hetu', 'Stéphane Hétu', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec ...</h2>
<p>Je n’ai pas beaucoup côtoyé ce monsieur mais il m’était toujours sympathique, je vais mieux le découvrir avec vous.</p>
<p>Voici Stéphane Hétu;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>J’ai découvert la ligue il y a plusieurs années alors que j’étais arbitre (je m’excuse à Pat Chartrand pour ça) je trouvais l’ambiance extraordinaire. Quand j’ai voulu revenir à la balle, j’ai contacté Michel Plante en faisant des recherches sur le web. Ça fait maintenant 4 saisons que je suis là.</p>
<p class="question">2.Raconte-nous ton parcourt de balle au travers des années ?</p>
<p>J’ai beaucoup joué au baseball quand j’étais jeune, j’ai même eu Sylvain Longtin comme coach. Plus tard, on a aussi coaché ensemble. Quel hasard de le retrouver dans la ligue. Par la suite, j’ai beaucoup coaché au baseball mineur et finalement joué dans une ligue de balle rapide… quand j’étais jeune et plus rapide hahaha !!</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’adore que ce soit un sport sans chronomètre, tout peut arriver à la balle et ce n’est jamais fini. Pour moi c’est aussi synonyme de vacances. C’est l’été, je suis en vacances et cette ambiance n’a rien à voir avec les arénas. Je trouve qu’on devrait jouer un soir de plus en passant😉</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>C’est peewee, je crois, mon père ne pouvait pas venir me voir bien souvent. Un jour il m’a dit qu’il devrait partir après ma première présence au bâton. J’ai eu la chance de frapper la balle jusqu’à dans la barboteuse du parc Saint-Paul. Des larmes de joies sur les joues en contournant les buts. (Arrêtes tu vas me faire brailler JC)</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Moneyball évidemment, je travaille dans la gestion sportive depuis toujours alors j’ai capoté sur ce film.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Je connais bien sûr le film Slap Shot par cœur… mais je dirais « la dureté du mental » Je trippe aussi sur le speech dans « Any given Sunday »</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Les fruits de mer… je me suis payé la traite en Gaspésie l’été dernier.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>J’ai tellement hâte d’avoir l’occasion!</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Pas du tout… j’aimerais même porter le numéro 13… mais il est clairement trop petit.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>De moins en moins avec les années, je suis comme le vin je crois que je m’améliore avec le temps.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Je viens de cesser de jouer au hockey. Je fais beaucoup de ski, j’adore les moments de réflexion et de tranquillité sur les montages. Je joue au golf aussi.</p>
<p class="question">12.En dehors du sport, as-tu d’autres passions ? Mon travail, je trippe vraiment sur ce que je fais. J’ai le privilège de gérer les équipes sportives des Spartiates du Cégep du Vieux Montréal. C’est vraiment, vraiment génial.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toutes époques confondues ?</p>
<p>Gary Carter, pour moi, c’était le Guy Lafleur des Expos.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Comme joueur rien ne me vient à l’esprit. Mais comme coach, j’ai gagné les championnats provinciaux pour la région de Montréal Peewee et je vais m’en souvenir toute ma vie.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Receveur, j’ai été receveur toute ma vie. Je suis incapable de jouer à cette position maintenant à cause d’un genou qui ne collabore pas. Ultimement j’aimerais jouer au 1erbut, mais c’est n’est pas ben ben grave. L’important c’est d’être là!</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Je pense être très très difficile à retirer sur 3 prises. Je crois aussi avoir la caractéristique d’être vraiment meilleur en séries que pendant la saison.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Oui, même si la patente de 50/50 m’irrite.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Bière</p>
<p>Crémeuse ou Traditionnelle ?Crémeuse</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Red Sox</p>
<p>Bière ou vin ?Vin</p>
<p>Été ou Hiver ?Été</p>
<p class="question">Pizza avec ou sans ananas ?Un sceau pour vomir avec ça?</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?Je répondrai à cette question qu’en présence de mon avocat.</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En short jusqu’en novembre.</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Plein</p>
<p>Finale de la coupe Stanley ou Série Mondial ?Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Une journée de ski au Massif dans un chalet sur les pentes.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Aucune idée, mais je sais que je n’ai rien gagné hahahaha.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer, mais que tu n’as pas encore eu la chance de le faire ? Avec Sylvain Longtin, ça va me rappeler des souvenirs.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>ÉVIDEMMENT! Mon fils va peut-être jouer un jour également.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Cette saison j’ai joué toute l’année avec une fracture du coude gauche, d’habitude je suis meilleur que ça, tu sais. Ça va revenir.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Très bons, les gens en place sont de bonnes personnes. C’est la base de tout.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Mon œil au bâton.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Je suis incapable de jouer dans le champ… j’ai l’air d’un débile.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>J’arrive le premier, j’adore être là de bonne heure et être dans l’ambiance du parc.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>J’aimerais jouer au 1ersur une base régulière. Sinon laissez-moi au 3ehahahaha !!!</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Pour mon expérience et parce que je suis vraiment drôle.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>J’aimerais coacher, je crois que je peux apporter quelque chose de cool. Sinon, j’aimerais frapper un circuit dans la droite quand le train passe au parc Jarry.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>J’ai déjà essayé de voler un but… je ne referai jamais ça.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. Toi JC évidemment!!!</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Le genre qui apporte la bière et qui reste trop longtemps au parc… je dirais sociable.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Je décroche complètement, trop occupé avec le travail.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Relish, moutarde, oignon!</p>
<p>Stéphane Hétu joue depuis 4 saisons, 60 parties jouées, 196 apparitions au bâton, 76 coups sûrs et 0.388 de moyenne à vie.</p>
<p>Vous voyez, personne n’est parfait… il a déjà été arbitre !! Messieurs du comité, voilà quelqu’un qui aimerait coacher ! Vive les volontaires ;)</p>
<p>Je n’ai pas beaucoup côtoyé ce monsieur mais il m’était toujours sympathique, je vais mieux le découvrir avec vous.</p>
<p>Voici Stéphane Hétu;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>J’ai découvert la ligue il y a plusieurs années alors que j’étais arbitre (je m’excuse à Pat Chartrand pour ça) je trouvais l’ambiance extraordinaire. Quand j’ai voulu revenir à la balle, j’ai contacté Michel Plante en faisant des recherches sur le web. Ça fait maintenant 4 saisons que je suis là.</p>
<p class="question">2.Raconte-nous ton parcourt de balle au travers des années ?</p>
<p>J’ai beaucoup joué au baseball quand j’étais jeune, j’ai même eu Sylvain Longtin comme coach. Plus tard, on a aussi coaché ensemble. Quel hasard de le retrouver dans la ligue. Par la suite, j’ai beaucoup coaché au baseball mineur et finalement joué dans une ligue de balle rapide… quand j’étais jeune et plus rapide hahaha !!</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’adore que ce soit un sport sans chronomètre, tout peut arriver à la balle et ce n’est jamais fini. Pour moi c’est aussi synonyme de vacances. C’est l’été, je suis en vacances et cette ambiance n’a rien à voir avec les arénas. Je trouve qu’on devrait jouer un soir de plus en passant😉</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>C’est peewee, je crois, mon père ne pouvait pas venir me voir bien souvent. Un jour il m’a dit qu’il devrait partir après ma première présence au bâton. J’ai eu la chance de frapper la balle jusqu’à dans la barboteuse du parc Saint-Paul. Des larmes de joies sur les joues en contournant les buts. (Arrêtes tu vas me faire brailler JC)</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Moneyball évidemment, je travaille dans la gestion sportive depuis toujours alors j’ai capoté sur ce film.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Je connais bien sûr le film Slap Shot par cœur… mais je dirais « la dureté du mental » Je trippe aussi sur le speech dans « Any given Sunday »</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Les fruits de mer… je me suis payé la traite en Gaspésie l’été dernier.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>J’ai tellement hâte d’avoir l’occasion!</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Pas du tout… j’aimerais même porter le numéro 13… mais il est clairement trop petit.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>De moins en moins avec les années, je suis comme le vin je crois que je m’améliore avec le temps.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Je viens de cesser de jouer au hockey. Je fais beaucoup de ski, j’adore les moments de réflexion et de tranquillité sur les montages. Je joue au golf aussi.</p>
<p class="question">12.En dehors du sport, as-tu d’autres passions ? Mon travail, je trippe vraiment sur ce que je fais. J’ai le privilège de gérer les équipes sportives des Spartiates du Cégep du Vieux Montréal. C’est vraiment, vraiment génial.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toutes époques confondues ?</p>
<p>Gary Carter, pour moi, c’était le Guy Lafleur des Expos.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Comme joueur rien ne me vient à l’esprit. Mais comme coach, j’ai gagné les championnats provinciaux pour la région de Montréal Peewee et je vais m’en souvenir toute ma vie.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Receveur, j’ai été receveur toute ma vie. Je suis incapable de jouer à cette position maintenant à cause d’un genou qui ne collabore pas. Ultimement j’aimerais jouer au 1erbut, mais c’est n’est pas ben ben grave. L’important c’est d’être là!</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Je pense être très très difficile à retirer sur 3 prises. Je crois aussi avoir la caractéristique d’être vraiment meilleur en séries que pendant la saison.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Oui, même si la patente de 50/50 m’irrite.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Bière</p>
<p>Crémeuse ou Traditionnelle ?Crémeuse</p>
<p>Sucré ou Salé ?Salé</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Red Sox</p>
<p>Bière ou vin ?Vin</p>
<p>Été ou Hiver ?Été</p>
<p class="question">Pizza avec ou sans ananas ?Un sceau pour vomir avec ça?</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?Je répondrai à cette question qu’en présence de mon avocat.</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En short jusqu’en novembre.</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Plein</p>
<p>Finale de la coupe Stanley ou Série Mondial ?Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Une journée de ski au Massif dans un chalet sur les pentes.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Aucune idée, mais je sais que je n’ai rien gagné hahahaha.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer, mais que tu n’as pas encore eu la chance de le faire ? Avec Sylvain Longtin, ça va me rappeler des souvenirs.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>ÉVIDEMMENT! Mon fils va peut-être jouer un jour également.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Cette saison j’ai joué toute l’année avec une fracture du coude gauche, d’habitude je suis meilleur que ça, tu sais. Ça va revenir.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Très bons, les gens en place sont de bonnes personnes. C’est la base de tout.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Mon œil au bâton.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Je suis incapable de jouer dans le champ… j’ai l’air d’un débile.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>J’arrive le premier, j’adore être là de bonne heure et être dans l’ambiance du parc.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>J’aimerais jouer au 1ersur une base régulière. Sinon laissez-moi au 3ehahahaha !!!</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Pour mon expérience et parce que je suis vraiment drôle.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>J’aimerais coacher, je crois que je peux apporter quelque chose de cool. Sinon, j’aimerais frapper un circuit dans la droite quand le train passe au parc Jarry.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>J’ai déjà essayé de voler un but… je ne referai jamais ça.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. Toi JC évidemment!!!</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Le genre qui apporte la bière et qui reste trop longtemps au parc… je dirais sociable.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Je décroche complètement, trop occupé avec le travail.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Relish, moutarde, oignon!</p>
<p>Stéphane Hétu joue depuis 4 saisons, 60 parties jouées, 196 apparitions au bâton, 76 coups sûrs et 0.388 de moyenne à vie.</p>
<p>Vous voyez, personne n’est parfait… il a déjà été arbitre !! Messieurs du comité, voilà quelqu’un qui aimerait coacher ! Vive les volontaires ;)</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('sylvain-forgues', 'Sylvain Forgues', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Voici une autre légende de la ligue, un pillé qui est revenu au nid de la LBMA après une absence. Un mélange de grand-papa Bi et un motard ! Un autre bon Jack que j’ai découvert l’été dernier.</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>J’ai commencé en 1993 à 2000, j’ai quitté pour 19 ans et j’ai fait un retour il y a 3ans et via une annonce dans le journal de Montréal, il demandait un lanceur… jdm hihihi</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai commencé à l’âge de 5 ans pour la paroisse St Eusèbe et ma première games en 1971 dernière l’ancien stade Delorimier, j’ai joué jusqu’à 17 ans baseball amateur et par la suite la balle-molle.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Pour moi c’est une religion autant que le hockey ça dit tout</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Mon plus beau souvenir de qu’en j’ai reçu mon premier trophée🏆à ma première saison de la main de Rodger Brulotte et Ron Piché.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Champ de rêve</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Dans Les boys (sacrament Bob )hihihihihi</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>La pizza🍕🍕🍕🍕et un steak de faux</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non plus aujourd’hui, je laisse ça pour nos jeunes</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Oui très beaucoup énormément oufff ça va jusqu’au bobette hihihih</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Oui je déteste la défaite mais je me replace vite. Mon respect pour mes adversaires me ramène vite sur terre hihih</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Oui, hockey, golf, paintball</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Ma famille</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Le kid Carter</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Avoir joué 7 programmes double dans une fin de semaine, dans ce temps, je mangeais de la balle oufff !</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Receveur mais j’adore lancer aussi c’est moins dur pour le corps</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Joueur moyen avec un grand esprit d’équipe qui n’abandonne jamais</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Pas vraiment mais j’adorais ça un retour bien sûr</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Coke</p>
<p>Crémeuse ou Traditionnelle ?traditionnelle</p>
<p>Sucré ou Salé ?Sucré</p>
<p>Café ou Thé ?Cafés</p>
<p>Yankees ou Red Sox ?Red sox</p>
<p>Bière ou vin ?Bières</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Sans</p>
<p>Canadiens ou Nordiques ?Canadien</p>
<p>Sage ou tannant?Tannant j’adore déconner</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Viande, carnivore</p>
<p>En bas de laine ou en bas de zéro ?en bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Trop dûr pour moi mais série mondiale</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Être en santé avec ma douce et mais enfants et petits enfants et un gros bbq et une petite frette</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Je peux dire bonne chance à tous</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Toi JC j’aime bien ton attitude et ton talent</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Bien sûr et dans le passé j’ai fait entrer 5 ou 6 amis dans cette belle ligue</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Oui en 2019 perforation de l’intestin, j’ai manqué 1 game, en général je joue avec les blessures, j’ai beaucoup de misère à rater une game pourquoi que ce soit</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Cette année, il y a eu des choses bizarres qui se sont passées et j’ai vraiment pas aimer mais en général j’adore cette ligue sinon j’aurais fait un retour ailleurs lbma je vous aime❤️</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Mon esprit d’équipe et ma détermination</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>J’ai tendance à me laisser déconcentrer à l’occasion mais je reviens vite</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Petit sieste, petit repas et un petit réchauffement et vla !</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Receveur l’année passée, j’ai compris que je devais changer de position et vla, je deviens lanceur, sa aussi j’adore !</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Mon leadership et ma persévérance</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Oui, l’année prochaine, j’aimerais connaitre une belle saison comme lanceur avec une récolte de minimum 15 victoires sur 25 Games, c’est réaliste selon moi, oh que Oui !</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Pas vraiment de souvenirs</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Bob bureau à 25 ans oufff</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Selon moi un gars qui aime s’amuser, jocker</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Ça peut arriver surtout en février mars, il y a des chances</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Bien mets-en du ketchup</p>
<p>Pour les 3-4 games que j’ai vu Sylvain lancer, je crois qu’il a l’étoffe d’être un lanceur numéro 1 !</p>
<p>8 saisons dans la LBMA, 200 parties jouées, 248 coups sûrs et une moyenne à vie de 0.380</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('sylvain-longtin', 'Sylvain Longtin', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Sylvain est mon parrain de la LBMA, on s’est connu dans une autre vie, lorsque jouer 6 parties dans la même journée ne nous dérangeais pas trop ! Alors je présente un maudit bon Jack, Sylvain Longtin !</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Cela fait 5 ans que je suis dans cette merveilleuse ligue et mon parrain est Joe Desrosiers</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J'ai commencé à l'âge de 5 ans au loisir St-Paul de la croix dans Ahuntsic pour ensuite graduer au niveau élite et finir au niveau midget.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>La passion pour ce sport,comment la décrire, c'est un sentiment de réconfort d’être sur un terrain. Le fun d’être avec une gang qui tire dans la même direction, je pense que seulement ceux qui en mange vont comprendre cette passion</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Mon premier souvenir est de tenir un bâton dans les mains et de devoir frapper sur un t-ball et de faire une crise par ce que ce n’est pas un lanceur qui me lance.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Je n’ai pas de préféré. Je pense qu’ils sont à peu près tous bon car quand il en passe un, je l'écoute.</p>
<p class="question">6.Quelle est ta citation de film préférée ?j'ai pas mal, j'ai pas mal (dans Rocky)</p>
<p class="question">7.Quel est ton péché mignon ?d'après ma blonde c’est la balle, moi je vais plus aller vers le chocolat et les pâtes.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?Non, j'ai déjà assez donné, juste le plaisir de venir jouer me satisfait. Donner un coup de main fait plaisir aussi.</p>
<p class="question">9.Es-tu superstitieux ?Si toujours faire la même routine les jours de match en commençant le matin, même si la game est le soir, peut être un peu !</p>
<p class="question">10.Es-tu mauvais perdant ?Non pas mauvais perdant, mais l’idée de gagner des matchs, j’aime bien ça</p>
<p class="question">11.Pratiques-tu d’autres sports ?Avant je jouais au hockey mais depuis 4 ans j’ai arrêté à cause des commotions et je suis devenu craintif sur la glace.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?J'ai découvert le plaisir de partir avec ma blonde en voyage</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?Il en a plusieurs mais je dirais Ken Griffey, juste à le voir frapper !</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?Réussir un triple jeu à moi tout seul, c’est assez trippant.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?J'aime bien l'arrêt court, mais je dirais qu’être sur le terrain est un bon feeling</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?Je suis un joueur intense qui veux tout réussir mais qui aime féliciter un joueur adverse pour une belle frappe ou un beau jeu défensif.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?J'aimerais tellement ça mais......</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Coke</p>
<p>Crémeuse ou Traditionnel ?Crémeuse</p>
<p>Sucré ou Salé ?sucré</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Yankees</p>
<p>Bière ou vin ?vin</p>
<p>Été ou Hiver ?été</p>
<p>Pizza avec ou sans ananas ?Sans !!</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?Un peu des 2</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Toujours à moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ?Série mondiale</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?un samedi matin avec ton amoureuse, petit déjeuner dans mon resto préféré ensuite direction pour une belle journée de balle au parc pour ensuite finir ça dans ma cours avec un verre de vin rouge à la main</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?Je ne sais pas qui va les gagner mais je crois que JC Dionne devrait amener un gros camion.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?Dure question il y a plusieurs joueurs avec qui j'aimerais jouer mais une saison avec Stéphane Hetu serait un beau retour dans le passé. (J’ai déjà été son entraineur plus jeune et ensuite nous avons été entraineur ensemble)</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?Je la recommande à tous joueurs de balle,Quelle belle ligue !</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?Oui, j’étais lanceur, pas de masque, une flèche frappé en plein centre, résultat fracture de la mâchoire et 6 semaines à manger mou !</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?Avec les gens qui s'implique et le temps qu’ils mettent pour nous donner de très belle saison, je ne suis pas inquiet, nous somme entre bonne main.</p>
<p class="question">25.Quel est ton point fort à la balle ?Mon point fort est d’aimer ça jouer à la balle.</p>
<p class="question">26.Quel est ta faiblesse ?Je vais dire que un de mes point faible est la vitesse, on est plus aussi jeune ça à l'air.</p>
<p class="question">27.Comment te prépares-tu avant un match ?Ma préparation consiste à dire bonjour à tous monde, fumer une cigarette et ne pas voir de point noir en attachant mes souliers. Si tous est réussie, ça sera une belle partie</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?Je joue souvent comme arrêt court, mais il n'a pas de position que j'aimerais, c'est à mon entraineur de me faire jouer ou il veut.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?Parce que je suis un joueur d'équipe qui aime avoir énormément de plaisir et qui est toujours de bonne humeur, (je pense que je n’ai pas répondue à la question. lol</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?Mon seul objectif personnel est de finir la saison sans être blessée, pour le reste c’est d’avoir du plaisir</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?Frapper dans le gap, partir à courir comme un malade, contourner le premier but, commencer à perde l’équilibre et finir ça étendu comme une crêpe avant d’arriver au deuxième but.</p>
<p class="question">32.Un compte de 3 balles, 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.Je veux voir Éric Collard ou JC Dionne, je pense que je me donne des chances de gagner avec ces 2 là.</p>
<p class="question">33.Quel genre de coéquipier tu es ?J'espère être de bonne compagnie avec qui on aime rire, toujours prêt à aider un coéquipier, le gars qui va au parc pour s’amuser.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?Non, je ne vais pas frapper des balles, je suis naturel ! hahahaha !</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?L'affaire est toujours Ketchup</p>
<p>Sylvain est comme le bon vin, avec le temps il devient meilleur.</p>
<p>5 saisons, 95 parties jouées, 152 coups surs, 120 points produits, pour une moyenne à vie de 0.455</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('sylvain-st-georges', 'Sylvain St-Georges', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<h3>Sylvain St-George</h3>
<p>Je suis quelqu’un qui arrive tôt à mes matchs et plus souvent qu’à mon tour celui avant le mien. Alors quand j’arrivais au parc cet été et que je voyais au loin un petit (set up) de campeur, je savais que le grand gaillard des aigles était déjà là. Je pensais être le seul fou de la planète à faire cela encore.</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>En fait c’est mon père Pierre-Paul St-Georges qui est entré dans la LBMA au début des années 80 ont y allait en famille et ont arrivaient pour le premier match et ont partaient au dernier match et les vendredis. On se ramassait les Blouin, St-Georges, Schiller etc, bref les familles des joueurs étaient tous là et c’était vraiment familial et des liens se sont formés pendant ces années où ont s’est côtoyé en regardant nos pères jouer à la balle. Moi je suis entré dans la ligue en 1988 avec les Condors ,1989 Les Grands-Ducs, cette année-là a été marquante pour moi j’ai enfin joué pour mon père. Il ne voulait pas que je joue avec lui je ne sais pas pourquoi mais lorsque ma mère m’a annoncé que c’était sa dernière saison, j’ai demandé à mon père de jouer pour lui pour sa dernière saison et ce fut une année mémorable. Moi coté 2 et Yves Cloutier coté 1, ont frappais 1eret 2efrappeur pour les 3 ou 4 premiers matchs et ont avaient une moyenne de 580 les 2 au bâtons. OUI, OUI mais après on a retrouvé notre normale. Mon père a su profiter de cela, ont avait Pierre Paré, tout un lanceur, les Bélanger, Daigle etc vous irez voir cette année-là, si je ne me trompe pas on a gagné nos 9 premiers matchs et les Grands-Ducs ont remporté leur 1erchampionnat de cette équipe en saison. Mais en série nous nous sommes incliné, je crois, dans un match de 22 à 21.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai commencé au baseball mineur avec LSA les Loisirs St-Alphonse en 1975 à l’âge de 7 ans jusqu’en 1979 et en 1980 avec LCR les Loisirs Christ Roi</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>Elle vient de mes parents qui adoraient regarder des matchs de baseball où de softball peu importe où et quand, ils nous emmenaient avec eux, mes sœurs et moi et peu importe le parc dans Montréal, il y avait toujours quelqu’un qui connaissait mon père et se faisait demander de jouer pour eux.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>À mes débuts avec LSA en 1975, les loisirs nous emmenaient tous habillé avec nos uniformes de baseball voir une partie des Expos au parc Jarry ….et oui sa trahi mon âge un peu lol.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>For the love of the game. Avec Kevin Costneril raconte son match parfait et pendant son match parfait revoit le chemin et les moments importants de sa vie privé et professionnel ce que j’adore en apprendre plus que ce que l’on voit sur le losange.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>Yippee-ki-yay, pauvre con ! Piège de Cristal</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Les beignes de la boulangerie La Mie à Lavaltrie</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non plus maintenant</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Non pas du tout</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Non …mais je n’aime pas perdre, je perds toujours avec respect pour les autres</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Ho que oui Football, Touch Football, plus maintenant Golf, Quilles, Badminton</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Les films</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Tim Raines</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Je crois que je n’ai aucun exploit sur le terrain mais ce donc je suis le plus fier, c’est mon esprit d’équipe et les encouragements que je donne à tous mes coéquipiers qui ont joué avec moi, ça c’est moi.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Dans le losange … 1erbut 3e but….et j’aimerais bien devenir lanceur😉</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Joueur d’équipe qui donne tout ce qu’il a dans le corps à chaque rencontre et lorsque je fais une erreur, j’ai hâte d’y retourner pour me reprendre.</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>OUI il y plein de signes qui pointes vers cela.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?PEPSI</p>
<p>Crémeuse ou Traditionnel ?Crémeuse</p>
<p>Sucré ou Salé ?Sucré</p>
<p>Café ou Thé ?Café</p>
<p>Yankees ou Red Sox ?Yankees</p>
<p>Bière ou vin ?😲Bière🍺🍺🍺🍻</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?SANS</p>
<p>Canadiens ou Nordiques ?Canadiens</p>
<p>Sage ou tannant?Tannant</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?Les deux</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Rempli mais pas à sa pleine capacité.</p>
<p>Finale de la coupe Stanley ou Série Mondial ?Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Journée ensoleillé, p’tit déjeuner une partie de balle, une ou 2 ptite bière🍻🍺et des amis et familles à la maison devant un p’tit feu à l’extérieur.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p>Bon, je ne connais pas toutes les catégories j’y vais comme ça… Meilleur lanceur Stéphane Beaudoin ex aequo avec Stéphane Proulx, meilleur joueur de la ligue Éric Collard, toujours souriant et un bon gars, recrue Bein….J-C Dionne, meilleur coach, sans équivoque Keith Beauregard, quel homme un coach-players qui te fait sentir bien et a toujours un bon mot sur et hors du terrain</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? J-C Dionne</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Bien sûr, j’ai réussi à emmener Éric Lafrenière cette saison et mon fils devrait joindre la LBMA l’an prochain</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>Non mais j’ai joué blessé le 3 quart de la saison, blessure à l’aine et claquage de la cuisse</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Il y a toujours des gens qui seront là pour faire de leur mieux, pour garder et protéger les valeurs de la ligue. Cette ligue est Spéciale, c’est familiale, l’esprit doit rester comme ça, il faut que le flambeau qui sera passé s’assure de rester avec ses valeurs avec les prochains, il nous faut des gens qui s’impliquent et donnent de leur temps.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Mon gant</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>Mon coup de bâton</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>J’arrive avant tout l’monde et je jase avec les gens qui arrive, puis je fait des blagues, j’installe ma « LOGE » ma chaise derrière le marbre, puis j’embarque sur le terrain, me lance avec mes coéquipiers, je m’étire ..pas longtemps, puis je regarde le Line Up, je le mets à l’envers et je suis 1 et frappeur.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? 2021, j’ai été très souvent receveur, j’aimerais être LANCEUR</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Pour mon esprit d’équipe et mon désir de m’améliorer à chaque match</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Monter ma moyenne au bâton à 375 l’an prochain et devenir lanceur</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Glisser au 2e et devoir me relever pour ramper jusqu’au 2e but pour être safe à cause d’un mauvais relais.</p>
<p class="question">32.Uncompte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Ali Sabrah</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Du genre low profile mais qui est dans la game tout l’temps et qui encourage et n’abandonne jamais</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Je vais frapper quelque balle.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? Ha Ha Ha tout dépends de tes goûts, moi non.</p>
<p>Si je comprends bien, Sylvain a fait quelques aller-retour dans la Ligue;</p>
<p>7 saisons 1988-89,1993-94,1997, 2020-21.</p>
<p>127 parties jouées, 353 apparitions au bâton. 99 coups sûrs pour une moyenne à vie de 0.280.</p>
<p>Une personne fort sympathique qui t’accueil au parc avec sa bonne humeur contagieuse. J’espère que tu auras ta chance au monticule mon ami.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('vincent-roberge', 'Vincent Roberge', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous présente M. Vincent Roberge ;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?Depuis 2020. C’est Mike ‘’the river’’ qui m’a fait connaître notre belle ligue. Mike travaillait avec ma conjointe et ils s’agaçaient toujours à propos des Red Sox et des Yankees. Un Jour, Mike lui a dit ; tu viendras me voir jouer a balle. Et c’est par un beau soir, en 2019, que j’ai eu mon premier contact avec cette belle gang de la LBMA.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?Première fois à l’âge de 4 ans, dans une ligue de t-ball, jusqu’à mes 12 ou 13 ans. Dans ce temps-là, (oui, je suis assez vieux pour dire ça) a chaque année, la ligue faisait un ‘’club d’étoiles’’ et nous allions faire des tournois, dans d’autres villes, Valleyfield, Gatineau, Cowansville, etc.Nous étions, Les Seigneurs de Boucherville, de redoutable adversaire a la fin 70 et début 80. Par après, une partie par-ci par-là avec des chums, mais rien de sérieux jusqu’à la LBMA.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ? Difficile à dire. Dehors, avec des amis. C’est compétitif et plein de gros fun en même temps.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ? 4 ans sur le terrain avec tous les parents qui encourageaient de chaque côté. Ont avais l’impression d’être de grandes vedettes.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ? 42, pour ce qu’il représente et pour Montréal aussi.</p>
<p class="question">6.Quelle est ta citation de film préférée ?But you are not a Jedi yet.</p>
<p class="question">7.Quel est ton péché mignon ? La pizza, sans équivoque. (Et sans ananas…)</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ? Non, je vais laisser ça a d’autres et me contenter de tout donner sur le terrain.</p>
<p class="question">9.Es-tu superstitieux ? Pas vraiment. En autant que je n’arrive pas à la dernière minute… (au moins une heure d’avance comme le dit si bien ma cheerleader !!!)</p>
<p class="question">10.Es-tu mauvais perdant ? Nope</p>
<p class="question">11.Pratiques-tu d’autres sports ? A part aller au gym, non.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ? Lire, New-York city, écouter films et séries et faire de la bouffe.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondue ? Gary Carter. J’ai eu la chance de le rencontrer sur le terrain du stade olympique quand j’avais 7 ou 8 ans. Il a pris le temps de s’arrêter, de mettre un genou par terre, de nous donner la main comme des hommes et de nous parler quelques instants à mon ami, mon frère et moi. Tout un gentleman.Rien compris de ce qu’il disait, je ne parlais pas en anglais dans ce temps-là, mais ça été un beau moment magique.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ? J’en ai deux qui me viennent en tête. A ma dernière partie au niveau bantam, j’étais au premier but, pour le dernier retrait j’ai dû m’étirer pour attraper le relais qui arrivais du troisième but et j’ai, pour la première et dernière fois de ma vie, fait une split au complet. Les gars sautaient de joie car nous avions remporté la série, mais moi, j’étais couché par terre ; j’avais les ’ cloches’ qui sonnaient… et le 2e, c’est mes deux championnats avec les Condors ;)</p>
<p class="question">15.Quelle est ta position préférée … au baseball ? Une chance que tu as spécifié…. Premier but !</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ? Enthousiasme et déterminé. Je vais tout donner, mais c’est le bien de l’équipe avant tout !</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? J’espère encore.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Coke</p>
<p>Crémeuse ou Traditionnelle ?Crémeuse</p>
<p>Sucré ou Salé?Ça, les deux !!</p>
<p>Café ou Thé?Café</p>
<p>Yankees ou Red Sox?New-York</p>
<p>Bière ou vin ?Bière</p>
<p>Étéou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?SANS ananas. (je me demande si tu lis nos réponses😉</p>
<p>Canadiens ou Nordiques ?Canadien</p>
<p>Sage ou tannant ?Plutôt sage, mais des fois… !!!</p>
<p>Chien ou chat ?Chat</p>
<p>Viande ou végé?Viande</p>
<p>En bas de laine ou en bas de zéro ?En bas blancs, tu devrais le savoir !</p>
<p class="question">Ton verre est à moitié plein ou à moitiévide ?</p>
<p>Plein. J’apprécie ce que j’ai, au lieu de me plaindre sur ce que je n’ai pas.</p>
<p>Finale de la coupe Stanley ou Série Mondiale?Série mondiale.</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ? Un road trip a New-York, me perdre dans Central Park avec ma blonde, une game des Yankees avec quelques bières !</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ? Je n’ose pas m’aventuré à faire des prédictions !!!</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? J’ai déjà joué avec tout le monde de la ligue… que ça soit dans mon équipe ou l’équipe adverse. Pis j’ai eu du fun avec tout le monde.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui, sans hésiter.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Une fracture de la clavicule à mon tout premier match, a la toute première manche, dans la LBMA en 2020 (déjà que la saison était écourtée…) mais j’ai pu prendre part a une douzaine de partie quand même, incluant les séries.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA ? Avec brio.</p>
<p class="question">25.Quel est ton point fort à la balle ? Mon gant.</p>
<p class="question">26.Quel est ta faiblesse ? Je ne te le dirais pas ;)</p>
<p class="question">27.Comment te prépares-tu avant un match ? Étirements surtout et je fais quelques lancers (quelques fois avec ma blonde).</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Premier but et champ gauche, n’importe où, sauf lanceurs et receveurs.</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Ha !! Entendu dire que tu ne voulais pas être coach... bon, pour que tu me repêches je te dirais ; je suis un gars d’équipe. Je me donne a 100%. Je suis là pour avoir du fun, j’encourage tout le temps mes coéquipiers et je vais toujours suivre tes instructions (sur le terrain…)</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? Juste avoir du fun a jouer a balle, pas plus compliqué.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu aie eu sur un terrain de balle ? Une fracture de la clavicule. (je pensais t’en avoir déjà parlé de ça…</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA. Le prochain gars sur le line-up. N’importe qui peut te faire remporter un match d’un seul élan.</p>
<p class="question">33.Quel genre de coéquipier tu es ? Celui qui n’arrêteras jamais de t’encourager, même si tu es rendu a 0 en 12 et que tu as fait 2 erreurs la dernière manche !</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? Je vais frapper des balles le plus souvent possible. Question de garder la forme.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? je crois qu’il est important que la période de reproduction de la mouche tsé-tsé influence les marées du littorale du Wyoming durant la saison de l’amour est dans le prés pour avoir…. Du ketchup sur mes hot-dogs.</p>
<p>Vu la réponse évoquée à la question 35, on pourrait bien s’entendre !!</p>
<p>Vincent a 2 saisons de joué, 25 parties joués, 0.258 de moyenne à vie</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('vincent-robidas', 'Vincent Robidas', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire Vincent Robidas</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>Je suis arrivé dans la LBMA en 2017 et c’est Alex Beaudry qui m’a entraîné avec cette belle bande d’amateurs de balle.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Parcours typique d’un jeune des années 80. L’été, on avait choix entre le baseball et le baseball! J’ai joué jusqu’à l’âge de 15 ans. J’ai fait quelques étés de balle lente avant de me joindre à la LBMA.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>C’est l’un des sports les plus difficiles à maîtriser. Tu dois peaufiner ta dextérité au bâton et en défensive…sans oublier l’apprentissage des règles et de toutes ces subtilités! Même aujourd’hui, je considère que j’en apprends encore!</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Je ne sais pas si c’est mon premier souvenir, mais ce sont les séances de pratique avec mon père au terrain. On avait la chance d’habiter à quelques minutes d’un terrain.</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>Plus jeune, c’était Major League. Film classique de négligés qui deviennent champions! Je connaissais toutes les répliques par cœur!</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>« Je vais te faire une offre que tu ne pourras pas refuser » – La Parrain</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>Le foie gras.</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>J’ai un énorme respect pour ceux qui prennent cette responsabilité. Je ne dis pas non, mais je ne suis pas prêt à ce stade-ci pour ce genre de défi.</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Pas du tout. Je n’ai aucune routine précise.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Je n’aime pas perdre, mais je tourne rapidement la page. On gagne et on perd en équipe. Dans la défaite, on félicite l’adversaire et dans la victoire, on doit demeurer humble.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Je fais du vélo à l’occasion et du hockey cosom l’hiver.</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>J’adore voyager. J’essaie d’aller voir un événement sportif dans chacun de mes voyages, ça inclut des matchs de baseball aux États-Unis et du soccer en Écosse, en Angleterre…et même en Arabie Saoudite.</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>J’adore l’histoire du baseball et Napoléon Lajoie, un Franco-Américain a dominé ce sport à la fin du 19eet début du 20esiècle dans ce qui était appelé la Dead-ball era. Imaginez, il est le joueur en 1901 avec le plus de circuits avec un total de 14!</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Je n’ai pas encore réussi à toucher le Saint-Graal de la LBMA. C’est le seul trophée qui m’intéresse parce qu’il gagne en équipe.</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>J’aime bien être receveur, tant que les genoux seront d’accord. Je suis aussi à l’aise au 3ebut.</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>J’ai un bon QI baseball. Je maîtrise les règlements et j’anticipe bien les jeux en amont. La théorie, ça va ; c’est la pratique qu’il faut maintenant hausser d’un cran!</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Non, je n’y crois pas. Selon Forbes, les Rays valent plus de 900M$US, et on n’a pas encore construit un stade…et s’il faut investir de l’argent public, on n’est pas sorti de l’auberge.</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ? Sprite!</p>
<p>Crémeuse ou Traditionnel ? Traditionnel</p>
<p>Sucré ou Salé ? Sucré</p>
<p>Café ou Thé ? Café</p>
<p>Yankees ou Red Sox ? Toujours le négligé</p>
<p>Bière ou vin ? Vin</p>
<p>Été ou Hiver ? Été</p>
<p>Pizza avec ou sans ananas ? Au risque de déplaire des convaincus, je ne déteste pas la pizza hawaienne!</p>
<p>Canadiens ou Nordiques ? Canadiens</p>
<p>Sage ou tannant? Sage</p>
<p>Chien ou chat ? Chien</p>
<p>Viande ou végé ? Végé à temps partiel!</p>
<p>En bas de laine ou en bas de zéro ? Bas de laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ? Toujours à moitié plein.</p>
<p>Finale de la coupe Stanley ou Série Mondiale ? Série mondiale</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Un OktoberFest à la maison avec les amis.</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2022 de chaque catégorie et pourquoi ?</p>
<p>Aucune idée! Je veux saluer l’engagement des gars de l’exécutif qui ne comptent pas les heures pour nous offrir une ligue de grande qualité. Ils méritent tous notre reconnaissance et notre gratitude.</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p>Alex Beaudry, on espère toujours depuis 2017.</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ?</p>
<p>Sans hésitation. Une ligue où les joueurs sont sérieux sans se prendre au sérieux. On s’y amuse, on rencontre des gars avec des parcours différents qui ont tous une même passion pour la balle.</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ?</p>
<p>J’ai été épargné jusqu’à maintenant. Je touche du bois.</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Nous comptons sur un exécutif de feu. On doit les soutenir dans la recherche de nouveaux talents.</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Mon esprit d’équipe. Je viens jouer sans condition et selon les besoins du coach.</p>
<p class="question">26.Quel est ta faiblesse ?</p>
<p>La constance au bâton. J’ai tendance à trop me mettre de pression inutilement.</p>
<p class="question">27.Comment te prépares-tu avant un match ?</p>
<p>Rien de compliquer, j’essaie de manger sainement avec d’arriver au terrain.</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?</p>
<p>Je suis receveur et j’aimerais jouer partout, sauf lanceur (ça ne serait pas un atout pour le club!)</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ?</p>
<p>Je suis polyvalent. Dans la logistique savante d’un alignement, je donne des options à mon coach en fonction des outils à sa disposition.</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Je veux avoir du plaisir et si possible, aider mon club à remporter le championnat.</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>J’en ai eu des crampes au cerveau…ça serait trop long à énumérer.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p>Sylvain Longtin, Éric Collard et Jonathan Desrosiers sont les joueurs les plus dangereux au bâton.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p>Je pense que je suis un bon coéquipier, capable de participer au collectif. On fait tous des erreurs sur le terrain et la dernière chose qu’on doit faire, c’est de blâmer un coéquipier ; il faut plutôt l’encourager et lui partager nos connaissances.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Normalement, j’essaie d’y aller quelques fois avant le début de la saison, question de se dégourdir les muscles. Pendant la saison, je retourne en cage lorsque je perds mon mojo.</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?</p>
<p>Oui du ketchup…mais faut pas que la moutarde te monte trop au nez!</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('eric_beliveau', 'Éric Béliveau', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous présente M. Éric Béliveau;</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>10 ans environ, Stéphane Beaudoin, nous sommes collègues de travail</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>Joueur en dent de scie, un 3 qui peut frapper comme un 4 et qui peut avoir l’air d’un 2 de fois…Lol</p>
<p>Instable mettons …je joue pour l'amour de la balle et le sport d’équipe</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’aime le fait d’être au parc avec les gars et j’adore la technique que le jeu peut contenir</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Camping +jeunesse joué au 200, que du fun !</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi ?</p>
<p>The fan le contenu et la réalité que peut vivre le joueur</p>
<p class="question">6.Quelle est ta citation de film préférée ?N/a</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>J’en ai trop je crois pour en choisir un ….l’alcool fort ça compte tu,?, lol</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Nonje ne veuxpas avoir cette responsabilité, je le fait a la semaine longue ..gérer du monde .. Week and off !!!</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Pas vraiment</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Le pire des pires et je le cache très bien</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Deck Hockey et n’importe quoi si j’ai l’occasion</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>Je suis un drummer à la retraite lol...choix de vie ….exp; famille et tout le kit</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Ken griffey jr</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Plusieurs gros catch au champ, Plus gros coup important pour gagner des games</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?</p>
<p>Champs + 3 but</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ? Non</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ?Pepsi</p>
<p>Crémeuse ou Traditionnel ?Cremeuse</p>
<p>Sucré ou Salé ?sale</p>
<p>Café ou Thé ?Cafe</p>
<p>Yankees ou Red Sox ?yankees</p>
<p>Bière ou vin ?Vin</p>
<p>Été ou Hiver ?Été</p>
<p>Pizza avec ou sans ananas ?Sans</p>
<p>Canadiens ou Nordiques ?Sénateur !!!!!!!!!!</p>
<p>Sage ou tannant?Sage</p>
<p>Chien ou chat ?Chien</p>
<p>Viande ou végé ?Viande</p>
<p>En bas de laine ou en bas de zéro ?En bas de Laine</p>
<p>Ton verre est à moitié plein ou à moitié vide ?Plein</p>
<p>Finale de la coupe Stanley ou Série Mondial ?Coupe</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2021 de chaque catégorie et pourquoi ?</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ?</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui!!!!!!!</p>
<p class="question">23.as-tu eu une blessure grave qui t’as empêché de jouer ? Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA?</p>
<p>Fleurissante et du fun pour encore longtemps !!!!</p>
<p class="question">25.Quel est ton point fort à la balle ?</p>
<p>Frappeur versatile dans son champ ET opposer fort surtout !!!</p>
<p class="question">26.Quel est ta faiblesse ?Je cours mal sur les buts…….</p>
<p class="question">27.Comment te prépares-tu avant un match ? Je m’étire correctement</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ?Arrêt court</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Ma belle barbe !</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ?</p>
<p>Non seulement du fun</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ?</p>
<p>Pogner un envie de numéro 2 en pleine game ……</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.</p>
<p class="question">33.Quel genre de coéquipier tu es ?</p>
<p class="question">34.Pendant la saison morte, va-tu frapper des balles l’hiver ou tu oublies complètement ce sport ?</p>
<p>Non je fais le nounours lol</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ?Non lol</p>
<p>Monsieur Béliveau est à sa 12e saison complété à la LBMA. 262 parties jouées, 262 coups sûrs pour une moyenne à vie de 0.347 …. Tu devrais pensé à t’acheter un 6/49 pour le 262 !!!</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('eric-lafreniere', 'Éric Lafrenière', 'actuel', $e$Joueur actuel de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire Éric Lafrenière</p>
<p class="question">1.Depuis quand tu évolues dans la LBMA et qui te la fait découvrir ?</p>
<p>C’est ma 2esaison. C’est Sylvain St-Georges qui m’a fait découvrir cette merveilleuse ligue.</p>
<p class="question">2.Raconte nous ton parcourt de balle au travers des années ?</p>
<p>J’ai joué au baseball jusqu’au niveau Pee-wee comme lanceur. J’ai ensuite joué 5-6 parties de balle-molle de façon amicale avec des amis.</p>
<p class="question">3.Explique-nous ta passion pour ce sport ?</p>
<p>J’adore tout ce qui est sport d’équipe, donc, j’adore la balle-molle.</p>
<p class="question">4.Quel est ton premier souvenir de baseball ?</p>
<p>Aller au stade voir les Expos</p>
<p class="question">5.Quel est ton meilleur film de baseball et pourquoi?</p>
<p>J’ai bien aimé Field of dreams et Moneyball plus dernièrement.</p>
<p class="question">6.Quelle est ta citation de film préférée ?</p>
<p>La guerre, la guerre, c’est pas une raison pour se faire mal!</p>
<p class="question">7.Quel est ton péché mignon ?</p>
<p>La poutine</p>
<p class="question">8.Si tu en avais l’occasion, aimerais-tu être entraineur dans la LBMA un jour ?</p>
<p>Non, j’aime le fait que j’ai juste à me présenter au terrain de balle et jouer sans me casser la tête!!</p>
<p class="question">9.Es-tu superstitieux ?</p>
<p>Un peu, j’ai ma petite routine d’avant match.</p>
<p class="question">10.Es-tu mauvais perdant ?</p>
<p>Pas vraiment.</p>
<p class="question">11.Pratiques-tu d’autres sports ?</p>
<p>Badminton et la randonnée</p>
<p class="question">12.En dehors du sport, as-tu d’autre passion ?</p>
<p>La musique</p>
<p class="question">13.Quel est ton joueur de baseball de la ligue majeure préféré, toute époque confondu ?</p>
<p>Plus jeune, j’aimais beaucoup Nolan Ryan. Après, j’ai adoré regardé Mark McGuire frappé des bombes. Maintenant, c’est Aaron Judge.</p>
<p class="question">14.Quelle est ta plus grande réussite ou ton meilleur exploit en tant que joueur de balle ?</p>
<p>Être receveur et réussir à me relever à chaque lancer !!!</p>
<p class="question">15.Quelle est ta position préférée … au baseball ?1erbut</p>
<p class="question">16.Peux-tu te décrire en tant que joueur de balle ?</p>
<p>Joueur d’équipe qui donne tout ce qu’il a à chaque match</p>
<p class="question">17.Crois-tu au retour du baseball majeur à Montréal ?</p>
<p>Pas vraiment</p>
<p class="question">18.Questions en rafales…</p>
<p>Coke ou Pepsi ? Les deux</p>
<p>Crémeuse ou Traditionnel ? Crémeuse</p>
<p>Sucré ou Salé ? sucré</p>
<p>Café ou Thé ? Café</p>
<p>Yankees ou Red Sox ? Yankees</p>
<p>Bière ou vin ? Vin</p>
<p>Été ou Hiver ? Été</p>
<p>Pizza avec ou sans ananas ? SANS</p>
<p>Canadiens ou Nordiques ? Canadiens</p>
<p>Sage ou tannant? Sage…</p>
<p>Chien ou chat ? Chien</p>
<p>Viande ou végé ? Viande</p>
<p>En bas de laine ou en bas de zéro ? hahaha, j’ai pas de niaiserie à ajouter à ça!</p>
<p>Ton verre est à moitié plein ou à moitié vide ? Laplupart du temps, à moitié plein</p>
<p>Finale de la coupe Stanley ou Série Mondiale ? Coupe Stanley</p>
<p>Un peu de sérieux…</p>
<p class="question">19.Pour toi une journée parfaite c’est quoi ?</p>
<p>Être en congé avec du soleil, de la chaleur et une piscine</p>
<p class="question">20.D’après-toi qui seras les récipiendaires de prix 2022 de chaque catégorie et pourquoi ?</p>
<p>À date, j’ai juste une catégorie en tête : Recrue de l’année : Xavier Larin</p>
<p class="question">21.Avec quel joueur de la ligue aimerais-tu jouer mais que tu n’as pas encore eu la chance de le faire ? J’aimerais bien montrer à Eric Collard comment attraper des roulants à l’arrêt-court</p>
<p class="question">22.Recommanderais-tu la LBMA à tes chums joueurs de balle ? Oui monsieur</p>
<p class="question">23.As-tu eu une blessure grave qui t’as empêché de jouer ? Non</p>
<p class="question">24.Comment tu perçois l’avenir de la LBMA? J’espère une belle continuité</p>
<p class="question">25.Quel est ton point fort à la balle ? Joueur d’équipe</p>
<p class="question">26.Quel est ta faiblesse ? L’endurance physique</p>
<p class="question">27.Comment te prépares-tu avant un match ? petite routine de réchauffement</p>
<p class="question">28.Quelle position joues-tu régulièrement et laquelle aimerais-tu essayer ? Je joue CG, receveur cette saison. Je suis prêt à jouer partout!!</p>
<p class="question">29.Je suis un coach, pourquoi devrais-je te repêcher ? Si tu le sais pas, repêche moi pas!!!!</p>
<p class="question">30.As-tu des objectifs personnels dans la LBMA ? M’améliorer à chaque saison</p>
<p class="question">31.Quel est le moment le plus embarrassant que tu ais eu sur un terrain de balle ? J’en ai pas eu à date.</p>
<p class="question">32.Un compte de 3 balles 2 prises, 2 retraits, les buts remplis, ton équipe perd 5-1, qui tu veux voir au bâton ? Ce peut-être un joueur actuel ou du passé de la LBMA.JC Dionne!!! ;)</p>
<p class="question">33.Quel genre de coéquipier tu es ? Un gars d’équipe qui aime quand l’ambiance est bonne.</p>
<p class="question">34.Pendant la saison morte, vas-tu frapper des balles l’hiver ou tu oublies complètement ce sport ? J’oublie complètement</p>
<p class="question">35.En tenant compte de la proximité des buts ainsi que de la forme du losange, crois-tu qu’il est pertinent de nos jours pour la moyenne au bâton et pour les buts volés…de mettre du ketchup dans un hot-dog ? loll</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('andre-dandurand', 'André Dandurand', 'legende', $e$Joueur légendaire de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Pour ceux qui l’ont connu, voici un beau souvenir du grand joueur qu’il est et pour ceux qui ne le connaissent pas, il est une légende qui a définitivement laissé sa marque dans la ligue. Je vous présente André Dandurand;</p>
<p class="question">1.Combien d’année avez-vous joué dans la LBMA et qui vous a fait découvrir la ligue ?</p>
<p>J’ai commencé à jouer à 17 ans en 1990 et arrêté en 2018 après 29 années.Mon père,(un membre du temple) jouait dans cette ligue et tous les vendredis et samedis matins j’allais voir cette ligue qui est devenue une 2efamille.</p>
<p class="question">2.De votre passage à la LBMA, quels sont vos premiers souvenirs ?</p>
<p>La camaraderie, esprit de famille,passion.</p>
<p class="question">3.Pouvez- vous nous expliquer votre passion pour la balle ?</p>
<p>Tout ça a commencé très jeune au chalet.On jouait sur le terrain avec mon père, grand-père, mes oncles. Ensuite embarqué dans des équipes organisées où j’ai joué jusqu’à Bantam pour ensuite retrouver plusieurs de mes chums de baseball et jouer à la balle-molle.</p>
<p class="question">4.Pouvez-vous nous décrire un évènement ou une anecdote spéciale qui s’est passé pendant vos années dans la LBMA ?</p>
<p>Oh boy, en 29 ans, pas mal difficile d’en trouver juste une LOL !! Une qui me vient en tête est pendant le warmup, un certain joueur/lanceur encore actif a décidé de pratiquer son swing en frappant dans le « backstop » et bien les 20 premiers coups qu’il envoyait la balle en l’air pour la swingner et bien il n’a fait que du vent! Stéphane Beaudoin peut vous en parler, il était à côté de moi LOL</p>
<p class="question">5.Avez-vous déjà été coach ?</p>
<p>Oui, pendant 2 ans je crois mais ce n’était pas pour moi ! Moi qui est un gars toujours d’avance, avoir à stressé 2 minutes avant le match parce qu’il te manque un joueur, non merci! Un gros merci à Martin Schiller pour ça !!</p>
<p class="question">6.Étiez-vous superstitieux ?</p>
<p>On dit que les lanceurs sont des spécimens et bien je dois être à part car je n’ai aucune superstition.</p>
<p class="question">7.Étiez-vous mauvais perdant ?</p>
<p>Tout le monde déteste perdre mais je ne suis pas mauvais perdant.Je suis dur avec moi-même mais la défaite est vite oubliée.</p>
<p class="question">8.Aimiez-vous plus le hockey ou la Balle ?</p>
<p>Quand j’étais jeune,je dirais le hockey mais après avoir eu un coach « malade », j’ai arrêté le hockey pour joueur seulement à la balle. Ce que l’influence d’un instructeur peut avoir sur un jeune est immense !</p>
<p class="question">9.Quel est votre premier souvenir de balle ?</p>
<p>Allez au Stade Olympique avec mon père après m’avoir fait arracher 2 dents !! Je me vois encore avec les cotons plein de sang dans la bouche à essayer de manger ma crème glacée dans un petit casque !</p>
<p class="question">10.Quel sont vos exploits accomplis dans la LBMA ?</p>
<p>En 29 ans j’en ai une couple LOL. 1erjoueur à avoir 1000 coups sûrs. 1erlanceur à être barré. Réussi un match sans coups sûrs avec 14 retraits au bâton.</p>
<p class="question">11.Quel est votre joueur de baseball des ligues majeurs préféré, toute époque confondu ? Hum, très difficile.J’ai adoré Gary Carter pour l’ensemble de son œuvre. J’ai aimé Dennis El Presidente Martinez pour son comportement au monticule.J’aimais sa façon de décortiquer un frappeur.</p>
<p class="question">12.À quelles positions vous avez joué dans la LBMA ?</p>
<p>J’ai joué au moins une fois à toutes les positions même si je suis gaucher !</p>
<p class="question">13.À quelle position avez-vous préférée jouer ?</p>
<p>J’hésite entre 1erbut et lanceur mais j’ai un penchant pour lanceur.</p>
<p class="question">14.Pouvez-vous vous d’écrire comme joueur de balle ?</p>
<p>Ouff, toujours le fun de se décrire.Je dirais un joueur avec une bonne tête de balle, polyvalent malgré mon poids lol, bon coéquipier, mettre la balle en jeu un peu partout.</p>
<p class="question">15.Croyez-vous au retour du baseball majeur à Montréal ?</p>
<p>J’aimerais tellement ça mais la garde partagée, c’est non!</p>
<p class="question">16.Quel était votre point fort à la balle ?</p>
<p>Sans prétention,je crois qu’avec 1007 coups sûrs,mon œil au bâton est une de mes forces. En plus de 2100 présences,je me suis fait retirer au bâton seulement 18 fois. Pat Chartrand pourrait vous dire les chiffres exacts !</p>
<p class="question">17.Quel était votre faiblesse ?</p>
<p>Sans équivoque,ma vitesse</p>
<p class="question">18.Si j’avais été coach du temps que vous étiez joueur, pourquoi j’aurais dû vous sélectionner ?</p>
<p>Je pouvais me débrouiller partout sur le terrain et les coachs n’ont pas de « drama » avec moi hahahaha</p>
<p class="question">19.Quel genre de coéquipier étiez-vous ? Je pense avoir été un bon coéquipier.Toujours prêt à encourager.Jamais accepté d’entendre un joueur se plaindre sur un autre joueur suite à erreur de celui-ci.</p>
<p class="question">20.Avez-vous gardé contact avec des anciens coéquipiers de la LBMA ?</p>
<p>Bien sûr,je fais quand même parti des meubles de la LBMA😄</p>
<p class="question">21.Pour quelle raison avez-vous quitté la LBMA ?</p>
<p>Je commençais à trouver ça dur les weekends.En étant membre de l’exécutif,les samedis, je partais tard du parc donc les samedis étaient hypothéqués. Mais la plus grande raison est que je me concentre vraiment juste à lancer et malheureusement je ne peux pas dans la LBMA.</p>
<p class="question">22.Qu’est-ce qui vous manque le plus quand vous pensez à la LBMA ?</p>
<p>Les chums,la famille LBMA ! Quand tu as fais parti de cette ligue pendant près de 30 ans, c’est difficile d’oublier le tout.</p>
<p class="question">23.Racontez-nous des évènements de la LBMA auxquels vous avez eu la chance de participer? Les pique-niques,les partys,les tournois de balle-donnée</p>
<p class="question">24.Détenez-vous des honneurs dans la ligue ?</p>
<p>Euhh juste une couple LOL.Le plus grand honneur est de faire parti du Temple de la Renommé avec mon père et ma sœur !❤</p>
<p class="question">25.Venez-vous faire un tour au parc à l’occasion pour voir des matchs ?</p>
<p>Je suis allé une fois dans les séries cette année.Malheureusement je n’ai pas eu la chance de te rencontrer mais au printemps prochain,je vais y aller et faire connaissance avec toi JC et les autres nouveaux.</p>
<p>Lâche pas JC, tu apportes du sang neuf dans cette belle ligue et j’espère qu’elle va te donner autant de souvenirs qu’elle m’en a apporté !</p>
<p>Petit mot de Pat Chartrand car je ne vous connaissais pas …</p>
<p>André Dandurand, Un des plus grands joueurs de l'histoire de la LBMA. Il est un ex-membre de l'exécutif de la ligue. Un ancien coach. Le fils de Gilles. Frère de Nathalie (ex-marqueuse dans la ligue). Il a disputé 29 saisons dans la ligue, soit de 1990 à 2018. 678 parties jouées (2e all time). 2165 apparitions au bâton (2e all time). 1007 coups sûrs (2e all time). 750 simples (2e all time). 538 points comptés, 734 points produits (1er all time) et 0,465 moyenne à vie.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jean-lachapelle', 'Jean Lachapelle', 'legende', $e$Joueur légendaire de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire pour un ancien; Jean Lachapellealias MEEEEEEEETING</p>
<p>J’ai eu l’idée de faire des entrevues avec les joueurs de la ligue afin de mieux les connaitre. J’ai par le fait même eu l’idée de vouloir connaitre également les anciens. Vos noms m’ont été suggérés car on soupçonne que vous allez vous prêtez au jeu. Soyez généreux dans vos réponses, il fera plaisir à tous de revivre ou de découvrir vos souvenirs.</p>
<p class="question">1. Combien d’année avez-vous joué dans la LBMA et qui vous a fait découvrir la ligue ?31ans</p>
<p class="question">2. De votre passage à la LBMA, quels sont vos premiers souvenirs ?Ambiance de famille, d`amis</p>
<p class="question">3. Pouvez- vous nous expliquer votre passion pour la balle ?Le plaisir, l’équipe.</p>
<p class="question">4. Pouvez-vous nous décrire un évènement ou une anecdote spéciale qui s’est passé pendant vos années dans la LBMA ? Tous les partys,j’en ai organisé plus de 25, les sorties en groupe, les pique-niques et malheureusement arriver au terrain et apprendre le décès d’un joueur.</p>
<p class="question">5. Avez-vous déjà été coach ?Oui</p>
<p class="question">6. Étiez-vous superstitieux ?Pas plus qu’un autre</p>
<p class="question">7. Étiez-vous mauvais perdant ? Non</p>
<p class="question">8. Aimiez-vous plus le hockey ou la Balle ? Balle</p>
<p class="question">9. Quel est votre premier souvenir de balle ?L’accueil</p>
<p class="question">10. Quel sont vos exploits accomplis dans la LBMA ? Plusieurs si on regarde les stat. À vie, à beaucoup de choses, top 10 et meneur des sacrifices</p>
<p class="question">11. Quel est votre joueur de baseball des ligues majeurs préféré, toute époque confondu ?Woody Friman</p>
<p class="question">12. À quelles positions vous avez joué dans la LBMA ?À toutes les positions, une année, j’ai joué aux 9 positions.</p>
<p class="question">13. À quelle position avez-vous préférée jouer ?Receveur</p>
<p class="question">14. Pouvez-vous vous d’écrire comme joueur de balle ?Joueur d’équipe, encourager les autres</p>
<p class="question">15. Croyez-vous au retour du baseball majeur à Montréal ? J’espère</p>
<p class="question">16. Quel était votre point fort à la balle ?Anticiper</p>
<p class="question">17. Quel était votre faiblesse ?Veux trop pour moi</p>
<p class="question">18. Si j’avais été coach du temps que vous étiez joueur, pourquoi j’aurais dû vous sélectionner ? Mon esprit d’équipe et joue toute position</p>
<p class="question">19. Quel genre de coéquipier étiez-vous ?Jovial</p>
<p class="question">20. Avez-vous gardé contact avec des anciens coéquipiers de la LBMA ?Oui</p>
<p class="question">21. Pour quelle raison avez-vous quitté la LBMA ?Plus disponible les samedis</p>
<p class="question">22. Qu’est-ce qui vous manque le plus quand vous pensez à la LBMA ?L’esprit de groupe</p>
<p class="question">23. Racontez-nous des évènements de la LBMA auxquels vous avez eu la chance de participer?Organiser le party, être dans le comité pendant plus de 25 ans</p>
<p class="question">24. Détenez-vous des honneurs dans la ligue ?Oui, un trophée à mon nom, meilleur coach</p>
<p class="question">25. Venez-vous faire un tour au parc à l’occasion pour voir des matchs ? Oui</p>
<p>Jean Lachapelle</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('jean-pierre-aube', 'Jean-Pierre Aubé', 'legende', $e$Joueur légendaire de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous présente Jean-Pierre Aubé;</p>
<p class="question">1.Combien d’année avez-vous joué dans la LBMA et qui vous a fait découvrir la ligue ? J'ai jouéde 2008à 2016 inclusivement, ce qui veut dire 9 années. C'est Michel Forbes qui m’a fait découvrir la ligue.</p>
<p class="question">2.De votre passage à la LBMA, quels sont vos premiers souvenirs ? Je me souviens de la camaraderie qui y régnait tout en étant compétitif.</p>
<p class="question">3.Pouvez- vous nous expliquer votre passion pour la balle ? La passion de la balle me vient de mon père, qui lui en est un mordu.</p>
<p class="question">4.Pouvez-vous nous décrire un évènement ou une anecdote spéciale qui s’est passé pendant vos années dans la LBMA ? Pfff, j’en ai toute une; une année que j'étais éliminé, j'assistais àun match et l’un des meilleurs frappeurs de circuits Dave Asselin, à catapulter une offrande sur la clôture ou pas loin de. Ce qu'il faut savoir, c'est que le match avait lieu au parc sur l'Acadie sur un terrain de baseball. J'avais crié àDave que s'il la frappait de l'autre côtéde la clôture, ce que je croyais pratiquementimpossible,que je lui ferais une pipe. CHRIST que j'avais hâte que la balle retombe.</p>
<p class="question">5.Avez-vous déjà été coach ? Non</p>
<p class="question">6.Étiez-vous superstitieux ? J'avais une routine mais je ne crois pas que c’était une superstition.</p>
<p class="question">7.Étiez-vous mauvais perdant ? Tout dépendait de la façon que l'on perdait, mais je n'ai jamais étémauvais perdant</p>
<p class="question">8.Aimiez-vous plus le hockey ou la Balle ? Définitivement la balle.</p>
<p class="question">9.Quel est votre premier souvenir de balle ? Nous avons commencé jeunes à se lancer la balle dans la rue ou dans un parc. Je n'ai pratiquement jamais joué de baseball organisé car l'éténous allions au chalet.</p>
<p class="question">10.Quel sont vos exploits accomplis dans la LBMA ? En 9 années, j’ai une moyenne au bâton de .409.</p>
<p class="question">11.Quel est votre joueur de baseball des ligues majeurs préféré, toute époque confondu ? Tim Raines, malgré que j’ai toujours été un joueur d'intérieur.</p>
<p class="question">12.À quelles positions vous avez joué dans la LBMA ? 1erannée voltigeur, 6 autres receveur et les 2 dernières au 3ebut.</p>
<p class="question">13.À quelle position avez-vous préférée jouer ? Receveur</p>
<p class="question">14.Pouvez-vous vous d’écrire comme joueur de balle ? Intense</p>
<p class="question">15.Croyez-vous au retour du baseball majeur à Montréal ? Non je n'y crois plus</p>
<p class="question">16.Quel était votre point fort à la balle ? Intense et esprit d'équipe</p>
<p class="question">17.Quel était votre faiblesse ? Mon intensité, loll</p>
<p class="question">18.Si j’avais été coach du temps que vous étiez joueur, pourquoi j’aurais dû vous sélectionner ? Pour ce que je suis et ce que j'apportais à l'équipe.</p>
<p class="question">19.Quel genre de coéquipier étiez-vous ? Je crois que j’étais bout en train, tout en voulant la victoire</p>
<p class="question">20.Avez-vous gardé contact avec des anciens coéquipiers de la LBMA ? OUI</p>
<p class="question">21.Pour quelle raison avez-vous quitté la LBMA ? Àcause de mon travail</p>
<p class="question">22.Qu’est-ce qui vous manque le plus quand vous pensez à la LBMA ? La fraternité qui existe vraiment entre les boys</p>
<p class="question">23.Racontez-nous des évènements de la LBMA auxquels vous avez eu la chance de participer? J'ai participé à plusieurs finales. Au moment ou je jouais, il y avait une journée familiale. Que de plaisir nous avons eu.</p>
<p class="question">24.Détenez-vous des honneurs dans la ligue ? Joueur défensif en 2015, alors que c'était ma première saison comme joueur de 3ebut.</p>
<p class="question">25.Venez-vous faire un tour au parc à l’occasion pour voir des matchs ? À l'occasion.</p>
<p>Un petit mot de Patrick Chartrand car je ne vous connaissais pas …</p>
<p>Un sacré bon gars. Coéquipier que tous coachs espèrent avoir dans son équipe. Un excellent receveur en plus d'être un frappeur avec beaucoup de constance. Il a disputé 9 saisons dans la ligue, soit de 2008 à 2016. 189 parties jouées. 239 coups sûrs. 198 points comptés. 0,409 moyenne à vie.</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('michel-bureau', 'Michel Bureau', 'legende', $e$Joueur légendaire de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Papa de Bob Bureau</p>
<p>J’ai eu l’idée de faire des entrevues avec les joueurs de la ligue afin de mieux les connaitre. J’ai par le fait même eu l’idée de vouloir connaitre également les anciens. Vos noms m’ont été suggérés car on soupçonne que vous allez vous prêtez au jeu. Soyez généreux dans vos réponses, il fera plaisir à tous de revivre ou de découvrir vos souvenirs.</p>
<p class="question">1.Combien d’année avez-vous joué dans la LBMA et qui vous a fait découvrir la ligue ?</p>
<p>Je suis un membre fondateur donc j’ai bâti la ligue avec Robert Auclaire, Robert Tourangeau, Jacque Laviolette et d’autre qui on participer pendant les premières années. On était 4 équipes au début et on a commencé en 1976. 31 ans de service comme joueurs et coach</p>
<p class="question">2.De votre passage à la LBMA, quels sont vos premiers souvenirs ?</p>
<p>Camaraderies, l’amitié. On était juste des coachs pee wee, atome, bantam au début. Seulement des coachs pouvaient jouer dans la ligue. On était des coachs LSA. On a eu l’idée de commencer la ligue parce que Robert Collerette était coach à Midget AA. On jouait une partie exhibition à chaque année au baseball contre leurs équipes. À force de se faire battre à toutes les années, on voulait pratiquer, donc on a parti la LBMA</p>
<p class="question">3.Pouvez- vous nous expliquer votre passion pour la balle ?</p>
<p>Toujours aimé le baseball. Le monde qui pouvait pas aller plus haut au baseball à transférer vers la balle molle et j’ai toujours aimé ça</p>
<p class="question">4.Pouvez-vous nous décrire un évènement ou une anecdote spéciale qui s’est passé pendant vos années dans la LBMA ?</p>
<p>Quand Robert Auclaire a quitté la ligue. C’était un moment difficile parce qu’il avait eu un argument entre lui et Robert Tourangeau. Il a quitté le jour même et on la jamais revue au parc. C’était difficile à cause il faisait une grosse partie de la ligue.</p>
<p class="question">5.Avez-vous déjà été coach ?</p>
<p>Oui</p>
<p class="question">6.Étiez-vous superstitieux ?</p>
<p>Non</p>
<p class="question">7.Étiez-vous mauvais perdant ?</p>
<p>Non</p>
<p class="question">8.Aimiez-vous plus le hockey ou la Balle ?</p>
<p>Balle</p>
<p class="question">9.Quel est votre premier souvenir de balle ?</p>
<p>Jouer quand j’étais jeune</p>
<p class="question">10.Quel sont vos exploits accomplis dans la LBMA ?</p>
<p>Gagner 100 parties comme lanceur. 350 à vie comme frappeur.On a établi le Blue print du comité exécutif qui existe aujourd’hui. Aussi que j’ai donné mon amour de la balle à mon fils</p>
<p class="question">11.Quel est votre joueur de baseball des ligues majeurs préféré, toute époque confondu ?</p>
<p>Mickey Mantel</p>
<p class="question">12.À quelles positions vous avez joué dans la LBMA ?</p>
<p>Lanceur</p>
<p class="question">13.À quelle position avez-vous préférée jouer ?</p>
<p>Lanceur</p>
<p class="question">14.Pouvez-vous vous d’écrire comme joueur de balle ?</p>
<p>Je pense j’étais un 3 pour ma carrière. Probablement 4 comme lanceur.</p>
<p class="question">15.Croyez-vous au retour du baseball majeur à Montréal ?</p>
<p>Pas pendant que je suis vivant malheureusement.</p>
<p class="question">16.Quel était votre point fort à la balle ?</p>
<p>J’avais un bon contrôle de mes lancés. Je la plaçais bien.</p>
<p class="question">17.Quel était votre faiblesse ?</p>
<p>J’aime m’obstiner</p>
<p class="question">18.Si j’avais été coach du temps que vous étiez joueur, pourquoi j’aurais dû vous sélectionner ?</p>
<p>Team player, capable de lancer toutes les game, manquait jamais. J’ai manqué une partie dans toutes les années que j’ai joué.</p>
<p class="question">19.Quel genre de coéquipier étiez-vous ?</p>
<p>Team player. Très bon pour encourager, supporter et aider.</p>
<p class="question">20.Avez-vous gardé contact avec des anciens coéquipiers de la LBMA ?</p>
<p>Oui. Pierre Blouin, Doug Wilson, Serge Schiller, Richard Poulin, Paul St-George</p>
<p class="question">21.Pour quelle raison avez-vous quitté la LBMA ?</p>
<p>J’étais trop vieux…lol</p>
<p class="question">22.Qu’est-ce qui vous manque le plus quand vous pensez à la LBMA ?</p>
<p>Les amis</p>
<p class="question">23.Racontez-nous des évènements de la LBMA auxquels vous avez eu la chance de participer?</p>
<p>Tous les anniversaires, pique-nique annuel, championnat, tous les partys fin de saison.</p>
<p class="question">24.Détenez-vous des honneurs dans la ligue ?</p>
<p>Trohee meilleur lanceur à mon nom et membre du Hall Of Fame</p>
<p class="question">25.Venez-vous faire un tour au parc à l’occasion pour voir des matchs ?</p>
<p>Oui pour voir mon fils jouer</p>
<p>Merci de votre participation</p>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('patrick-blouin', 'Patrick Blouin', 'legende', $e$Joueur légendaire de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Questionnaire pour les anciens (Pat Blouin)</p>
<p class="question">1.Combien d’année avez-vous joué dans la LBMA et qui vous a fait découvrir la ligue?</p>
<p>J’ai joué de 1990-1997 et fais un retour de 2003-2016, donc un total de 22 saisons.</p>
<p>Mon père (Pierre) a débuté sa carrière en 1977, donc dès l’âge de 4 ans, Steff et moi le suivions au parc Jarry. J’ai fait mes débuts dans la LBMA à l’âge de 16 ans.</p>
<p class="question">2.De votre passage à la LBMA, quels sont vos premiers souvenirs?</p>
<p>Je me souviens que chaque Vendredi soir, les enfants des joueurs se regroupaient derrière le terrain des grands (Jarry3) et nous passions nos soirées à s’organiser des matchs entre nous afin de préparer la 2egénération de la LBMA. (Tourangeau/Ménard/Dandurand/Bureau/Schiller/Wilson etc).</p>
<p>Je me souviens que je gardais toujours un œil sur le gros terrain tout en m’amusant avec les enfants sur notre terrain improvisé, et quand mon père se présentait au bâton, je m’assurais de crier : « Time Out les gars, c’est mon père au bat !!! »</p>
<p class="question">3.Pouvez-vous nous expliquer votre passion pour la balle?</p>
<p>Je ne pense pas que ça s’explique !!!! Je vois une balle blanche avec des coutures rouge et je deviens fou! J’étais tellement passionné quand j’avais 12-13 ans que quand je regardais les Expos à la télé, je m’assurais « d’écrire » le match au complet et de compiler les stats des joueurs…finalement j’étais peut-être plus un « Loser » qu’un passionné!😉</p>
<p class="question">4.Pouvez-vous nous décrire un évènement ou une anecdote spéciale qui s’est passé pendant vos années dans la LBMA?</p>
<p>Je me souviens d’un certain Vendredi soir dont les parties avaient été cancellées à cause de la forte pluie, et pour moi, il était impensableque nous ne puissions pratiquer notre sport pendant tout un weekend. Je suis donc parti au parc Jarry vers 11 :30pm avec ma pelle, mon râteau…et ma lampe frontale. Le terrain était un lac…il devait y avoir 6 pouces d’eau pratiquement à la grandeur du terrain. Pour vous donner une idée, il y avait 2 canards qui nageaient dans le lac à l’arrêt-court. À chaque fois que je terminais une rigole, les 2 canards s’envolaient et changeait de ‘spot’ sur le terrain. Après quelque d’heures en ma compagnie, les deux canards frustrés ont décidé de quitter les lieux puisqu’il manquait…d’eau.</p>
<p>Bien entendu, nous avions joué les matchs du samedi matin…mais je me souviens de ne pas avoir très bien performé sur le terrain ce matin-là!😉</p>
<p class="question">5.Avez-vous déjà été coach?</p>
<p>Oui, j’ai coaché pendant 16 ans dans la LBMA et notre équipe a remporté 8 fois les ‘Playoffs’.</p>
<p class="question">6.Étiez-vous superstitieux?</p>
<p>Mes chums et ma femme diraient plutôt que j’étais ‘Fucker Mentalement’. Après chaque défaite, je m’assurais de modifier mon trajet pour me rendre au parc.Aussi, quand j’étais jeune et que j’allais voir mon père jouer, j’avais remarqué que tous les GROS frappeurs (bedonnant et qui frappait avec puissance) portait le #44. (Denis Paradis, Robert Auclair, André Lemieux et Michel Plante). Donc, à ma 2eannée dans la ligue j’ai insisté pour avoir le #44 (superstitieux ou Fucké). L’année suivante, Michel Plante m’a demandé si je voulais être son assistant-coach….et le problème était que Michel portait également le #44. J’avais dû négocier avec Michel, mais deviner qui a porté le #44 cette année-là……et au cours des 20 années suivante!😉</p>
<p class="question">7.Étiez-vous mauvais perdant?</p>
<p>Je pense que Non. Je voulais vraiment gagner à chaque match mais quand on perdait, je retrouvais le sourire une fois dans les estrades…mais quelquefois c’était juste plus long de quitter le terrain!</p>
<p class="question">8.Aimez-vous plus le hockey ou la Balle?</p>
<p>Prochaine question svp.</p>
<p class="question">9.Quel est votre premier souvenir de balle?</p>
<p>Je me souviens d’avoir joué mon baseball Atome au parc Henri-Julien (Christ-Roi) en compagnie de légendes de la LBMA tel……André Dandurand, Keith Beauregard, Chris Schiller et Marc Vanier.</p>
<p class="question">10.Quel sont vos exploits accomplis dans la LBMA?</p>
<p>L’exploit qui me rend le plus fière est d’avoir fait partie de l’équipe détenant la meilleure fiche en une saison dans les 46 années d’existence de la ligue. L’édition 1991 des Vautours a terminé la saison avec une fiche de 20 victoires et 5 défaites et un différentiel de +106 !!!Ce fut encore plus spécial de partager cette saison mémorable avec mon père Pierre Blouin (Coach) et mon frère Steff Blouin (assistant-coach). Disons que je n’ai pas eu à changer de chemin trop souvent cet été-là…😉</p>
<p class="question">11.Quel est votre joueur de baseball des ligues majeurs préféré, toute époque confondue?</p>
<p>Désolé j’en ai deux. Dans ma jeunesse c’était Larry Walker. Quel joueur complet.</p>
<p>Depuis les 10 dernières années, je suis le fan #1 de Mike Trout. En plus d’être le joueur le plus complet du baseball, Trout se démarque par sa passion et son respect de la game et par sa façon de se comporter avec ses fans, un vrai exemple pour les jeunes.</p>
<p class="question">12.À quelles positions vous avez joué dans la LBMA?</p>
<p>Lors de mes 20 premières années, j’ai principalement évolué à l’arrêt-court. Malheureusement avec l’âge (et une opération à l’épaule) j’ai dû me rendre à l’évidence que je n’avais plus le bras assez puissant pour rivaliser avec les jeunes lapins de la ligue.☹. J’ai donc décidé de me recycler en lanceur lors de ma 21esaison dans la ligue!😉</p>
<p class="question">13.À quelle position avez-vous préférée jouer?</p>
<p>Mmmm, bonne question. Étant un ancien lanceur au baseball, j’ai adoré renouer avec le monticule en fin de carrière. Y’a pas meilleur feeling que d’être en contrôle d’un match sur la butte. Un peu comme Greg Maddux, j’adorais l’aspect mental d’une confrontation avec le frappeur…je n’avais pas bien le choix car je n’avais pas la vélocité pour striker la plupart des frappeurs.☹</p>
<p class="question">14.Pouvez-vous vous d’écrire comme joueur de balle?</p>
<p>Ouf, je vais essayer.</p>
<p>Année 1990 : Grand – Mince – Rapide</p>
<p>Année 2000 : Grand - Athlétique – Puissance au bâton.</p>
<p>Année 2010 : Grand – Dodu – Rusé …mais début du déclin</p>
<p>Année 2020 : Grand – Chauve – Retraité</p>
<p class="question">15.Croyez-vous au retour du baseball majeur à Montréal?</p>
<p>J’y croyais jusqu’à hier…☹</p>
<p class="question">16.Quel était votre point fort à la balle?</p>
<p>Leadership et/ou compréhension de la game.</p>
<p class="question">17.Quel était votre faiblesse?</p>
<p>Perte de Puissance des relais en fin de carrière et aussi je ne buvais pas de bières après les matchs😉</p>
<p class="question">18.Si j’avais été coach du temps que vous étiez joueur, pour quoi j’aurais dû vous sélectionner?</p>
<p>Pour possiblement jouer plus de matchs en séries…et surtout pour être sûr d’être un membre de la première équipe à sortir pratiquer dehors au mois d’Avril !!!!</p>
<p class="question">19.Quel genre de coéquipier étiez-vous?</p>
<p>Le genre qui trainait toujours une grosse cruche d’eau froide pour ses coéquipiers et le genre qui instaurait des danses en rond après chaque victoire de l’équipe!</p>
<p class="question">20.Avez-vous gardé contact avec des anciens coéquipiers de la LBMA?</p>
<p>Oui, avec plusieurs, dont 3 qui sont devenu parrain de mes fils et un autre qui coach(ait) les jeunes au baseball avec moi. Aussi grâce au site de la LBMA et à Facebook, je continue à suivre vos activités à distance sur une base régulière.</p>
<p class="question">21.Pour quelle raison avez-vous quitté la LBMA?</p>
<p>J’ai décidé de donner aux suivants. J’ai donc décidé de me lancer à temps plein dans le coaching de mes deux fils au baseball mineur (Orioles de Montréal) afin de transmettre ma passion au plus grand nombre de jeunes possible.</p>
<p class="question">22.Qu’est-ce qui vous manque le plus quand vous pensez à la LBMA?</p>
<p>Sans aucun doute la camaraderie au parc avant, pendant et après le match.</p>
<p>Aussi, je m’ennui de la nuit précédant le ‘Draft’, la nuit qui était souvent de courte durée et qui était habituellement ponctué de petit Caca mou…….😉</p>
<p class="question">23.Racontez-nous des évènements de la LBMA auxquels vous avez eu la chance de participer?</p>
<p>J’ai compris en bas âge l’importance de la ‘Famille’ dans les succès de la LBMA. Je me souviens dans les années 1980 du fameux pique-nique annuel. Aussi, il y avait un match Père/Fils (Fille) à chaque année. Ensuite il y a eu les matchs d’étoiles. Par la suite, la 2egénération ont pris charge de ramener ce genre d’activité si important pour la ligue. Il y a eu des Olympiades et ensuite est né le tournoi annuel de balle donnée mixte de la LBMA. Un incontournable. Tant de plaisir en famille et entre amis et autant de plaisir hors du terrain à voir tout le monde participer afin de faire de notre ligue, une ligue si spéciale. (P.S, j’ai encore tous les fichiers si quelqu’un voulait reprendre charge du tournoi!)</p>
<p class="question">24.Détenez-vous des honneurs dans la ligue?</p>
<p>Trophée Individuel = Oui, mais pas important.</p>
<p>Collectif= Oui, membre de l’équipe championne de saison régulière à 8 reprises et 8 fois gagnant des séries.</p>
<p>Le seul petit record personnel qui me tient à cœur est celui du nombre de CC en carrière (110)…comme quoi j’avais bien fait d’insister pour le #44😉</p>
<p class="question">25.Venez-vous faire un tour au parc à l’occasion pour voir des matchs?</p>
<p>Oui, je m’assure de venir faire mon tour au moins une fois par année (en début de saison) pour voir les quelques visages qui me sont familier…mais malheureusement il en reste de moins en moins.</p>
<p>Merci JC d’avoir pensé à moi pour ce questionnaire. J’ai fait beaucoup de recherche sur le site afin de compléter du mieux que je pouvais et ce fut un grand plaisir de me replonger dans tant de souvenirs.</p>
<p>Au plaisir de te croiser au parc Jarry cet été.</p>
<p>Pat Blouin</p>
<p>Petit mot de Patrick Chartrand car je ne vous connaissais pas…</p>
<p>Pat Blouin, Selon moi et plusieurs autres, le joueur le plus talentueux de l'histoire de la LBMA. Aussi, la grande majorité le considère comme le meilleur coach de l'histoire de la LBMA. Fils de Pierre, frère de Stéphane. Il a joué 22 saisons dans la ligue, soit de 1990 à 1997 et de 2003 à 2016. 517 parties jouées. 783 coups sûrs (7e all time). 249 doubles (1er all time). 68 triples (2e all time). 110 circuits (1er all time et 39 de plus que le 2e). 744 points comptés (1er all time). 672 points produits (5e all time) 325 buts sur balles (2e all time, derrière son frère Stéphane). 0,505 moyenne à vie.</p>
<h3>Retour à l'ndex des entrevues</h3>$e$) on conflict (slug) do nothing;

insert into public.medias_entrevues (slug, nom, categorie, sous_titre, contenu) values ('serge-schiller', 'Serge Schiller', 'legende', $e$Joueur légendaire de la LBMA$e$, $e$<h2>Entrevue avec J-C</h2>
<p>Je vous Présente Serge Schiller</p>
<p class="question">1.Combien d’année avez-vous joué dans la LBMA et qui vous a fait découvrir la ligue ?</p>
<p>J`ai eu la chance de jouer 35 ans dans la LBMA.</p>
<p>C`est mon cousin Pierre Schiller qui m'a fait découvrir la ligue de 4 équipes qui était formée majoritairement d`instructeurs de Hockey aux Loisirs St-Alphonse D`Youville qui est devenue AHMV. J`y étais alors responsable des atomes avec Gilles Dandurand, le père de Bam ou Wood ou André. J`ai donc joint la ligue à sa deuxième année d'existence et j`y ai amené mon ami Gilles l`année suivante.</p>
<p class="question">2.De votre passage à la LBMA, quels sont vos premiers souvenirs ?</p>
<p>Mes premiers souvenirs sont ceux d`une belle gang de bénévoles qui pour garder contact durant l'été ont parti une ligue de balle molle amicale. Je salue d`ailleurs les Robert Tourangeau, Michel Bureau, Jean-Claude Ménard, Robert Auclair et j`en oublie qui ont eu cette belle initiative..Je me souviens également que durant le camp d'entraînement, mon cousin Pierre qui m'avait amené dans la ligue s'est fracturé la clavicule mettant ainsi fin à sa carrière…</p>
<p class="question">3.Pouvez- vous nous expliquer votre passion pour la balle ?</p>
<p>Ma passion pour la balle ne s'explique pas. J`ai commencé à jouer à 7 ou 8 ans aux Loisirs de la Plage Roger à Ste-Marthe sur le Lac. J`ai joué à la balle molle jusqu'à l`âge de 12 ans puis à la fastball jusqu'à 19 ans. Par après, j'ai formé une équipe nommée les Sharks dans la vingtaine puis j'ai rejoint la LBMA à 30 ans.</p>
<p>J`ai pratiqué plusieurs sports dans ma vie et je joue encore régulièrement au Golf et au Badminton mais ma passion demeure la balle molle.</p>
<p>Je joue d'ailleurs depuis 2007 dans l'équipe des Baby Boomers de Ahuntsic, seule équipe de Montréal dans une ligue de 12 équipes, représentant la majorité des villes de la Rive Nord. J'en assume d'ailleurs la responsabilité depuis une dizaine d`années.</p>
<p class="question">4.Pouvez-vous nous décrire un évènement ou une anecdote spéciale qui s’est passé pendant vos années dans la LBMA ?</p>
<p>Je pourrais écrire un livre avec les anecdotes ou événements survenus au cours de mes 35 années mais pour m'en tenir à des événements qui me tiennent à cœur, je citerai mes 5 ans de coaching avec mon assistant et grand chum Robert Isabelle. À l`époque, l`assistant suivait son coach au repêchage.</p>
<p>Je chéris aussi et j'en suis très fier, la seule année ou j'ai joué dans la même équipe que mes 2 fils Christian et Martin deux « excellents » joueurs, pas mal meilleurs que le bonhomme.</p>
<p>J'ai également savouré particulièrement avoir fait partie de l`édition 2003 des Éperviers, à mon sens la meilleure équipe ``ever`` de la ligue qui comptait entre autre Mike et Bob Bureau, mon fils Christian, Stéphane Laberge, Alex Vadeboncoeur et Pat Wilson dans ses rangs. Quelle année !</p>
<p>Bien sûr je suis aussi très fier qu`un trophée (recrue de l`année) porte mon nom et je remercie l'exécutif d'alors pour cette belle délicatesse. Ah oui, et que dire des saisons durant lesquelles la ligue comptait 8 équipes ayant chacun un plus qu'excellent premier lanceur et un deuxième lanceur pas piqué des vers non plus. Je me réjouis d`ailleurs d`avoir eu Maurice Richard junior comme lanceur. Quel joueur et quel gentilhomme.</p>
<p class="question">5.Avez-vous déjà été coach ?</p>
<p>J'ai été coach de 1984 à 1987, puis à la demande de la ligue, j'ai accepté de revenir comme coach en 1994 mais seulement pour 1 an car j'étais alors occupé dans différents organismes.</p>
<p class="question">6.Étiez-vous superstitieux ? Non, je n’ai aucune superstition particulière.</p>
<p class="question">7.Étiez-vous mauvais perdant ?</p>
<p>Mauvais perdant dis-tu ? J`ai toujours dit que un bon perdant est un .....perdant.. Oui,je suis un mauvais perdant mais jamais(ou rarement)je refuse de serrer la main des adversaires à la fin d'un match. Ceux qui me connaissent savent que je déversais mon fiel plutôt sur les arbitres.</p>
<p class="question">8.Aimiez-vous plus le hockey ou la Balle ?</p>
<p>La balle ! J'adore le Hockey et je me considère comme un connaisseur, d'ailleurs les gars de mon pool pourront le confirmer, cependant ne sachant pas patiner, je n`ai jamais joué au Hockey en patin. Je me suis vengé au Ballon Balai, ayant joué une année pour la ligue Colombienne.</p>
<p class="question">9.Quel est votre premier souvenir de balle ?</p>
<p>Mon premier souvenir de balle en tant que joueur remonte en 1955 à la Plage Roger tel que mentionné précédemment, cependant, mon tout premier souvenir du Baseball remonte lorsque j'avais 6 ou 7 ans alors que mon père m'amenait au Stade Delorimier voir les Royaux de Montréal et les futures vedettes de Dodgers de Brooklyn puis de Los Angeles.</p>
<p class="question">10.Quel sont vos exploits accomplis dans la LBMA ?</p>
<p>Ce n'est pas moi qui ai accomplis les plus grands exploits dans la ligue, j'ai laissé ça à mes fils mais je puis me vanter d'être parmi les meneurs des stats de la ligue pour les saisons,</p>
<p>les matchs jouées et peut-être les apparitions au bâton.</p>
<p class="question">11.Quel est votre joueur de baseball des ligues majeurs préféré, toute époque confondu ?</p>
<p>Étant donné mon grand âge, j`ai eu l'opportunité de voir évoluer beaucoup de grands joueurs. Pour n'en nommer que quelques-uns, j`ai beaucoup aimé Willie Mays, Hank Aaron et Mike Schmidt entre autres. Plus près de nous, je chéris la majorité des grands joueurs de nos Expos tel que le Kid, André Dawson, le Grand Orange, Pedro Martinez, Vladimir Guerrero etc...</p>
<p>J`aime bien le fils de Vlad également.</p>
<p class="question">12.À quelles positions vous avez joué dans la LBMA ?</p>
<p>Dans la LBMA j`ai joué essentiellement au premier but, position à laquelle j`ai toujours joué étant gaucher. J`ai également lancé quelques parties en tant que deuxième et même</p>
<p>troisième lanceur.</p>
<p class="question">13.À quelle position avez-vous préférée jouer ?</p>
<p>Évidemment au premier but. J'ai même demandé à mes fils qu'à mon décès, sans être une obligation, j`apprécierais qu'ils aillent enterrer une cuillerée de mes cendres sous le premier but au terrain 1 de Jarry.</p>
<p class="question">14.Pouvez-vous vous d’écrire comme joueur de balle ?</p>
<p>Un excellent 3, joueur d`équipe honnête et fiable. Excellent repêcheur, bonne connaissance de la game .....mais un 3 quand même.</p>
<p class="question">15.Croyez-vous au retour du baseball majeur à Montréal ?</p>
<p>J`y croyais jusqu'à récemment mais avec la nouvelle de la semaine dernière, j'avoue que mes espoirs se sont envolés. Très dommage.</p>
<p class="question">16.Quel était votre point fort à la balle ?</p>
<p>Ma défensive. Excellent pour les pickups et pour les balles lancées toutes croches par le relayeur au premier but. Je n`ai jamais eu peur de la balle.</p>
<p class="question">17.Quel était votre faiblesse ?</p>
<p>Au bâton j'étais un frappeur en flèche de balles rapides mais j`ai toujours eu de la difficulté avec les ballounes. De plus, malgré mon gabarit, j`ai toujours frappé avec les bras donc, je frappais rarement la longue balle. Bizarrement, je frappe beaucoup mieux avec les Old Timers même si la balle monte 12 pieds de haut avant de nous arriver</p>
<p class="question">18.Si j’avais été coach du temps que vous étiez joueur, pourquoi j’aurais dû vous sélectionner ?</p>
<p>Comme je le mentionnais, je suis un joueur fiable toujours à l'heure qui manque rarement un match. Je suis également très fiable au premier but et peut dépanner au monticule.</p>
<p>De plus, en tant qu`ancien coach avec une fiche gagnante, je suis de bon conseil.</p>
<p class="question">19.Quel genre de coéquipier étiez-vous ?</p>
<p>J`étais un gars d'équipe avec beaucoup d'humour. Les quelques fois où j'ai pu avoir l`air bête, je n'en voulais qu'à moi-même (tout perfectionniste que je suis) d'avoir raté un jeu ou ma présence au bâton dans un match serré.</p>
<p class="question">20.Avez-vous gardé contact avec des anciens coéquipiers de la LBMA ?</p>
<p>Absolument. J`ai plusieurs amis Facebook et je parle régulièrement avec Mike Plante. De plus des anciens et même des joueurs actuels de le LBMA font partie de mon équipe de Baby Boomers. J`ai nommé Gino Ciarlo, Richard Marchi, Allan Beacon, Alain Boileau et Marcel Morin. De plus, Mike Plante, Michel Forbes, André Desjardins, J.C. Ménard, Robert Isabelle et les frères Doug et Bob Wilson ont déjà fait partie de l'équipe depuis que j'y joue.</p>
<p>D`ailleurs j`invite les joueurs de 55 ans et plus qui sont disponible le mardi matin à me contacter si intéressés à joindre une bonne équipe de gars sympathiques en plus. Nous sommes présentement complets mais à notre âge un poste peut se libérer rapidement.</p>
<p class="question">21.Pour quelle raison avez-vous quitté la LBMA ?</p>
<p>Une année en particulier, plusieurs réguliers dont mes deux fils ont quittés la ligue pour différentes raisons. L`année suivante, je ne m`amusais plus autant et en plus je jouais avec les Baby Boomers (on joue une saison de 22 matches en plus des pratiques et des matches hors-concours) Par ailleurs, je suis heureux que la ligue m`ait survécu....ah..ah, car la LBMA a toujours formée une belle famille et je l'ai toujours à cœur en espérant être invité pour ses 50 ans.</p>
<p class="question">22.Qu’est-ce qui vous manque le plus quand vous pensez à la LBMA ?</p>
<p>Ce qui me manque le plus c`est la GANG. Je m`ennuie des Plante, Charbonneau, Chartrand, Blouin, Wood, Tourangeau, Lariviere, Poulin etc..etc..etc..Je m`ennuie de la famille quoi !</p>
<p class="question">23.Racontez-nous des évènements de la LBMA auxquels vous avez eu la chance de participer?</p>
<p>Les ÉVÊNEMENTS marquants sont les journées familiales (piques-niques au Camping Laliberté, Tournois de balle donnée familiale) les games contre les prisonniers de Bordeaux.</p>
<p>Certains party de fin de saison demeurent mémorables à mes yeux. Et que dire des repêchages dont un certain a nécessité un échange non prévu. (Salut Pat chartrand)</p>
<p class="question">24.Détenez-vous des honneurs dans la ligue ?</p>
<p>J’ai beaucoup de plaques et/ou trophées pour l'équipe championne de la saison ou des séries mais ma plus grande fierté c'est d'avoir un trophée qui porte mon nom.</p>
<p>Coté individuel j`ai des plaques pour mes 20-25-30 -35 ans. J`ai aussi quelques plaques de joueur le plus ....valeureux.</p>
<p class="question">25.Venez-vous faire un tour au parc à l’occasion pour voir des matchs ?</p>
<p>Oui, une ou deux fois par saison sauf l'an passé mais chaque fois, je suis nostalgique.</p>
<p>Merci d'avoir pensé à moi pour tes magnifiques interviews,</p>
<p>Au plaisir</p>
<p>Serge</p>
<p>Petit mot de Pat Chartrand car je ne vous connaissais pas …</p>
<p>Serge Schiller; Une légende vivante de la LBMA. Il a définitivement contribué à bâtir les fondations de la ligue. Ses frères, Pierre et Ronald ont joués dans la ligue. Ses deux fils Christian et Martin ont marqué la ligue eux aussi. Il est celui qui a disputé le plus grand nombre de saison dans la ligue, soit 37. Il a joué dans la ligue de 1977 à 2013. 2353 apparitions au bâton (1er all time). 716 coups sûrs. 0,304 moyenne à vie.</p>$e$) on conflict (slug) do nothing;


commit;
