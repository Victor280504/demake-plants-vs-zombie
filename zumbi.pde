class Colisao {
  float x, y, dx, dy, larg, alt;
  float pX, pY, pLarg, pAlt;
  boolean desenha = true;
  boolean colisao  = false;
  boolean ataque = false;
  int vida;
  int p=0;
  int tempo=0;
  void verificaVida() {
    if (this.colisao) {
      vida-=1;
      this.colisao=false;
    }
  }
  void verificaDesenho(int posX, int posY) {
    if (tempo>p)
      verificaVida();
    if (this.vida==0) {
      loja.Pos[posX][posY] = false;
      this.desenha=false;
    }
  }
  void colisao() {
    for (int j=0; j< zumbisV.length; j++) {
      for (int i=0; i< zumbisV[j].zumbis.size(); i++) {
        if (this.x+this.larg-20>zumbisV[j].zumbis.get(i).x+20 && this.x<zumbisV[j].zumbis.get(i).x+zumbisV[j].zumbis.get(i).larg) {
          if (this.y+this.alt>zumbisV[j].zumbis.get(i).y && this.y<zumbisV[j].zumbis.get(i).y+zumbisV[j].zumbis.get(i).alt) {
            this.colisao=true;
            zumbisV[j].zumbis.get(i).estadoZumbi=zumbisV[j].zumbis.get(i).frame0;
            zumbisV[j].zumbis.get(i).tempoZumbi=0;

            if (p==0)
              zumbisV[j].zumbis.get(i).vida--;
            if (p!=0)
              zumbisV[j].zumbis.get(i).x+=zumbisV[j].zumbis.get(i).dx;
            tempo++;
          }
        }
      }
    }
  }
  boolean colisao2(int coluna) {
    boolean resultado = false;
    for (int i=0; i< zumbisV[coluna].zumbis.size(); i++) {
      if (this.pX+this.pLarg>zumbisV[coluna].zumbis.get(i).x && this.pX<zumbisV[coluna].zumbis.get(i).x+zumbisV[coluna].zumbis.get(i).larg) {
        if (this.pY+this.pAlt>zumbisV[coluna].zumbis.get(i).y && this.pY<zumbisV[coluna].zumbis.get(i).y+zumbisV[coluna].zumbis.get(i).alt) {
          resultado = true;
        } else {
          resultado = false;
        }
      }
    }
    return resultado;
  }
}

class Zumbi {
  PImage zumbiFrame1, zumbiFrame2, zumbiFrame3;

  final int frame0 =0;
  final int frame1 =1;
  final int frame2 =2;
  int estadoZumbi = frame0;
  int tempoZumbi = 0;

  float x, y, dx, dy, larg, alt;
  boolean desenha = false;
  boolean colisao  = false;
  int vida;
  float s, k;
  Zumbi(float posX, float posY, int life, float vx) {
    s = posX;
    k = posY;
    x = 50+88*posX;
    y = 70+88*posY;
    dx = vx;
    dy = 5;
    vida = life;
    larg = 88;
    alt  = 88;
    if (life==5) {
      zumbiFrame1 = loadImage("zumbiFrame1.png");
      zumbiFrame2 = loadImage("zumbiFrame2.png");
      zumbiFrame3 = loadImage("zumbiFrame3.png");
    } else if (life==10) {
      zumbiFrame1 = loadImage("zumbiBaldeFrame1.png");
      zumbiFrame2 = loadImage("zumbiBaldeFrame2.png");
      zumbiFrame3 = loadImage("zumbiBaldeFrame3.png");
    }
  }

  void desenha() {
    mef();
    mostraZumbi(estadoZumbi);
  }
  void mef() {
    if (estadoZumbi == frame0) {
      tempoZumbi++;
      if (tempoZumbi>30-(1*nubank.dinheiro/150)) {
        estadoZumbi=frame1;
        tempoZumbi=0;
      }
    }
    if (estadoZumbi == frame1) {
      tempoZumbi++;
      if (tempoZumbi>30-(1*nubank.dinheiro/150)) {
        estadoZumbi=frame2;
        tempoZumbi=0;
      }
    }
    if (estadoZumbi == frame2) {
      tempoZumbi++;
      if (tempoZumbi>30-(1*nubank.dinheiro/150)) {
        estadoZumbi=frame0;
        tempoZumbi=0;
      }
    }
  }

  void mostraZumbi(int estado) {
    if (estado==frame0) {
      image(zumbiFrame1, this.x, this.y, this.larg, this.alt);
    } else if (estado==frame1) {
      image(zumbiFrame2, this.x, this.y, this.larg, this.alt);
    } else if (estado==frame2) {
      image(zumbiFrame3, this.x, this.y, this.larg, this.alt);
    }
  }

  void update() {
    this.x-=dx;
    if (this.x+this.larg<0) {
      start=false;
      gameOver=true;
    }
  }
}

class mandaZumbis {
  int t=1;
  ArrayList<Zumbi> zumbis = new ArrayList();
  float px, py;
  int quantidade;
  int count=0;
  int vida;

  mandaZumbis(int posX, int posY, int quant) {
    quantidade = quant;
    px = posX;
    py = posY;
  }
  Zumbi setZumbi() {
    int sorteio = int(random(0, 2));
    if (sorteio==1)
      vida = 5;
    else vida =10;
    Zumbi m = new Zumbi (px, py, vida, 0.4+0.1*nubank.dinheiro/150);
    return m;
  }
  void CriaZumbi() {

    // if (count<this.quantidade) {
    if (t%int(random(800, 1200))==0) {
      zumbis.add(0, setZumbi());
      t=1;
      // count++;
      //}
    }
    for (int i =0; i < zumbis.size(); i++) {
      zumbis.get(i).desenha();
      zumbis.get(i).update();
      if (zumbis.get(i).vida<1) {
        zumbis.remove(zumbis.size()-1);
        for (int j= 0; j< loja.ervilha.size(); j++) {
          loja.ervilha.get(j).ataque = false;
        }
      }
    }
    t++;
  }
}
