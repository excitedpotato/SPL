# SPL

WARNING : Il y a encore un bug lors d'opération à deux variables. Le reste Fontionne.


Tous d’abord il faut compiler le projet :

    • Pour compiler manuelemnt :
          Il faut d’abord génréer le parser avec bison avec l’argument «-d » pour qu’il génre un fichier Header : $ bison -d simplY.y. Ensuite il faut gènérer le code avec Flex : $ flex simplL.l. Enfin, on compile le tous : 
          $ gcc lex.yy.c simplY.tab.c


    • Pout compiler automatiquement :
       	
        ◦ Sous Windows : 
               		Il suffit d’éxecuter make.bat pour qque tous le projet sois compiler.
        ◦ Sous Linux : 
               		Il suffit d’éxecuter la commande $ make pour compiler le projet
                                   		
              
	





Une fois que le programme est lancée ( $ ./a.out sous Unix et $ a.exe sous windows) on peut commencer à utiliser l’inérpréteur.

Plusieurs chose sont possible, déjà les opération arithmétique de base sont accepter et renverront une valeurs directement afficher si une variable n’est pas déclarer. 

Exemple : 23 + 2 affichera 25

Affectation de variable :

Il est possible d’affecter des variables ( puisque les variables n’utilise pas un systéme chainée le nombre de variable n’est pas infinis, mais est largement suffisant pour un usage humain. ) : il suffit d’écrire nom_de_variable (où le nom ne contient que des minuscules et pas de chiffre) = expression arithmétique.

Exemple : variable = 2 ou bien variable = 2 * 42

Pour afficher des variables, il suffit d’utiliser le mot clée _print suivit du nom de variable que le sont souhaite afficher.

Exemple : _print nom_de_variable
