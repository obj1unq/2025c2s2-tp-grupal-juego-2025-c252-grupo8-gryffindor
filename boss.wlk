import classEnemigos.*
import classProyectiles.*
import wollok.game.*
import niveles.*
import direccionesEnemigos.*



object jefeFinal inherits Enemigo {
  var property vidas = 5

  // var property visible = false
  var property image = "boss.gif"
  override method image(){ return image}
  
  method random(){ return (1..100).anyOne() }

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
    game.schedule(4000, {self.actuar(nivel)}) // Decide acción: invocar o moverse
  }

  method actuar(nivel){
    self.rodear(nivel)
    self.atacarAQuirrel(nivel)
  }

  method atacarAQuirrel(nivel){
    const random = self.random()
    if (random < 40 ) { 
      self.crearAraña(nivel)
    } else if (random <=80) {
      self.tirarCuchillo(nivel) 
    }
    else {
        self.ataqueDirecto(nivel)
    }
  }

  

  /* Invoca entre 2 y 3 enemigos comunes, uno detrás de otro
  method invocarOleada(nivel) {
    const tiempos = [1000, 2000, 3000]   // dos enemigos, en momentos fijos
     tiempos.forEach{ tiempo =>
      game.schedule(tiempo, { self.spawnearEnemigo(nivel) })
    }
  }


method spawnearEnemigo(nivel){
   const invocado = 
   invocado.spawnear(nivel)
   nivel.agregarEnemigo(invocado)
   game.addVisual(invocado)
  }

method reaparecer(nivel) {
  
    if (vidas > 0) {
      self.aparecer(nivel)
    }
  }
  */

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

  //bases de spawneo de enemigos y proyectiles
   method tirarCuchillo(nivel){
    const nuevoCuchillo = new Cuchillo(elegido = self.elegido())
    nuevoCuchillo.spawnear(nivel)
    game.schedule(4000, { self.actuar(nivel) })
  }

  method crearAraña(nivel){
    const nuevaAraña = new Araña(elegido = self.elegido())
    nuevaAraña.spawnear(nivel)
    game.schedule(5000, { self.actuar(nivel) })
  }

  //basesde ataque

override method lentitud(){ return 1500 }

  method ataqueDirecto(nivel){
    //al hace un ataque directo se mueve hacia quirrel
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

 
  override method puntajeRequerido(){}
  

  
  override method configurarSpawns() {
    game.schedule(5000, { jefe.spawnear(self) })
    // No usamos spawns automáticos en el nivel final
  }



}