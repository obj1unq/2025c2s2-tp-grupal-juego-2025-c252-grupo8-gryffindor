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
  var property personaje = quirrel
  method puntajeRequerido()
  const fondo

  method cinematicaInicio() {
    game.boardGround(fondo)
    game.addVisual(quirrel)
    game.say(quirrel, "¡Hola! Soy Quirrel, el valiente aventurero.")
    game.schedule(3000, { game.say(quirrel, "Debo enfrentarme a los enemigos que se aproximan.") })
    game.schedule(6000, { game.say(quirrel, "Usa las flechas para moverme x para cubrirme, y c para atacar.") })
    game.schedule(9000, { game.say(quirrel, "¡Buena suerte!") })
    game.schedule(1000, { self.iniciar() })
  }

  method iniciar() {
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
    keyboard.x().onPressDo{ personaje.atacarAEnemigos() }
    keyboard.c().onPressDo{ personaje.bloquear() }
  }

  method configurarSpawns() {
    game.onTick(4000, "spawnear enemigo", {
      const nuevoEnemigo = new Enemigo()
      nuevoEnemigo.onMorirDo{ self.sumarPuntos(10) }
      nuevoEnemigo.spawnear()
    })

    game.onTick(10000, "spawnear proyectil", {
      const nuevoProyectil = new Proyectil()
      nuevoProyectil.spawnear()
    })
  }

  method configurarColisiones() {
    game.onCollideDo(quirrel, { cosa =>if (cosa.esEnemigo()) {cosa.atacar(personaje) }}) 
    }

  method sumarPuntos(puntos) {
    puntajeActual = puntajeActual + puntos 
    self.verificarSiCompletoLospuntos()
  }

  method verificarSiCompletoLospuntos(){
    if(puntajeActual >= self.puntajeRequerido()){completado = true}
  }

  method estaCompletado() {
    return completado
  }
}



object nivel1 inherits Nivel(fondo = "fondo.jpg") {
    override method puntajeRequerido(){
        return 50
    }
}

object nivel2 inherits Nivel (fondo = "fond2.jpg"){
    override method puntajeRequerido(){
        return 100
    }
}

object juego {
  var property niveles = [nivel1, nivel2]
  var property nivelActual = 0

  method iniciarNivelActual() {
    //  niveles.iniciar()
    niveles.get(nivelActual).cinematicaInicio()
  }

  method verificarProgreso() {
    if (niveles.get(nivelActual).estaCompletado()) {
      nivelActual = nivelActual + 1
      self.iniciarNivelActual()
    }
  }
}





object marcadorPuntos {
  var property position = game.at(3,12)
  var property personaje = quirrel

  method text() {
    return "Puntos:" + personaje.puntitos()
  }
  method color() {
    return "white"
  }
    method tamaño() {
        return 22  
    }
}

object marcadorVidas {
  var property position = game.at(1,12)
  var property personaje = quirrel
 

  method text() {
    return "Vidas:" + personaje.vidasDeQuirrel()
  }

  method color() {
    return "white"
  }
    method tamaño() {
        return 22  
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