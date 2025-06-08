class Game {
  Jogador jogador;
  ArrayList<Inimigo> inimigos = new ArrayList<>();
  int capturados = 0;
  
  Game(String nomeJogador) {
    jogador = new Jogador(nomeJogador, width / 2, height / 2);
    adicionarInimigo();
    adicionarInimigo();
  }
  
  void mostrar() {
    
    for(Inimigo b : inimigos){
      b.atualizar();
      b.mostrar();
      b.colisaoBordas();
      b.colisaoInimigo(jogador);
    }

    jogador.mostrar();
    fill(255);
    noStroke();
    rect(0, 0, 200, 25);
    fill(0);
    text("Capturados: " + this.capturados, 5, 20);

    fimDeGame = jogadorMorreu() || jogadorVenceu();
  }
  
  boolean jogadorMorreu() {
    return jogador.vida <= 0;
  }

  boolean jogadorVenceu() {
    return capturados >= 5;
  }
  
  void adicionarPonto() {
     capturados++;
  }
  
  void adicionarInimigo() {
    inimigos.add(new Inimigo(20));
  }
}
