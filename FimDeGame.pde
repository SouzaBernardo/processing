class FimDeGame {
  ParticleSystem ps, ps2, ps3;
  BUTTON botao ;
  
  FimDeGame(int tamanho) {
    ps = new ParticleSystem(new PVector(tamanho, -1));
    ps2 = new ParticleSystem(new PVector(tamanho / 2, -1));
    ps3 = new ParticleSystem(new PVector(tamanho + (tamanho / 2), -1));
    botao = new BUTTON(tamanho / 2, 300, 200, 35);
    botao.Text = "Voltar";
    botao.Foreground = color(0);
    botao.Background = color(255);
  }
  
  void mostrar(String msg) {
    background(0);
    
    ps.addParticle();
    ps2.addParticle();
    ps3.addParticle();
    
    ps3.run();
    ps2.run();
    ps.run();
    
    botao.DRAW();
    titulo(msg);
    String msgFinal = "Jogador " + nomeJogador + " pontuou " + game.capturados;
    text(msgFinal, (width / 2) - textWidth(msgFinal) / 2, 250);
  }
  
   void voltarParaTelaInicial() {
    botao.PRESSED(mouseX, mouseY);
    if(botao.clicked) {
      fimDeGame = false;
      nomeJogador = "Nome";
      game = null;
      botao.RELEASED();
    }
  }
 
  void titulo(String valor) {
    fill(255);
    textSize(25);
    text(valor, (width / 2) - textWidth(valor) / 2, 200);
  }

}
