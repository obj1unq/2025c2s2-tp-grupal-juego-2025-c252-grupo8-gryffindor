import wollok.game.*
import clases.*
import direccionesQuirrel.*
import direccionesEnemigos.*
import estadosQuirrel.*
import BarraDeVida.*
import mapa.*


object juego {
  
  method cinematicaInicio() {
    game.boardGround("fondo.jpg")
    game.addVisual(quirrel)
    game.say(quirrel, "¡Hola! Soy Quirrel, el valiente aventurero.")
   /* game.schedule(3000, { game.say(quirrel, "Debo enfrentarme a los enemigos que se aproximan.") })
    game.schedule(6000, { game.say(quirrel, "Usa las flechas para moverme x para cubrirme, y c para atacar.") })
    game.schedule(9000, { game.say(quirrel, "¡Buena suerte!") })*/
    game.schedule(1000, { self.iniciar() })
  }

  method iniciar() {
    game.addVisual(mascaraDeVida)
    game.boardGround("fondo2.jpg")
    keyboard.right().onPressDo{ quirrel.mirarHaciaDireccion(dirRight) }
    keyboard.left().onPressDo{ quirrel.mirarHaciaDireccion(dirLeft) }
    keyboard.up().onPressDo{ quirrel.mirarHaciaDireccion(dirUp) }
    keyboard.down().onPressDo{ quirrel.mirarHaciaDireccion(dirDown) }
    keyboard.x().onPressDo{ quirrel.atacarAEnemigos() }
    keyboard.c().onPressDo{ quirrel.bloquear() }
    game.onTick(4000, "spawnear enemigo", { const nuevoEnemigo = new Enemigo(); nuevoEnemigo.spawnear(); })
    game.onTick(10000, "spawnear proyectil", { const nuevoProyectil = new Proyectil(); nuevoProyectil.spawnear() })
    game.onCollideDo(quirrel, { cosa => cosa.atacar(quirrel) }) 
  }
}

object quirrel {
  var puntitos = 0  
  var property vidasDeQuirrel = 4  
  var property direccionActual = dirUp
  var property estado = normal  
  var property mapa = primerNivel
  var property position = game.center()

  method sumarPuntaje(puntaje) { 
    puntitos += puntaje 
  }
    
  method image(){
    direccionActual.estadoActual(estado)
    return direccionActual.image()
  }

  



// ------------QUIRREL ATACANDO---------------

  method enemigosCercanos(){  // devuelve una lista con los enemigos cercanos que vienen en la direccion actual.
    return mapa.enemigos().filter{ enemigo =>  direccionActual.puedeAtacarA(enemigo) }//
  }

  method validarSiHayAmigosCercanos(){
     if (self.enemigosCercanos().isEmpty()) {
      self.error("No hay enemigos cercanos ")        
    }   
  }

  method atacarAEnemigos() {
    self.validarSiHayAmigosCercanos()
    self.enemigosCercanos().forEach{ enemigo => self.atacarEnemigo(enemigo) }
    game.schedule(500, { => estado = normal })
  }


 method atacarEnemigo(enemigo){
    estado = atacando
    position = direccionActual.moverse(position)
    enemigo.serAtacado()
    self.sumarPuntaje(enemigo.puntos())
    game.say(self, "Muere!!, ahora tengo "+ puntitos +" puntos")
    game.schedule(500, { position = game.center() }) 
    
  }






//-------------QUIRREL RECIBIR DAÑO

  method puedeRecibirDanio(){ // indica si el estado actual de quirrel puede recibir algun daño
    return estado.puedeRecibirDanio()
  }

  method recibirDanio(danioRecibido) {
    vidasDeQuirrel -= danioRecibido
    game.say(self, "Me quedan " +vidasDeQuirrel+ " vidas")
    self.controlarVidasDisponibles()
  }

  method controlarVidasDisponibles(){
     if (vidasDeQuirrel <= 0) {
      game.say(self, "Me quede sin vidas")
      game.schedule(2000, { game.stop() })
    }   
  }
//--------------QUIRREL CUBRIRSE-------------------

  method bloquear() {
    estado = cubriendo
    game.schedule(500, { => estado = normal })
  }

//------------ATACAR AL ENEMIGO EN DIRECCION------------


  method mirarHaciaDireccion(direccion) {
    direccionActual = direccion
  }
}

