# Environnements Logiciels pour la Programmation Avancée de Terminaux Mobiles

## Technologie :

Flutter

## Scénario:

Un utilisateur part en soirée, il souhaite contrôler les accès à son téléphone. Bloquer des contacts pour ne pas les appeler et bloquer des applications (jeux). L’application propose de paramétrer les contacts et applications bloquées. Ensuite, pendant une soirée, des tests sont proposés à l’utilisateur pour vérifier son état d’ébriété. Si l’utilisateur semble trop alcoolisé un hôtel et des numéros de taxi lui seront proposé.

## Idées de fonctionnalité :
### Vérification de l’état d’ébriété 
 - Recopier la phrase écrite avec le clavier, deux erreurs possibles, sans correcteur orthographique
 - Avec l'accéléromètre, avoir un compteur puis demander à l’utilisateur de faire un geste rapidement (haut, bas, droite, gauche et combinaison)
 - Test de réflexe balle à toucher, voir le temps de réaction et la distance à la bille
 - Demander à l’utilisateur de marcher droit et vérifier (facilement transposable sur un vecteur)

### Aide offerte pour l’utilisateur trop alcoolisé 
 - Si l’utilisateur ne peut pas débloquer l’application lui proposer un hôtel ou un taxi dans les environs 
 - Blocage appli + numéro

## Possibilités clustering/apprentissage :
 - Clustering: Récupérer les données d’utilisateur saoul ou non et faire des clusters en fonction + données sur le nombre de mots tapés, vitesse
 - Apprentissage: Vecteurs avec les trois accéléromètre, réflexe de la bille, marcher droit et la phrase à écrire


## Etude de l’existant :
 - Il existe des applications pour verrouiller des applications (outils de productivité)
 - Sur IOS et Android plusieurs applications permettent de calculer la quantité d’alcool dans le sang en fonction du nombre de verres consommés. 
 - Sur IOS, une application appelé Drunk Mode-Call blocker permet de retracer les mouvements de la soirée, de prévenir les amis que l’on est rentré chez sois, de bloquer des numéros et voir les autres utilisateurs sur une carte. 


## Capteurs
Accéléromètre, pas de marque/téléphone particulier.

 
## Etudiants : 
Marion Marguerettaz
Camille Le Roux
