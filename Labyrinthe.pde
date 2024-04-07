// Classe représentant le labyrinthe composé de cases
class Labyrinthe {
  Case[][] plateau; // Matrice représentant le labyrinthe, composée de cases
  private int nbrlignes; // Nombre de lignes dans le labyrinthe
  private int nbrcolonnes; // Nombre de colonnes dans le labyrinthe

  // Constructeur pour initialiser le labyrinthe
  Labyrinthe(int nbrlignes, int nbrcolonnes) {
    this.nbrlignes = nbrlignes;
    this.nbrcolonnes = nbrcolonnes;
    plateau = new Case[nbrlignes][nbrcolonnes];

    // Initialisation du tableau avec des cases par défaut (mur aux bords, chemin au centre)
    for (int i = 0; i < nbrlignes; i++) {
      for (int j = 0; j < nbrcolonnes; j++) {
        plateau[i][j] = new Case(i == 0 || i == nbrlignes - 1 || j == 0 || j == nbrcolonnes - 1 || Math.random() < 0.40); // Permet de définir le pourcentage de mur dans le plateau
      }
    }

    // Ouverture de deux cases pour créer une entrée et une sortie
    plateau[1][1].IsMur = false;
    plateau[nbrlignes - 2][nbrcolonnes - 2].IsMur = false;
  }

  // Méthode pour afficher le labyrinthe
  void afficherLabyrinthe() {
    for (int i = 0; i < nbrlignes; i++) {
      for (int j = 0; j < nbrcolonnes; j++) {
        plateau[i][j].afficher(j * tailleCase, i * tailleCase, tailleCase);
      }
    }
  }

  // Méthodes pour obtenir le nombre de lignes et de colonnes du labyrinthe
  int getNbrlignes() {
    return nbrlignes;
  }

  int getNbrcolonnes() {
    return nbrcolonnes;
  }
}
