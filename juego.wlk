import niveles.*
import wollok.game.*
import classProyectiles.*
import classEnemigos.*
import direccionesQuirrel.*
import direccionesEnemigos.*
import estadosQuirrel.*
import BarraDeVida.*
import mapa.*


object quirrel {
  var property puntitos = 0  
  var property vidasDeQuirrel = 4  
  var property direccionActual = dirUp
  var property estado = normal  
  var property mapa = primerNivel
  var property position = game.center()

  method sumarPuntaje(puntaje) { 
    puntitos += puntaje 
  }
    
  method image(){
    direccionActual.estadoPersonaje(estado)
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
    self.sumarPuntaje(enemigo.puntos()) // SE COMENTA PARA PASAR ESTO A NIVEL
    game.schedule(500, { position = game.center() }) 
  }


//-------------QUIRREL RECIBIR DAÑO

  method puedeRecibirDanio(){ // indica si el estado actual de quirrel puede recibir algun daño
    return estado.puedeRecibirDanio()
  }

  method recibirDanio(danioRecibido) {
    vidasDeQuirrel -= danioRecibido
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

