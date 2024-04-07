 //<>//
// Classe représentant la gestion d'un bot

class Bot {
  int positionX;
  int positionY;
  int couleur = color(255, 0, 0); // Rouge
  int dernierDeplacement;
  int piocheRestante = 10;

  // Constructeur de la classe
  Bot(int positionX, int positionY) 
  {
    this.positionX = positionX;
    this.positionY = positionY;
    this.dernierDeplacement = millis(); // Initialise le temps au moment de la création du bot
  }
  
  
  // Méthode pour déplacer le bot vers une nouvelle position
  void deplacer(int nouvellePosX, int nouvellePosY) 
  {
    positionX = nouvellePosX;
    positionY = nouvellePosY;
  }


  // Méthode pour afficher le bot à sa position actuelle
  void afficher() 
  {
    pushMatrix(); // Sauvegarde de la matrice de transformation actuelle

    fill(couleur);
    translate(positionX * tailleCase + tailleCase / 2, positionY * tailleCase + tailleCase / 2);
    ellipse(0, 0, tailleCase * 0.8, tailleCase * 0.8);

    popMatrix(); // Restauration de la matrice de transformation précédente
  }
  
  
  // Méthode pour donner une vision au robot
  // 0: UP, 1: DOWN, 2: LEFT, 3: RIGHT
  int reconnaissance() {
    int direction;
    int distanceX = abs(positionX - joueur.getPositionX());
    int distanceY = abs(positionY - joueur.getPositionY());

    // Le joueur est à proximité, choisir une direction pour s'approcher
    if (distanceX <= 2 && distanceY <= 2) {
      // Le joueur est plus éloigné horizontalement
      if (distanceX > distanceY) {
        // Le joueur est à gauche du bot et il n'y a pas de mur à gauche
        if (positionX > joueur.getPositionX() && positionX > 0 && !labyrinthe.plateau[positionY][positionX-1].IsMur) {
          direction = 2; // Déplacement à gauche
        } else if (positionX < labyrinthe.getNbrcolonnes() - 1 && !labyrinthe.plateau[positionY][positionX+1].IsMur){
          direction = 3; // Déplacement à droite
        } else {
          direction = int(random(4)); // Aucun mouvement possible, choisir aléatoirement
        }
      } else {
        // Le joueur est plus éloigné verticalement
        if (positionY > joueur.getPositionY() && positionY > 0 && !labyrinthe.plateau[positionY-1][positionX].IsMur) {
          direction = 0; // Déplacement vers le haut
        } else if (positionY < labyrinthe.getNbrlignes() - 1 && !labyrinthe.plateau[positionY+1][positionX].IsMur){
          direction = 1; // Déplacement vers le bas
        } else {
          direction = int(random(4)); // Aucun mouvement possible, choisir aléatoirement
        }
      }
    } else {
      // Le joueur n'est pas à proximité, choisir une direction aléatoire
      direction = int(random(4));
    }
    return direction;
  }


  // Méthode pour effectuer le mouvement du bot avec un délai
  // 0: UP, 1: DOWN, 2: LEFT, 3: RIGHT
  void mouvement(int direction) 
  {
    // Vérifie si le délai entre les déplacements est écoulé
    if (millis() - dernierDeplacement >= 300) 
    {
      // Déplacement aléatoire du bot
      if (direction == 0 && positionY > 0 && !labyrinthe.plateau[positionY - 1][positionX].IsMur) 
      {
        deplacer(positionX, positionY-1);
      } else if (direction == 1 && positionY < labyrinthe.getNbrlignes() - 1 && !labyrinthe.plateau[positionY + 1][positionX].IsMur)
      {
        deplacer(positionX, positionY+1);
      } else if (direction == 2 && positionX > 0 && !labyrinthe.plateau[positionY][positionX - 1].IsMur) 
      {
        deplacer(positionX-1, positionY);
      } else if (direction == 3 && positionX < labyrinthe.getNbrcolonnes() - 1 && !labyrinthe.plateau[positionY][positionX + 1].IsMur)
      {
        deplacer(positionX+1, positionY);
      } else if (piocheRestante > 0) {
        // Utilisation de la pioche pour dégager le chemin
        if (direction == 0 && positionY < labyrinthe.getNbrlignes() - 2 && labyrinthe.plateau[positionY + 1][positionX].IsMur)
        {
          deplacer(positionX, positionY + 1);
          labyrinthe.plateau[positionY][positionX].IsMur = false;
          piocheRestante--;
        } else if (direction == 2 && positionX > 1 && labyrinthe.plateau[positionY][positionX - 1].IsMur)
        {
          deplacer(positionX - 1, positionY);
          labyrinthe.plateau[positionY][positionX].IsMur = false;
          piocheRestante--;
        } else if (direction == 3 && positionX < labyrinthe.getNbrcolonnes() - 2 && labyrinthe.plateau[positionY][positionX + 1].IsMur)
        {
          deplacer(positionX + 1, positionY);
          labyrinthe.plateau[positionY][positionX].IsMur = false;
          piocheRestante--;
        } else if (direction == 1 && positionY > 2 && labyrinthe.plateau[positionY - 1][positionX].IsMur)
        {
          deplacer(positionX, positionY - 1);
          labyrinthe.plateau[positionY][positionX].IsMur = false;
          piocheRestante--;
        }
      }

      // Met à jour le temps du dernier déplacement
      dernierDeplacement = millis();
    }
  }
  
  // Méthodes pour récupérer les variables
  int getPositionX(){return positionX;}
  int getPositionY(){return positionY;}
}
