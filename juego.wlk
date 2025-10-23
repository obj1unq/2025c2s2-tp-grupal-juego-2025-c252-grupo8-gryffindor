import wollok.game.*
import clases.*
import direccionesQuirrel.*
import direccionesEnemigos.*
import estadosQuirrel.*



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
    game.boardGround("fondo2.jpg")
    keyboard.right().onPressDo{ quirrel.mirarHaciaDireccion(dirRight) }
    keyboard.left().onPressDo{ quirrel.mirarHaciaDireccion(dirLeft) }
    keyboard.up().onPressDo{ quirrel.mirarHaciaDireccion(dirUp) }
    keyboard.down().onPressDo{ quirrel.mirarHaciaDireccion(dirDown) }
    keyboard.a().onPressDo{ quirrel.atacarAEnemigo() }
    keyboard.c().onPressDo{ quirrel.bloquear() }
    game.onTick(4000, "spawnear enemigo", { const nuevoEnemigo = new Enemigo(); nuevoEnemigo.spawnear(); quirrel.agregarEnemigo(nuevoEnemigo) })
    game.onTick(10000, "spawnear proyectil", { const nuevoProyectil = new Proyectil(); nuevoProyectil.spawnear() })
    game.onCollideDo(quirrel, { cosa => cosa.atacar(quirrel) }) 
  }
}

object quirrel {
  var puntitos = 0  
  var vidasDeQuirrel = 4  
  var property direccionActual = dirUp
  var property estado = normal  
  const property listaDeEnemigos = [] 


  method sumarPuntaje(puntaje) { 
    puntitos += puntaje 
  }
    
  method image(){
    return direccionActual.image()
  }

  method position(){
    return direccionActual.position()
  }

method agregarEnemigo(cualquiera){
  listaDeEnemigos.add(cualquiera)
}


// ------------QUIRREL ATACANDO---------------
  method atacarAEnemigo() {
   self.validarSiHayAmigosCercanos()
    estado = atacando
    self.enemigosCercanos().forEach{ enemigo => direccionActual.atacar(enemigo) }
    game.schedule(2000, { => estado = normal })
  }

  method validarSiHayAmigosCercanos(){
     if (self.enemigosCercanos().isEmpty()) {
      self.error("No hay enemigos cercanos ")        
    }   
  }

  method enemigosCercanos(){  // devuelve una lista con los enemigos cercanos que vienen en la direccion actual.
    return listaDeEnemigos.filter{ enemigo =>  direccionActual.puedeAtacarA(enemigo) }//
  }



  method puedeRecibirDanio(){ // indica si el estado actual de quirrel puede recibir algun daño
    return estado.puedeRecibirDanio()
  }

//-------------QUIRREL RECIBIR DAÑO

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
    game.schedule(2000, { => estado = normal })
  }

//------------ATACAR AL ENEMIGO EN DIRECCION------------


  method mirarHaciaDireccion(direccion) {
    direccionActual = direccion
  }

  method enemigoEliminado(){
    game.say(self, "fuiste eliminado")
    self.sumarPuntaje(100)
  }

}

