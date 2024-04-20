Cenario composicao;
Cortador[] cortador;
Loja loja;
mandaZumbis zumbisV[];
Banco nubank;
PFont DePixelBreit;
int v=0, g=0;
boolean start = false, gameOver = false;

void setup() {
  size(620, 540);
  noStroke();
  DePixelBreit = createFont("DePixelBreit.ttf", 20);
  reset();
}
void draw() {
  background(222, 208, 173);
  composicao.desenha();
  if (gameOver) {
    textFont(DePixelBreit);
    fill(255);
    text("GAME OVER", 450, 43);
    fill(0);
    text("PONTOS: "+nubank.dinheiro, 160, 250);
  }

  if (start) {
    configuracoes();
  } else {
    textFont(DePixelBreit, 20);
    fill(0);
    if (g>25 && g<60) {
      text("PRESS SPACE TO START", 160, 280);
    }
    if (g>60) {
      g=0;
    }
  }
  g++;
  if (loja.s2 && loja.s1==false) {
    compraIcon();
  }
}

void keyPressed() {
  if (start) {
    if (loja.s1) {
      loja.posicionaSelecaoL();
      loja.aprovaCompra();
      //if (key == ' ' && loja.compraAprovada==true && loja.s2==false) {

      //}
    } else if (loja.s2) {
      loja.posicionaSelecao();
      loja.compra();
    }
  }

  if (start==false) {
    if (key == ' ') {
      reset();
      gameOver=false;
      start=true;
    }
  }
}

void configuracoes() {
  for (int i=0; i<v; i++) {
    zumbisV[i].CriaZumbi();
  }
  for (int i = 0; i<cortador.length; i++) {
    cortador[i].desenha();
  }
  if (v<5) {
    if (frameCount%600==0)
      v++;
  }
}
void compraIcon() {
  switch(loja.l) {
  case 0:
    if (loja.k !=-1 && loja.s!=-1) 
      image(loja.icon1, loja.s*88+50, loja.k*88+70, 88, 88);
    break;
  case 1:
    if (loja.k !=-1 && loja.s!=-1) 
      image(loja.icon2, loja.s*88+50, loja.k*88+70, 88, 88);
    break;
  case 2:
    if (loja.k !=-1 && loja.s!=-1) 
      image(loja.icon3, loja.s*88+50, loja.k*88+70, 88, 88);
    break;
  case 3:
    if (loja.k !=-1 && loja.s!=-1) 
      image(loja.icon4, loja.s*88+50, loja.k*88+70, 88, 88);
    break;
  }
}

void reset() {
  zumbisV = new mandaZumbis[5];
  cortador = new Cortador[5];
  composicao = new Cenario();
  nubank = new Banco(360, 0, 50);
  loja = new Loja();
  v=0;
  for (int i=0; i<zumbisV.length; i++) {
    zumbisV[i] = new mandaZumbis(int(random(10, 20)), i, 5);
  }
  for (int i = 0; i<cortador.length; i++) {
    cortador[i] = new Cortador(-1, i, 5, 0);
  }
}
