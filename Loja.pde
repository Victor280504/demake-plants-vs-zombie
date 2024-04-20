class Loja {
  ArrayList <Ervilha> ervilha = new ArrayList();
  ArrayList <Noz> noz = new ArrayList();
  ArrayList <Girassol> girassol = new ArrayList();
  boolean Pos[][];
  boolean compraAprovada = false;
  int x, y, larg, alt;
  boolean desenha = false;
  boolean colisao  = false;
  PImage loja;
  PImage icon1, icon2, icon3, icon4, icon5;
  boolean s1 = true;
  boolean s2= false;

  int l=0;
  int s=0;
  int k=0;
  int b=0;
  boolean [][] criaMatriz(int n, int v) {
    boolean [][] M = new boolean [n][v];
    for (int i=0; i<M.length; i++) {
      for (int j=0; j<M[0].length; j++) {
        M[i][j]=false;
      }
    }
    return M;
  }
  Loja() {
    x = 50;
    y = 0;
    larg =410;
    alt  =70;
    loja = loadImage("loja.png");
    Pos = criaMatriz(6, 5);
    icon1 = loadImage("girassol.png");
    icon2 = loadImage("ervilha.png");
    icon3 =loadImage("noz.png");
    icon4= loadImage("pa.png");
    icon5= loadImage("cancelar.png");
  }

  void desenha() {
    image(loja, this.x, this.y);
    println(ervilha.size(), girassol.size(), noz.size());
    selecao();
    for (int i = 0; i<ervilha.size(); i++) {
      ervilha.get(i).desenha();
    }
    for (int i = 0; i<girassol.size(); i++) {
      girassol.get(i).desenha();
    }
    for (int i = 0; i<noz.size(); i++) {
      noz.get(i).desenha();
    }
    manutencao();
  }
  void compra() {
    if (key == ' ' && this.s2==true) {
      switch(l) {
      case 0:
        if (k != -1 && s!=-1) {
          criaGirassol();
        } else {
          this.s1=true;
          this.s2=false;
          k=0;
          s=0;
        }
        break;
      case 1:
        if (k != -1 && s!=-1) {
          criaErvilha();
        } else {
          this.s1=true;
          this.s2=false;
          k=0;
          s=0;
        }
        break;
      case 2:
        if (k != -1 && s!=-1) {
          criaNoz();
        } else {
          this.s1=true;
          this.s2=false;
          k=0;
          s=0;
        }
        break;
      case 3:
        if (k != -1 && s!=-1) {
          usaPa();
        } else {
          this.s1=true;
          this.s2=false;
          k=0;
          s=0;
        }
        break;
      }
    }
  }
  void aprovaCompra() {
    if (key == ' ' && this.s1==true) {
      switch(l) {
      case 0:
        if (nubank.dinheiro>=50) {
          this.compraAprovada=true;
          this.s1=false;
          this.s2=true;
        }
        break;
      case 1:
        if (nubank.dinheiro>=100) {
          this.compraAprovada=true;
          this.s1=false;
          this.s2=true;
        }
        break;
      case 2:
        if (nubank.dinheiro>=50) {
          this.compraAprovada=true;
          this.s1=false;
          this.s2=true;
        }
        break;
      case 3:
        int aux =0;
        for (int i=0; i<Pos.length; i++) {
          for (int j=0; j<Pos[0].length; j++) {
            if (Pos[i][j]) {
              aux++;
            }
          }
        }
        if (nubank.dinheiro>=0 && aux>0) {// resolver o bug da pá
          this.compraAprovada=true;
          this.s1=false;
          this.s2=true;
        }
        break;
      }
    }
  }
  void manutencao() {
    for (int i =0; i< ervilha.size(); i++) {
      if (ervilha.get(i).desenha==false) {
        ervilha.remove(i);
      }
    }
    for (int i =0; i< girassol.size(); i++) {
      if (girassol.get(i).desenha==false) {
        girassol.remove(i);
      }
    }
    for (int i =0; i< noz.size(); i++) {
      if (noz.get(i).desenha==false) {
        noz.remove(i);
      }
    }
  }
  Ervilha novaE(int posX, int posY) {
    Ervilha m = new Ervilha(posX, posY, 5, 100);
    return m;
  }
  void criaErvilha() {
    if (key == ' ' && Pos[s][k]==false && nubank.dinheiro>=100) {
      nubank.dinheiro-=100;
      Pos[s][k]=true;
      int aX = s;
      int aY = k;
      ervilha.add(0, novaE(aX, aY));
      this.s1=true;
      this.s2=false;
      this.compraAprovada=false;
    }
  }

  Noz novaN(int posX, int posY, int vida) {
    Noz m = new Noz(posX, posY, 5, vida);
    return m;
  }
  void criaNoz() {
    if (key == ' ' && Pos[s][k]==false && nubank.dinheiro>=50) {
      nubank.dinheiro-=50;
      Pos[s][k]=true;
      int aX = s;
      int aY = k;
      noz.add(0, novaN(aX, aY, 400));
      this.compraAprovada = false;
      this.s2=false;
      this.s1=true;
    }
  }

  Girassol novaG(int posX, int posY) {
    Girassol m = new Girassol(posX, posY, 5, 100);
    return m;
  }
  void criaGirassol() {
    if (key == ' ' && Pos[s][k]==false &&  nubank.dinheiro>=50) {

      nubank.dinheiro-=50;
      Pos[s][k]=true;
      int aX = s;
      int aY = k;
      girassol.add(0, novaG(aX, aY));
      this.s2=false;
      this.s1=true;
      this.compraAprovada = false;
    }
  }

  void usaPa() {
    if (key==' ' && this.compraAprovada) {
      for (int i=0; i< girassol.size(); i++) {
        if (Pos[s][k] && girassol.get(i).k == k && girassol.get(i).s==s) {
          girassol.remove(i);
          nubank.dinheiro+=50;
          Pos[s][k]=false;
          this.s2=false;
          this.s1=true;
          this.compraAprovada=false;
        }
      }
      for (int i=0; i< noz.size(); i++) {
        if (Pos[s][k] && noz.get(i).k == k && noz.get(i).s == s && noz.get(i).tempo<=200) {
          noz.remove(i);
          nubank.dinheiro+=50;
          Pos[s][k]=false;
          this.s2=false;
          this.s1=true;
          this.compraAprovada=false;
        }
      }
      for (int i=0; i< ervilha.size(); i++) {
        if (Pos[s][k] && ervilha.get(i).k == k && ervilha.get(i).s ==s) {
          ervilha.remove(i);
          nubank.dinheiro+=100;
          Pos[s][k]=false;
          this.s2=false;
          this.s1=true;
          this.compraAprovada=false;
        }
      }
    }
  }
  void selecao() {
    if (this.s1)
      desenhaSelecaoL();
    else if (this.s2) {
      image(this.icon5, 4, 14, 41, 41);
      desenhaSelecao();
    }
  }
  void desenhaSelecaoL() {
    noFill();
    stroke(255);
    strokeWeight(3);
    rect(69*l+60, 10, 50, 50);
  }
  void posicionaSelecaoL() {
    if (keyCode==LEFT) {
      if (l>0)
        l--;
    } else if (keyCode==RIGHT) {
      if (l<3)
        l++;
    }
  }
  void desenhaSelecao() {
    noFill();

    strokeWeight(3);
    if (k!=-1 && s!=-1) {
      stroke(135, 78, 56);
      rect(88*s+50, 88*k+70, 88, 88);
    } else {
      stroke(255);
      rect(69*s+73, k*69+83, 40, 40);
    }
  }
  void posicionaSelecao() {
    if ( k==0 && s==0) {
      if (keyCode==UP ||keyCode==LEFT) {
        k=-1;
        s=-1;
      } else if (keyCode==DOWN) {
        if (k<4)
          k++;
      } else if (keyCode==RIGHT) {
        if (s<5)
          s++;
      }
    } else if (k==-1 && s==-1) {
      if (keyCode==RIGHT ||keyCode==DOWN) {
        k=0;
        s=0;
      }
    } else {
      if (keyCode==UP) {
        if (k>0)
          k--;
      } else if (keyCode==DOWN) {
        if (k<4)
          k++;
      } else if (keyCode==LEFT) {
        if (s>0)
          s--;
      } else if (keyCode==RIGHT) {
        if (s<5)
          s++;
      }
    }
  }
}
