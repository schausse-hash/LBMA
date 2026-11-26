# LBMA — première base Android et iPhone

Projet mobile isolé, basé sur la refonte `ui-test-a-appli`. Aucun fichier du site existant n’est modifié. Identifiant proposé : `org.liguelbma.app` (à confirmer avant publication).

## Préparer

Node.js 22 ou plus récent. Depuis le dossier `mobile` :

```sh
npm ci
npm run build
npx cap add android
npx cap add ios
npm run sync
```

Les projets natifs sont générés localement et ignorés par Git pour cette première base. Ne lancer `cap add` qu’une fois pour chaque plateforme. Ensuite, utiliser `npm run sync` après chaque changement du site. Ne pas configurer Vercel pour construire ce sous-projet : le site conserve son déploiement actuel.

## Tester

Android : Android Studio avec le SDK demandé par la version installée de Capacitor, puis `npm run android`. Démarrer sur un téléphone USB ou un émulateur.

iPhone : un Mac avec Xcode compatible est nécessaire, puis `npm run ios`. Configurer l’équipe Apple et la signature avant le test sur appareil.

Le build copie 32 pages publiques et leurs ressources dans `www`, puis ajoute le pont natif. Les données Supabase et certaines ressources distantes nécessitent Internet. Les fonctions serveur Vercel ne sont pas embarquées. Les liens vers les pages hors du périmètre public ouvrent le site de production dans le navigateur intégré; ne pas confondre ce site avec la préversion mobile.

Fonctions préparées : navigation existante, viewport pour les bordures de l’écran, liens externes dans le navigateur natif et bouton Retour Android (fermeture du menu, retour, accueil puis réduction). Le service worker du site est désactivé dans les copies natives pour éviter les conflits de cache. Les fichiers sources du site restent intacts.

## Avant publication

- Tester accueil, calendrier, classement, fiches et statistiques sur Android et iPhone, en portrait/paysage et avec une connexion perdue.
- Vérifier la navigation Retour, les liens vers Maps, les PDF et les formulaires de contact.
- Vérifier les cartes Google et les restrictions de clé pour l’origine de l’application.
- Finaliser les icônes et écrans de lancement natifs : les projets générés ont encore les ressources Capacitor par défaut.
- Confirmer l’identifiant, les comptes développeur et les signatures; conserver les clés Android hors du dépôt.
- Vérifier la politique de confidentialité, les données publiées et les déclarations des boutiques selon les données réellement collectées.
- Préparer les captures, descriptions et tests requis par les boutiques.
- Enrichir et valider l’expérience mobile avant soumission; cette base ne garantit pas l’acceptation par Apple.

Notifications, équipe favorite, rappels et publication ne sont pas inclus dans cette première base. Aucun APK/AAB/IPA signé n’a été produit. La génération des projets et le build web peuvent être vérifiés sans prétendre remplacer les tests natifs sur appareils.
