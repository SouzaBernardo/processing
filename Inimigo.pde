class Inimigo {
  PVector posicao;
  PVector velocidade;
  color cor;
  float radius, m;
  Jogador jogador;
  boolean desativo;
  
  
  Inimigo(float r_) {
    posicao = new PVector(random(radius, width - radius), random(radius, height - radius));
    velocidade = PVector.random2D();
    velocidade.mult(3);
    radius = r_;
    m = radius*.1;
    cor = color(255, 0, 0);   
    desativo = false;
}

  void atualizar() {
    posicao.add(velocidade);
    if (desativo) {
      posicao = new PVector(random(radius, width - radius), random(radius, height - radius));

      desativo = false;
    }
  }

  void colisaoBordas() {
    if (posicao.x > width-radius) {
      posicao.x = width-radius;
      velocidade.x *= -1;
      trocaCor();
    } else if (posicao.x < radius) {
      posicao.x = radius;
      velocidade.x *= -1;
      trocaCor();  
  } else if (posicao.y > height-radius) {
      posicao.y = height-radius;
      velocidade.y *= -1;
      trocaCor();
  } else if (posicao.y < radius) {
      posicao.y = radius;
      velocidade.y *= -1;
      trocaCor();
    }
  }

  void trocaCor() {
    if (cor == color(255, 0, 0)) {  
        cor = color(0, 0, 255);  
    } else if (cor == color(0, 0, 255)) {  
        cor = color(255, 0, 0);  
    }
  }
  
  void colisaoJogador(Jogador jogador){
   if (cor == color(255, 0, 0)) {
      jogador.receberDano(50);
        
    } else if (cor == color(0, 0, 255)) {
      game.adicionarPonto();
    }
  }

  void colisaoInimigo(Inimigo outroInimigo) {
    if(desativo) return;
    PVector distanceVect = PVector.sub(outroInimigo.posicao, posicao);

    float distanceVectMag = distanceVect.mag();
    float minDistance = radius + outroInimigo.radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      outroInimigo.posicao.add(correctionVector);
      posicao.sub(correctionVector);

      float theta  = distanceVect.heading();
      float sine = sin(theta);
      float cosine = cos(theta);

      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocidade.x + sine * velocidade.y;
      vTemp[0].y  = cosine * velocidade.y - sine * velocidade.x;
      vTemp[1].x  = cosine * outroInimigo.velocidade.x + sine * outroInimigo.velocidade.y;
      vTemp[1].y  = cosine * outroInimigo.velocidade.y - sine * outroInimigo.velocidade.x;

      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      vFinal[0].x = ((m - outroInimigo.m) * vTemp[0].x + 2 * outroInimigo.m * vTemp[1].x) / (m + outroInimigo.m);
      vFinal[0].y = vTemp[0].y;

      vFinal[1].x = ((outroInimigo.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + outroInimigo.m);
      vFinal[1].y = vTemp[1].y;

      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      outroInimigo.posicao.x = posicao.x + bFinal[1].x;
      outroInimigo.posicao.y = posicao.y + bFinal[1].y;

      posicao.add(bFinal[0]);

      velocidade.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocidade.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      outroInimigo.velocidade.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      outroInimigo.velocidade.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      cor = color(0, 0, 255); 
    } 
  }
  
  void colisaoInimigo(Jogador jogador) {
    if(desativo) return;

    PVector jogadorCentro = new PVector(jogador.x + jogador.largura / 2, jogador.y + jogador.altura / 2);
    PVector inimigoCentro = new PVector(this.posicao.x, this.posicao.y);

    PVector distanceVect = PVector.sub(inimigoCentro, jogadorCentro);
    float distanceVectMag = distanceVect.mag();
    float minDistance = this.radius + min(jogador.largura, jogador.altura) / 2.0;

    if (distanceVectMag < minDistance) {
        float distanceCorrection = (minDistance - distanceVectMag) / 2.0;
        PVector correctionVector = distanceVect.copy().normalize().mult(distanceCorrection);
        
        jogador.x -= correctionVector.x;
        jogador.y -= correctionVector.y;
        this.posicao.add(correctionVector);

        this.velocidade.x = -this.velocidade.x;
        this.velocidade.y = -this.velocidade.y;
        colisaoJogador(jogador);
        desativo = true;
    }
}


  void mostrar() {
    fill(cor);
    noStroke();
    ellipse(posicao.x, posicao.y, radius*2, radius*2);
  }
}
