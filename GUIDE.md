# SmartWorld : guide de mise en ligne

Comptez environ 30 minutes la première fois. Ensuite, vous gérez vos produits depuis votre téléphone.

## Contenu du dossier

| Fichier | Rôle |
|---|---|
| `index.html` | Le site que voient vos clients : catalogue, choix des produits, envoi WhatsApp |
| `admin.html` | Votre espace pour ajouter, modifier, masquer ou supprimer des produits |
| `config.js` | **Le seul fichier à modifier** : clés Supabase et numéro WhatsApp |
| `functions/p/[slug].js` | Fait apparaître la **photo du produit** dans le message WhatsApp |
| `supabase.sql` | Crée la table des produits et le dossier des photos |
| `logo.png`, `icon.png` | Votre logo |

---

## Étape 1 : Supabase (base de produits + photos)

1. Allez sur supabase.com, puis **New project** (un nouveau projet, séparé de votre POS, est conseillé). Notez le mot de passe de la base.
2. Ouvrez **SQL Editor**, puis **New query**. Collez le contenu de `supabase.sql`.
   ⚠️ Remplacez d'abord `VOTRE_EMAIL_ADMIN@exemple.com` (4 fois) par **votre e-mail admin**. Cliquez ensuite sur **Run**.
3. Allez dans **Authentication**, puis **Users**, puis **Add user**, puis **Create new user**. Mettez le **même e-mail** et un mot de passe solide, et cochez **Auto Confirm User**.
4. Allez dans **Authentication**, puis **Sign In / Providers**, et **désactivez** « Allow new users to sign up » (personne d'autre ne pourra créer de compte).
5. Récupérez vos clés dans **Project Settings**, puis **API Keys** / **Data API** :
   - **Project URL**, au format `https://xxxx.supabase.co`
   - la clé **anon** ou **publishable**. Celle-là est publique, c'est normal.
   - ⛔ Ne mettez **jamais** la clé `service_role` / `secret` dans le site.
6. Ouvrez `config.js` et collez l'URL et la clé à la place de `VOTRE-PROJET...` et `VOTRE_CLE...`.

## Étape 2 : GitHub

1. Créez un nouveau dépôt, par exemple `smartworld-site`.
2. Cliquez sur **Add file**, puis **Upload files**, et glissez **tout le contenu** du dossier, y compris le dossier `functions`.
3. Vérifiez que le fichier `functions/p/[slug].js` apparaît bien dans le dépôt.

## Étape 3 : Cloudflare Pages (mise en ligne gratuite)

1. Allez dans **Workers & Pages**, puis **Create**, puis l'onglet **Pages**, puis **Import an existing Git repository**.
2. Choisissez le dépôt `smartworld-site`.
3. Réglages : Framework **None**, Build command **vide**, Output directory **vide**.
4. Cliquez sur **Deploy**. Votre site sera en ligne sur `https://smartworld-site.pages.dev`, ou sur votre nom de domaine si vous en ajoutez un plus tard.

## Étape 4 : Ajouter vos produits

1. Ouvrez `https://VOTRE-SITE.pages.dev/admin.html` sur votre téléphone. Ajoutez-la à vos favoris.
2. Connectez-vous avec l'e-mail et le mot de passe de l'étape 1.3.
3. Cliquez sur **+ Ajouter un produit**, puis remplissez : photo, nom, prix, état et caractéristiques (une par ligne).
4. **Masquer** retire un produit du site sans le supprimer (par exemple quand il est en rupture). Les flèches ↑ ↓ changent l'ordre d'affichage.

## Étape 5 : Tester

- Ouvrez le site, choisissez un produit, puis touchez **Commander** et **Envoyer sur WhatsApp**.
- Envoyez-vous le message à vous-même : l'aperçu avec la photo apparaît sous le lien du produit.
- Si l'aperçu ne s'affiche pas tout de suite, WhatsApp a peut-être gardé l'ancien en mémoire. Réessayez avec un autre produit.

## Liens à utiliser dans vos pubs Facebook

- **Tout le catalogue** : `https://VOTRE-SITE.pages.dev`
- **Un produit précis (déjà sélectionné à l'arrivée)** : `https://VOTRE-SITE.pages.dev/?p=SLUG`
  Pour trouver le SLUG, ouvrez la page produit : c'est la fin du lien `/p/...` dans le message WhatsApp, par exemple `hp-elitebook-840-g6-ab12`.

## Plus tard : version application

Le site est prêt à devenir une **application installable** (PWA). Il suffira d'ajouter 2 petits fichiers, sans changer le lien.
