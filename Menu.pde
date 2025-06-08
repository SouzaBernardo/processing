class Menu {

  TEXTBOX texto = new TEXTBOX(width, 55, 200, 35, 1);
  BUTTON botao = new BUTTON(width, 100, 200, 35);

  Menu() {
    texto.BorderEnable = true;
    texto.Text = "Nome";
    botao.Text = "Iniciar";
  }

  void mostrar(String nome) {
    titulo("Caça do Quadrado");
    texto.DRAW();
    botao.DRAW();
  }
  
   void iniciarJogo() {
    botao.PRESSED(mouseX, mouseY);
    texto.PRESSED(mouseX, mouseY);

    if(texto.selected) {
      texto.Text = "";
    }
    if(botao.clicked) {
      fimDeGame = false;
      nomeJogador = texto.Text;
      if (game == null && nomeValido(nomeJogador)){
        game = new Game(nomeJogador);
      }
      botao.RELEASED();
    }
  }
  
  
  void definirNomeJogador() {
    if(texto.KEYPRESSED(key, (int) keyCode)) {
      nomeJogador = texto.Text;
    }
  }
 
  void titulo(String valor) {
    fill(0);
    textSize(25);
    text(valor, (width / 2) - textWidth(valor) / 2, 25);
  }
  
  boolean nomeValido(String nomeJogador) {
    return nomeJogador != null && nomeJogador != "" && nomeJogador != "Nome"; 
  }
}
