import wollok.game.*
import classProyectiles.*
import classEnemigos.*
import direccionesQuirrel.*
import direccionesEnemigos.*
import estadosQuirrel.*
import BarraDeVida.*
import mapa.*
import juego.*


class Nivel {
  var property enemigos = []
  var property proyectiles = []
  var property puntajeActual = 0
  var property completado = false
  const marcadorDePuntos = marcadorPuntos
  const personaje = quirrel
  const fondo
  method puntajeRequerido()
  // method fondo()
 

  //-------------------------------------------------------------------------

  const property spawns = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}

  method agregarEnemigo(enemigo){
      enemigos.add(enemigo)
  }
  method sacarEnemigo(enemigo){
      enemigos.remove(enemigo)
  }
  method agregarProyectil(proyectil){
      proyectiles.add(proyectil)
  }
  method sacarProyectil(proyectil){
      proyectiles.remove(proyectil)
  }
  //-------------------------------------------------------------------------



  method cinematicaInicio() {
    game.clear()
    game.boardGround(fondo)
    game.addVisual(personaje)
    // game.say(quirrel, "¡Hola! Soy Quirrel, el valiente aventurero.")
    // game.schedule(3000, { game.say(quirrel, "Debo enfrentarme a los enemigos que se aproximan.") })
    // game.schedule(6000, { game.say(quirrel, "Usa las flechas para moverme x para cubrirme, y c para atacar.") })
    // game.schedule(8000, { game.say(quirrel, "¡Buena suerte!") })
    game.schedule(1000, { self.iniciar() })
  }

  method iniciar() {
    personaje.nivelActual(self) 
    marcadorDePuntos.nivelActual(self)

    game.addVisual(mascaraDeVida)
    game.addVisual(marcadorPuntos)
    game.addVisual(marcadorVidas)
    self.configurarControles()
    self.configurarSpawns()
    self.configurarColisiones()
  }

  method configurarControles() {
    keyboard.right().onPressDo{ personaje.mirarHaciaDireccion(derecha) }
    keyboard.left().onPressDo{ personaje.mirarHaciaDireccion(izquierda) }
    keyboard.up().onPressDo{ personaje.mirarHaciaDireccion(arriba) }
    keyboard.down().onPressDo{ personaje.mirarHaciaDireccion(abajo) }
    keyboard.x().onPressDo{ personaje.atacarAEnemigos(self) }
    keyboard.c().onPressDo{ personaje.bloquear() }
  }

  method configurarSpawns() {
    game.onTick(4000, "spawnear enemigo", {const nuevoEnemigo = new Enemigo();nuevoEnemigo.nivelActual(self) ; nuevoEnemigo.spawnear(self)})
    game.onTick(10000, "spawnear proyectil",{const nuevoProyectil = new Proyectil(); nuevoProyectil.nivelActual(self); nuevoProyectil.spawnear(self)})
  }

  method configurarColisiones() {
    game.onCollideDo(personaje, { cosa => cosa.atacar(personaje) })  
  }

   
  method sumarPuntos(punto) {
    puntajeActual += punto
    self.verificarSiCompletoLospuntos()
  }

  method verificarSiCompletoLospuntos(){
    if(puntajeActual >= self.puntajeRequerido()){
      completado = true
      }
  }

  method estaCompletado() {
    return completado
  }
  
}


// no logro que la imagen de fondo cambie de un nivel a otro, intente de las dos maneras que estan, pero solo se queda con la primera.
object nivel1 inherits Nivel (fondo = "fondo.jpg"){//

  // override method fondo(){
  //   return "fondo.jpg"
  // }
    override method puntajeRequerido(){
        return 500
    }
}

object nivel2 inherits Nivel (fondo = "loco.jpg"){//

  //   override method fondo(){
  //   return "loco.jpg"
  // }
    override method puntajeRequerido(){
        return 1000
    }
}


object juego {
  var property niveles = [nivel1, nivel2]
  var property nivelActual = 0


  method iniciarNivelActual() {
    niveles.get(nivelActual).cinematicaInicio()
    game.onTick(1000, "verificar progreso", { self.verificarProgreso() })
  }
  method verificarProgreso() {
    if (self.juegoTermino()) {
      game.say(self, "¡Juego completado!")
      game.schedule(1000, {game.stop()})
      game.stop()
    } else if (self.nivelCompletado()) {
      game.schedule(1000, { self.avanzarNivel() })
    }
  }

  method juegoTermino() {
    return nivelActual >= niveles.size()
  }

  method nivelCompletado() {
    return niveles.get(nivelActual).estaCompletado()
  }

  method avanzarNivel() {
    nivelActual = nivelActual + 1
    if (nivelActual < niveles.size()) {
      self.iniciarNivelActual()
    }
  }
 
}



object marcadorPuntos {
  var property position = game.at(3,12)
  var property nivelActual = null // me  obliga a darle un valor, si elimino esto y dejo solo el metodo los puntos no se muestran en pantalla

  method nivelActual(_nivel) {
    nivelActual =  _nivel
  }
  method text() {
    return "Puntos: " + nivelActual.puntajeActual()
  }
}



object marcadorVidas {
  var property position = game.at(1,12)
  var property personaje = quirrel

  method text() {
    return "Vidas: " + personaje.vidasDeQuirrel()
  }
}










// object juego {
  
//   method cinematicaInicio() {
//     game.boardGround("fondo.jpg")
//     game.addVisual(quirrel)
//     game.say(quirrel, "¡Hola! Soy Quirrel, el valiente aventurero.")
//    /* game.schedule(3000, { game.say(quirrel, "Debo enfrentarme a los enemigos que se aproximan.") })
//     game.schedule(6000, { game.say(quirrel, "Usa las flechas para moverme x para cubrirme, y c para atacar.") })
//     game.schedule(9000, { game.say(quirrel, "¡Buena suerte!") })*/
//     game.schedule(1000, { niveles.iniciar() })
//   }

//   // method iniciar() {
//   //   game.addVisual(mascaraDeVida)
//   //   game.boardGround("fondo2.jpg")

//   //   keyboard.right().onPressDo{ quirrel.mirarHaciaDireccion(dirRight) }
//   //   keyboard.left().onPressDo{ quirrel.mirarHaciaDireccion(dirLeft) }
//   //   keyboard.up().onPressDo{ quirrel.mirarHaciaDireccion(dirUp) }
//   //   keyboard.down().onPressDo{ quirrel.mirarHaciaDireccion(dirDown) }
//   //   keyboard.x().onPressDo{ quirrel.atacarAEnemigos() }
//   //   keyboard.c().onPressDo{ quirrel.bloquear() }

//   //   game.onTick(4000, "spawnear enemigo", { const nuevoEnemigo = new Enemigo(); nuevoEnemigo.spawnear(); })
//   //   game.onTick(10000, "spawnear proyectil", { const nuevoProyectil = new Proyectil(); nuevoProyectil.spawnear() })
//   //   game.onCollideDo(quirrel, { cosa => cosa.atacar(quirrel) }) 
//   // }
// }