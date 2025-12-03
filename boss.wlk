import classEnemigos.*
import classProyectiles.*
import wollok.game.*
import niveles.*
import direccionesEnemigos.*

  
 
object jefeFinal inherits Enemigo {

  var property vidas = 5
  var property image = "boss.gif"
  override method image(){return image}
  method random(){return (1..100).anyOne() }

  // Aparición del jefe en una posición aleatoria
  override method spawnear(nivel) {
    if (!game.hasVisual(self)) {
      self.aparecer(nivel)
    }
  }

  method aparecer(nivel) {
    game.addVisual(self)
    nivel.agregarEnemigo(self) //se agrega al nivel
    game.schedule(4000, {self.actuar(nivel)}) // Decide acción: invocar o moverse
  }

  method actuar(nivel){
    self.rodear(nivel)
    self.atacarAQuirrel(nivel)
  }

  method atacarAQuirrel(nivel){
    const random = self.random()
    if (random < 40 ) { 
      self.tirarEnemigo(nivel, new Araña(elegido = self.elegido()))
    } else if (random <=80) {
      self.tirarEnemigo(nivel, new Cuchillo(elegido = self.elegido()))
    }
    else {
      self.ataqueDirecto(nivel)
    }
  }

  // Cuando Quirrel lo ataca
  override method serAtacado(nivel) {
    game.removeTickEvent("mover enemigo")
    vidas -= 1
    if (vidas <= 0) {
      self.morir(nivel)
    } else {
      self.rodear(nivel)
    }
  }
  
  method morir(nivel) {
    game.say(self, "BIEN BIEN... TU GANAS")
    game.schedule(2000, { game.stop() })
  }
  
  // Cuando el jefe ataca a Quirrel
  override method atacar(protagonista) {
    protagonista.recibirDanio(1)
    if (protagonista.vidasDeQuirrel() <= 0) {
      game.say(protagonista, "Quirrel pierde")
      game.schedule(2000, { game.stop() })
    }
    game.removeTickEvent("mover enemigo")
  }

  //bases del movimiento
  method rodear(nivel){
    elegido = posiciones.anyOne()
    position = elegido.position()
    game.schedule(2000, { self.actuar(nivel) })
  }

  method tirarEnemigo(nivel, enemigo){
    const nuevoEnemigo = enemigo
    nuevoEnemigo.spawnear(nivel)
  }

  override method lentitud(){ return 1500 }

  //al hacer un ataque directo se mueve hacia quirrel
  method ataqueDirecto(nivel){
    self.moverHaciaQuirrel()
  } 
}




object nivel3 inherits Nivel {

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
 
  override method spawnear() {
    game.schedule(5000, { jefe.spawnear(self) })
    // No usamos spawns automáticos en el nivel final
  }

  override method puntajeRequerido(){}
}