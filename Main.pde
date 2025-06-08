int x1, y1, x2, y2, w, h, speed, counter, target;
boolean fill2;
boolean fimDeGame = false;
Menu menu = new Menu();
FimDeGame telaFim = new FimDeGame(width * 2);
String nomeJogador;
Game game;

void keyPressed() {
  menu.definirNomeJogador();
  if(game != null && game.jogador != null) {
    game.jogador.movimentar();
  }
}

void mousePressed() {
  telaFim.voltarParaTelaInicial();
  menu.iniciarJogo();
}

void setup() {
  size(400, 400);
  background(255);
}

String msgFinal() {
  if (game.jogadorMorreu()) return "Game Over!!!";
  else return "Você Venceu!!!"; 
}

void draw() {
  background(255);
  if(fimDeGame) telaFim.mostrar(msgFinal());
  else if(game == null || nomeJogador == null || nomeJogador == "Nome") menu.mostrar(nomeJogador);
  else game.mostrar();
}
