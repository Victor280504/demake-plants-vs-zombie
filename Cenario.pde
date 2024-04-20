class Cenario {
  int tam = 88;
  int s = 0;
  int k = 0;
  void desenha() {
    grama();
    nubank.desenha();
    if (start) {
      loja.desenha();
    }
  }
  void grama() {
    noStroke();
    for (int i=0; i<6; i++) {
      for (int j=0; j<5; j++) {
        if (i%2==0 && j%2==0 || i%2==1 && j%2==1)
          fill(80, 193, 56);
        else fill(96, 203, 70);
        rect(i*tam+50, j*tam+70, tam, tam);
      }
    }
  }
}
