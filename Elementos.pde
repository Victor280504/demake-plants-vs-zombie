
class Ervilha extends Colisao {
  ArrayList <Tiro> tiro = new ArrayList();
  PImage ervilha, imgTiro;
  int s, k;
  int t=1;
  boolean atira=false;
  Ervilha(int posX, int posY, int life, int tempoC) {
    x = 50+88*posX;
    y = 70+88*posY;
    s=posX;
    k=posY;
    dx = 5;
    dy = 5;
    vida = life;
    larg = 88;
    alt  = 88;
    ervilha = loadImage("ervilha.png");
    imgTiro = loadImage("imgTiro.png");
    p = tempoC;
    pX=50;
    pY=70+88*posY;
    pAlt=88;
    pLarg=528;
  }
  void desenha() {
    if (this.desenha) {
      fill(0);
      image(ervilha, this.x, this.y, this.larg, this.alt);
      if (this.atira) {
        atira();
      } 
      colisao();
      t++;
    }
    this.ataque = colisao2(k);

    if (this.ataque) {
      this.atira=true;
    } else {
      this.atira=false;
    }

    verificaDesenho(s, k);
  }
  Tiro setTiro() {
    Tiro m = new Tiro (this.x+this.larg-20, this.y+this.alt/4, 20, 20, 3, 0, imgTiro, 0, k);
    return m;
  }
  void atira() {
    if (t%90==0) {
      t=1;
      tiro.add(0, setTiro());
    }
    for (int i =0; i < tiro.size(); i++) {
      tiro.get(i).desenha();
      if (tiro.get(i).x+tiro.get(i).larg> width || tiro.get(i).colisao==true || colisao2(k)==false) {
        this.tiro.remove(this.tiro.size()-1);
      }
    }
  }

  void plataforma() {
    if (this.ataque)
      fill(255, 0, 0, 50);
    else
      fill(0, 255, 0, 50);
    rect(this.pX, this.pY, this.pLarg, this.pAlt);
  }
}

class Tiro extends Colisao {
  PImage bala;
  int k;
  Tiro(float posX, float posY, float largN, float altN, float velocidadeX, float velocidadeY, PImage imagem, int n, int k1) {
    x = posX;
    y = posY;
    larg=largN;
    alt = altN;
    dx= velocidadeX;
    dy=  velocidadeY;
    bala = imagem;
    this.p=n;
    this.k=k1;
  }
  void desenha() {
    if (this.colisao==false) {
      image(bala, this.x, this.y, this.larg, this.alt);
      update();
      colisao();
    }
  }
  void update() {
    x+=dx;
    y+=dy;
  }
}
class Girassol extends Colisao {
  ArrayList <Tiro> tiro = new ArrayList();
  PImage girassol;
  PImage sol;
  boolean tempoSol = false;
  int s, k;
  int t=1;
  Girassol(int posX, int posY, int life, int tempoC) {
    x = 50+88*posX;
    y = 70+88*posY;
    dx = 5;
    dy = 5;
    s=posX;
    k=posY;
    vida = life;
    larg = 88;
    alt  = 88;
    girassol = loadImage("girassol.png");
    sol = loadImage("sol.png");
    p = tempoC;
  }
  void desenha() {
    if (this.desenha) {
      fill(0);
      image(girassol, this.x, this.y, this.larg, this.alt);
      if (tempoSol) {
        tempo++;
        if (tempo>120) {
          tempo=0;
          tempoSol=false;
        }
      }
      atira();
      colisao();
      t++;
    }
    verificaDesenho(s, k);
  }
  Tiro setTiro(int vx, int vy) {
    Tiro m = new Tiro (this.x, this.y-15, 88, 88, vx, vy, sol, 1, k);
    return m;
  }
  void atira() {
    if (t%600==0) {
      t=1;
      tiro.add(0, setTiro(0, 0));
    }
    for (int i =0; i < tiro.size(); i++) {
      tiro.get(i).desenha();
      tempoSol=true;
      if (tempo>=120) {
        nubank.dinheiro+=25;
        tiro.remove(tiro.size()-1);
      }
    }
  }
}
class Noz extends Colisao {
  PImage noz, noz1;
  int s, k;
  int t =1;
  Noz(int posX, int posY, int life, int tempoC) {
    x = 50+88*posX;
    y = 70+88*posY;
    dx = 5;
    dy = 5;
    s=posX;
    k=posY;
    vida = life;
    larg = 88;
    alt  = 88;
    noz = loadImage("noz.png");
    noz1 = loadImage("nozFrame2.png");
    p = tempoC;
  }
  void desenha() {
    if (this.desenha) {
      if (this.tempo<=this.p/2) {
        image(noz, this.x, this.y, this.larg, this.alt);
      } else image(noz1, this.x, this.y, this.larg, this.alt);
      colisao();
    }
    verificaDesenho(s, k);
  }
}
class Cortador extends Colisao {
  PImage cortador;
  Cortador(int posX, int posY, int vx, int vy) {
    x = 50+88*posX;
    y = 70+88*posY;
    dx = vx;
    dy = vy;
    larg = 88;
    alt  = 88;
    cortador = loadImage("cortadorGrama.png");
  }
  void desenha() {
    if (this.desenha) {
      image(cortador, this.x, this.y, this.larg, this.alt);
      colisao();
    }
    if (this.colisao) {
      update();
    }
    if (this.x>width) {
      this.desenha=false;
      this.colisao=false;
    }
  }
  void update() {
    x+=dx;
    y+=dy;
  }
}
