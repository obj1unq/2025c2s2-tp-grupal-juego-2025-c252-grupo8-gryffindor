import classEnemigos.*
import classProyectiles.*
import wollok.game.*
import niveles.*
import direccionesEnemigos.*



object jefeFinal inherits Enemigo {
  var property vidas = 5
  // var property visible = false
  override method image(){ return "mascaraDeVida0.png"}
  

  // Aparición del jefe en una posición aleatoria
  override method spawnear(nivel) {
    if (!game.hasVisual(self)) {
      self.aparecer(nivel)
    }
  }

  method aparecer(nivel) {
    // position = posiciones.anyOne().position() // self.position()///aparece en un aposicion cualquieraelegido.position()/
    // visible = true
    game.addVisual(self)
    nivel.agregarEnemigo(self) //se agrega al nivel
    self.atacarAQuirrel(nivel) // Decide acción: invocar o moverse
  }

  method atacarAQuirrel(nivel){
    if (#{true, false}.anyOne()) {//elige entre invocar oleada o moverse 
      self.invocarOleada(nivel)
    } else {
      self.moverHaciaQuirrel() //llama a un metodo heredado
    }
  }

  method desaparecer(nivel) {
    // visible = false
    game.removeVisual(self)
    nivel.sacarEnemigo(self)
  }

  // Invoca entre 2 y 3 enemigos comunes, uno detrás de otro
  method invocarOleada(nivel) {
    const tiempos = [1000, 2000]   // dos enemigos, en momentos fijos
    tiempos.forEach { t => game.schedule(t, { self.invocarEnemigo(nivel) })}
    game.schedule(3000, { self.reaparecer(nivel) })
}

  method invocarEnemigo(nivel) {
    const invocado = #{ new Enemigo(), new Proyectil(), new Cuchillo() }.anyOne()
    invocado.position(self.position()) invocado.spawnear(nivel) 
    nivel.agregarEnemigo(invocado)
    game.addVisual(invocado)
  }

  method reaparecer(nivel) {
    self.desaparecer(nivel)
    if (vidas > 0) {
      self.aparecer(nivel)
    }
  }
  
  // Cuando Quirrel lo ataca
  override method serAtacado(nivel) {
    vidas -= 1
    if (vidas <= 0) {
      self.morir(nivel)
    } else {
      self.reaparecer(nivel)
    }
  }
  
  method morir(nivel) {
    self.desaparecer(nivel)
    game.say(self, "¡Quirrel gana!")
    game.schedule(2000, { game.stop() })
  }
  
  // Cuando el jefe ataca a Quirrel
  override method atacar(protagonista) {
    protagonista.recibirDanio(1)
    if (protagonista.vidasDeQuirrel() <= 0) {
      game.say(protagonista, "Quirrel pierde")
      game.schedule(2000, { game.stop() })
    }
  }
  

}




object nivelFinal inherits Nivel {

var property jefe = jefeFinal

  // En este nivel no se suman puntos, la condición es derrotar al jefe
override method sumarPuntos(cantidad) {
  self.verificarSiCompletoLospuntos()

}

override method verificarSiCompletoLospuntos() {
  if (jefe.vidas() <= 0) {
    completado = true
  }
}

  override method fondoNivel(){
    return "fondo.jpg"
  }

  override method puntajeRequerido(){}
  

  
  override method configurarSpawns() {
    game.schedule(5000, { jefe.spawnear(self) })
    // No usamos spawns automáticos en el nivel final
  }
  

}


