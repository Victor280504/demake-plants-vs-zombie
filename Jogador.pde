class Banco {
  PImage banco;
  int x, y, dx, dy, larg, alt;
  boolean desenha = false;
  int dinheiro=0;
  int u = int(random(600, 1201));
  Banco(int posX, int posY, int money) {
    x = posX;
    y = posY;
    larg = 260;
    alt  = 70;
    dinheiro = money;
    banco = loadImage("nubank.png");
  }
  void desenha() {
    image(banco, this.x, this.y, this.larg, this.alt);
    if (start) {
      mostraDinheiro();
      redimento();
    }
  }
  void mostraDinheiro() {
    textFont(DePixelBreit);
    fill(255);
    text(this.dinheiro, 450, 43);
  }
  void redimento() {
    if (frameCount%u==0) {
      this.dinheiro+=25;
      u = int(random(600, 1201));
    }
  }
}
