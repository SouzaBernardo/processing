
class Jogador {
  String nome;
  int x, y, largura, altura, vida, velocidade;

  Jogador(String nome, int x, int y) {
    this.x = x;
    this.y = y;
    this.vida = 255;
    this.velocidade = 10;
    this.largura =35;
    this.altura = 35;
    this.nome = nome;
  }
  
  void mostrar() {
    mostarNome();
    int r = 255 - vida; 
    int g = vida;       
    fill(r, g, 0);      
    stroke(0);
    strokeWeight(4);
    rect(x, y, largura, altura);
  }
  
  void mostarNome() {
    fill(0);
    float nomeCentralizado = x + (largura / 2) - (textWidth(nome) / 2);
    textSize(18);
    text(nome, nomeCentralizado, y - 5);
  }
  
  color corDaVida(int vida) {
    int r, g;
    
    if (vida >= 128) {
      float t = map(vida, 128, 255, 0, 1);
      r = int(255 * (1 - t));
      g = 255;
    } else {
      float t = map(vida, 0, 127, 0, 1);
      r = 255;
      g = int(255 * t);
    }
  
    return color(r, g, 0);
  }
  
  void receberDano(int dano) {
    vida -= dano;
    vida = constrain(vida, 0, 255); 
  }
  
  void movimentar() {
     if (keyCode == UP && y > 0) {
      y -= velocidade;
    }
    
    if (keyCode == DOWN && y < height - this.altura) {
        y += velocidade;
    }

    if (keyCode == LEFT && x > 0) {
        x -= velocidade;
    }
    
    if (keyCode == RIGHT && x < width - this.largura) {
        x += velocidade;
    }
  }
}
