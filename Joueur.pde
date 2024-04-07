// Classe représentant la gestion de notre personnage
class Joueur {
  int positionX; // Position X actuelle du joueur
  int positionY; // Position Y actuelle du joueur
  boolean peutSeDeplacer; // Indique si le joueur peut se déplacer ou non
  int tempsDernierDeplacement; // Moment du dernier déplacement
  int delaiEntreDeplacements = 200; // Délai en millisecondes entre les déplacements
  int piocheRestante = 3; // Nombre de pioches restantes pour le joueur

  Joueur(int positionX, int positionY) {
    this.positionX = positionX;
    this.positionY = positionY;
    this.peutSeDeplacer = true;
    this.tempsDernierDeplacement = millis(); // Initialise le temps au moment de la création du joueur
  }

  // Méthode pour déplacer le joueur vers une nouvelle position
  void deplacer(int nouvellePosX, int nouvellePosY) { 
    positionX = nouvellePosX;
    positionY = nouvellePosY;
  }

  // Méthode pour afficher le joueur à sa position actuelle
  void afficher() {
    pushMatrix(); // Sauvegarde de la matrice de transformation actuelle

    fill(0, 0, 255); // Couleur pour le joueur (bleu ici)
    translate(positionX * tailleCase + tailleCase / 2, positionY * tailleCase + tailleCase / 2);
    ellipse(0, 0, tailleCase * 0.8, tailleCase * 0.8);

    popMatrix(); // Restauration de la matrice de transformation précédente
  }

  // Méthode pour gérer le mouvement du joueur
  void mouvement() {
    if (keyPressed && peutSeDeplacer) {
      // Vérifier si la touche correspond à une direction et si la case vers laquelle le joueur souhaite se déplacer n'est pas un mur
      if (keyCode == UP && positionY > 0 && !labyrinthe.plateau[positionY - 1][positionX].IsMur) 
      {
        deplacer(positionX, positionY - 1);
      } 
      else if (keyCode == DOWN && positionY < labyrinthe.getNbrlignes() - 1 && !labyrinthe.plateau[positionY + 1][positionX].IsMur) 
      {
        deplacer(positionX, positionY + 1);
      } 
      else if (keyCode == LEFT && positionX > 0 && !labyrinthe.plateau[positionY][positionX - 1].IsMur)
      {
        deplacer(positionX - 1, positionY);
      } 
      else if (keyCode == RIGHT && positionX < labyrinthe.getNbrcolonnes() - 1 && !labyrinthe.plateau[positionY][positionX + 1].IsMur)
      {
        deplacer(positionX + 1, positionY);
      } 
      else if (piocheRestante > 0) 
      {
        if (keyCode == DOWN && positionY < labyrinthe.getNbrlignes() - 2 && labyrinthe.plateau[positionY + 1][positionX].IsMur) 
        {
          deplacer(positionX, positionY + 1);
          labyrinthe.plateau[positionY][positionX].IsMur = false;
          piocheRestante--;
        } 
        else if (keyCode == LEFT && positionX > 1 && labyrinthe.plateau[positionY][positionX - 1].IsMur) 
        {
          deplacer(positionX - 1, positionY);
          labyrinthe.plateau[positionY][positionX ].IsMur = false;
          piocheRestante--;
        } 
        else if (keyCode == RIGHT && positionX < labyrinthe.getNbrcolonnes() - 2 && labyrinthe.plateau[positionY][positionX + 1].IsMur) 
        {
          deplacer(positionX + 1, positionY);
          labyrinthe.plateau[positionY][positionX].IsMur = false;
          piocheRestante--;
        } 
        else if (keyCode == UP && positionY > 1 && labyrinthe.plateau[positionY - 1][positionX].IsMur) 
        {
          deplacer(positionX, positionY + 1);
          labyrinthe.plateau[positionY][positionX].IsMur = false;
          piocheRestante--;
        }
      }
      
      // Met à jour le temps du dernier déplacement et bloque les déplacements pour un certain délai
      tempsDernierDeplacement = millis();
      peutSeDeplacer = false;
    }

    // Vérifie si le délai entre les déplacements est écoulé, permettant ainsi au joueur de se déplacer à nouveau
    if (millis() - tempsDernierDeplacement >= delaiEntreDeplacements) {
      peutSeDeplacer = true;
    }
  }
  
  int getPositionX(){return positionX;}
  int getPositionY(){return positionY;}
}
