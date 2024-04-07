// Classe représentant une case du labyrinthe
class Case {
  boolean IsMur; // Indique si la case est un mur ou non

  // Constructeur pour initialiser une case avec le type (mur ou non mur)
  Case(boolean IsMur) 
  {
    this.IsMur = IsMur;
  }

  // Méthode pour afficher une case
  void afficher(int x, int y, int tailleCase) 
  {
    // Changer la couleur en bleu si c'est la position de départ du joueur
    if (x == 1 * tailleCase && y == 1 * tailleCase)
    {
      fill(0, 0, 255);
    } 
    // Changer la couleur en rouge si c'est la position de départ du bot
    else if (x == (nbrcolonnes - 2) * tailleCase && y == (nbrlignes - 2) * tailleCase)
    {
      fill(255, 0, 0);
    } 
    // Choisir la couleur en fonction de la présence d'un mur ou non
    else if (IsMur) {
      fill(0); // Couleur pour un mur (noir ici)
    } else {
      fill(255); // Couleur pour une cellule non mur (blanc ici)
    }
    
    // Dessiner un rectangle pour représenter la case
    rect(x, y, tailleCase, tailleCase);
  }
}
