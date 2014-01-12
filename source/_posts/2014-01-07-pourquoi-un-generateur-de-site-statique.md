---
title: Créer un blog avec Sculpin
description: Tutoriel pour apprendre à créer un blog rapidement avec le générateur de site statique Sculpin
draft: true
categories:
    - sculpin
---

<a id="sommaire"></a>

1. [Pourquoi un générateur de site statique ?](#chap1)
2. [Présentation du projet](#chap2)
3. [nstallation de sculpin](#chap3)
4. [Les premières pages – pour l'exemple](#chap4)
5. [Le template](#chap5)
6. [Les articles](#chap6)
1. [Explication du format md](#chap7)
7. [La pagination](#chap8)
8. [Les catégories et les tags](#chap9)
9. [Les fichiers de configuration](#chap10)
10. [La page d'erreur, le sitemap.xml et le .htaccess](#chap11)
11. [Mise en production](#chap12)


1. Pourquoi un générateur de site statique ?<a id="chap1"></a> [<i class="icon icon-chevron-up"></i>](#sommaire "Retourner au sommaire")
--------------------------------------------

Quand j'ai voulu créer ce blog je me suis posé la question de ce que j'allais utiliser comme techno. Les deux possibilités que j'avais en tête était d'utiliser un framework PHP(Silex ou Symfony) ou un CMS (Wordpress).
J'ai vite éliminé Wordpress parce que je ne connais pas trop son fonctionnement. Et puis mettre en ligne un CMS c'est pas super FUN !
J'ai gardé l'idée Symfony avec 2-3 bundles bien choisi la mise en place n'aurait pas été trop longue.
Mais au moment de faire le point sur ce que j'avais réellement besoin, j'ai trouvé Symfony bien trop lourd. Je n'aurai jamais utilisé le backend pour saisir les articles. 

Du coup j'ai été voir les générateurs de sites statiques. Je ne connaissais aucun outil. Et pourtant il en existe beaucoup. J'ai essayé Jekill (TECHNO), JERPHP (en PHP) et Sculpin. Tous ses outils sont vraiment sympas mais il fallait bien en choisir un. Mon cœur a penché pour Sculpin.

Et j'ai eu raison, en partant avec aucune connaissance sur l'outil j'ai créé un blog en moins d'une journée. Cool !

De plus il n'y a que des avantages:

+ Commun à tous ses outils
    + Pas de BDD à gérer
    + sécurité maximale, il n'y a rien de dynamique sur le serveur de production
    + je peux saisir directement le texte dans un éditeur
    + et cerise sur le gâteau, comme le contenu est constitué uniquement de fichier texte on peut le versionner avec GIT. 

+ Les plus de Sculpin
    + les templates qui utilisent Twig
    + différents modules de symfony


2. Présentation du projet<a id="chap2"></a> [<i class="icon icon-chevron-up"></i>](#sommaire "Retourner au sommaire")
-------------------------

Dans ce tutoriel, je vais vous expliquer comment mettre un blog en place rapidement avec Sculpin.
En page d'accueil seront affichés les articles par date, il y aura une pagination configurable. Chaque article aura des catégories et des tags. On pourra afficher les articles par catégorie ou par tag.

Ça me ferait un grand plaisir que vous me laissiez des commentaires, soit pour m'encourager ou bien pour reprendre des bêtises que j'aurai pu écrire. 


3. Installation de Sculpin<a id="chap3"></a> [<i class="icon icon-chevron-up"></i>](#sommaire "Retourner au sommaire")
--------------------------

Tout est très bien expliqué dans la documentation de Sculpin (lien). En voici un résumé rapide, avec les commandes pour les utilisateurs sous Linux :

1. On télécharge sculpin, il est sous la forme dans phar : https://download.sculpin.io/sculpin.phar(lien)
2. Pour Linux on saisie cette ligne depuis la console : chmod +x sculpin.phar 
3. On renomme sculpin.phar en sculpin  :  mv sculpin.phar sculpin
4. On déplace vers bin/sculpin : mv sculpin bin/
5. On télécharge composer : http://getcomposer.org/download/(lien)
6. On créait le fichier composer.json
7. On télécharge des sources avec composer : php composer.phar update
8. Afin on créait le dossier source à la racine de notre projet. C'est dans ce répertoire que l'on va travailler 


4. Les premières pages – pour l'exemple<a id="chap4"></a> [<i class="icon icon-chevron-up"></i>](#sommaire "Retourner au sommaire")
---------------------------------------

Pour l'exemple, on va créait des pages simples qui seront une page "accueil" et une page "à propos". On va mettre du contenu factice pour le moment mais elles nous resservirons plus tard dans le projet.

Dans le répertoire source/ précédemment créé on ajoute le fichier index.twig avec le contenu suivant :

~~~html
---
permalink: "index.html"
---
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Description">
    <title>Titre</title>
    <link rel="stylesheet" href="http://localhost/tuto/sculpin/output_local/css/style.css" media="all">
</head>
<body>
    <p><a href="about.html">About</a></p>
</body>
</html>
~~~

Vous pouvez reconnaître une page html ultra-classique. La seule particularité se trouve dans les 3 premières lignes.
Chaque page a des paramètres. Ces paramètres sont écrits en deux lignes de tirets. Dans cet exemple on dit que cette page aura index.html comme nom. 

Dans la même veine, on créait la page about.twig avec ce contenu :

~~~html
---
permalink: "about.html"
---
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Description">
    <title>Titre</title>
    <link rel="stylesheet" href="http://localhost/tuto/sculpin/output_local/css/style.css" media="all">
</head>
<body>
    <div class="pure-g-r">
        <div class="pure-u-1">
            <p><a href="index.html">Accueil</a></p>
        </div>
    </div>
</body>
</html>
~~~

Le principe est le même, on indique que la page aura comme nom about.html.

On aurait très bien pu utiliser un autre format pour ces deux fichiers, par exemple index.html à la place de index.twig.

Désormais nous sommes prêts à générer nos premiers fichiers.
On ouvre une console et depuis la racine du projet on tape : 
~~~
 php bin/sculpin generate 
~~~

Vous pouvez constater qu'un nouveau répertoire à fait son apparition à la racine du projet. Ce répertoire s'appelle output_dev. C'est dans ce répertoire qu'est généré le site statique. Vous pouvez y accéder avec un navigateur web et naviguer entre les deux pages index.html et about.html.

Une petite astuce bien partique, pour générer les fichiers automatiquement dès qu'il y a un changement il suffit de taper dans la console:
~~~
 php bin/sculpin generate --watch
~~~

5. Le template<a id="chap5"></a> [<i class="icon icon-chevron-up"></i>](#sommaire "Retourner au sommaire")
-------------

Pour nous simplifier la vie nous allons écrire un template qui servira de base à nos pages.
Dans notre dossier source, nous créons un répertoire appelé _views et nous allons y mettre un fichier Twig appelé default.twig avec le contenu suivant :

~~~html
<!doctype html>
<html  lang="fr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="description">
    <title>Titre</title>
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.3.0/pure-min.css">
    <link rel="stylesheet" href="ADRESSEDUSITE/css/style.css">
</head>
<body>
    
    <div class="pure-g-r" id="layout">
        <div class="sidebar pure-u">
            <header class="header">
                <hgroup>
                    <h1 class="brand-title">Titre du site</h1>
                </hgroup>

                <nav class="nav">
                    <ul class="nav-list">
                        <li class="nav-item">
                            <a class="pure-button" href=" ADRESSEDUSITE ">Accueil</a>
                        </li>
                        <li class="nav-item">
                            <a class="pure-button" href=" ADRESSEDUSITE /about.html">A propos</a>
                        </li>
                    </ul>
                </nav>
            </header>
        </div>

        <div class="pure-u-1">
            <div class="content">

                <div class="posts">
                    {% verbatim %}{% block content_wrapper %}{% block content %}{% endblock%}{% endblock%} {% endverbatim %}
                </div>

                <footer class="footer">
                    <div class="pure-menu pure-menu-horizontal pure-menu-open">
                        <ul>
                            <li><a href=" ADRESSEDUSITE ">Accueil</a></li>
                            <li><a href=" ADRESSEDUSITE /about.html">A propos</a></li>
                        </ul>
                    </div>
                </footer>
            </div>
        </div>

    </div>
    </body>
</html>
~~~

La partie intéressante est « {% verbatim %}{% block content_wrapper %}{% block content %}{% endblock%}{% endblock%}{% endverbatim %} »
Où le block content_wrapper nous servira au design du contenu et à mettre tout le contenu annexe, comme le titre de la page ou les tags de cette page, et le block content nous servira à y mettre le contenu.
Désormais nous pouvons modifier la page index.twig et la page about.twig pour utiliser ce template.


Par exemple pour la page about.twig :
~~~html
---
permalink: "about.html"
layout: default
---
{% verbatim %}{% block content %}
<div class="pure-u-1">
    <p><a href="index.html">Accueil</a></p>
</div>
{% endblock%}{% endverbatim %}
~~~

Où l’on a mis le nom du template dans la variable layout. Puis on a mis notre contenu dans le block content. Nous utiliserons le block content_wrapper pour les pages avec les articles.
Rien ne nous empêche d’avoir différents template. La seule obligation est de les mettre dans le répertoire _view. Ensuite il suffit de les appeler en utiliser la variable layout.
