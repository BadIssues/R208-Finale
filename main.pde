// Sujet Labyrinthe 

// Constantes de définition du jeu
final int nbrlignes = 20;
final int nbrcolonnes = 20;
final int tailleCase = 30;
boolean tutorielTermine = false;

// Création des instances de classe
Labyrinthe labyrinthe;
Joueur joueur;
Bot bot;
PImage ImageExplosion;

// Fonction pour définir la taille de la fenêtre
void settings() {
  size(nbrcolonnes * tailleCase, nbrlignes * tailleCase);
  ImageExplosion = loadImage("explosion.png");

  // Initialisation des instances de classe
  labyrinthe = new Labyrinthe(nbrlignes, nbrcolonnes);
  joueur = new Joueur(1, 1);
  bot = new Bot(nbrcolonnes - 2, nbrlignes - 2);
}

// Fonction pour afficher un message au centre avec une couleur et une taille spécifiée
void afficherMessage(String message, float y, int couleur, int taille) {
  fill(couleur); // Couleur spécifiée
  textSize(taille);
  textFont(createFont("Arial", taille, true)); // Police en Arial, taille spécifiée, gras
  textAlign(CENTER, CENTER);
  text(message, width / 2, y);
}

// Fonction pour afficher le tutoriel au démarrage
void afficherTutoriel() {
  background(0); // Fond noir
  float lineHeight = 25; // Espacement entre les lignes du tutoriel
  float y = height / 4;
  int tailleTexte = 10;

  afficherMessage("Bienvenue dans le jeu du labyrinthe!", y, color(255), tailleTexte);
  y += lineHeight;
  afficherMessage("Utilisez les touches fléchées pour déplacer le joueur.", y, color(255), tailleTexte);
  y += lineHeight;
  afficherMessage("Appuyez sur les touches fléchées contre un mur pour utiliser une pioche.", y, color(255), tailleTexte);
  y += lineHeight;
  afficherMessage("Votre objectif est d'atteindre la sortie rouge en évitant le bot.", y, color(255), tailleTexte);
  y += lineHeight;
  afficherMessage("PS : Modifier la difficulté par la grandeur du labyrinthe en haut du fichier main", y, color(255), tailleTexte);
  y += lineHeight * 2;
  afficherMessage("Appuyez sur une touche pour commencer le jeu.", y, color(255), tailleTexte);

  // Vérifie si une touche est pressée pour terminer le tutoriel
  if (keyPressed) {
    tutorielTermine = true;
  }
}

// Fonction pour afficher le nombre de pioches restantes
void afficherPioche() {
  fill(255); // Texte blanc
  textSize(20);
  textFont(createFont("Arial", 20, true)); // Police en Arial, taille 20, gras
  text("Pioches restantes: " + joueur.piocheRestante, 100, 15);
}

// Fonction pour dessiner le contenu de la fenêtre
void draw() {
  if (!tutorielTermine) {
    afficherTutoriel();
  } else {
    // Déroulement du jeu après la fin du tutoriel

    background(255); // Fond blanc
    labyrinthe.afficherLabyrinthe();

    // Gérer le mouvement du joueur
    joueur.mouvement();
    joueur.afficher();

    // Gérer le mouvement aléatoire du bot
    bot.mouvement(bot.reconnaissance());
    bot.afficher();

    // Affichage pioche restante
    afficherPioche();

    // Vérifier la collision entre le joueur et le bot
    if (joueur.getPositionX() == bot.getPositionX() && joueur.getPositionY() == bot.getPositionY()) // Condition dégalité des X et des Y
    {
      image(ImageExplosion, joueur.getPositionX() * tailleCase - tailleCase, joueur.getPositionY() * tailleCase - tailleCase, 3 * tailleCase, 3 * tailleCase);
      afficherMessage("Défaite", height / 2, color(255, 0, 0), 40); // Rouge pour la défaite
      noLoop();
    }
    if (joueur.getPositionX() == nbrcolonnes - 2 && joueur.getPositionY() == nbrlignes - 2) {
      afficherMessage("Victoire", height / 2, color(0, 255, 0), 40); // Vert pour la victoire
      noLoop();
    }
  }
}
