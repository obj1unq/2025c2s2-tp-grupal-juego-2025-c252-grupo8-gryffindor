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
  var property direccionActual = derecha
  var property estado = normal  
  var property mapa = primerNivel
  var property position = game.center()

  method sumarPuntaje(puntaje) { 
    puntitos += puntaje 
  }
    
  method image(){return "quirrel-"+ estado+"-"+direccionActual+".png"
  }


// ------------QUIRREL ATACANDO---------------


 method atacarAEnemigos(){
    estado = atacando
    self.moverseAlAtacar()
    estado.atacarAEnemigos(mapa, direccionActual)
    game.schedule(500, { position = game.center()})
    estado = normal
  }
 method moverseAlAtacar(){
  if (position == game.center())
    position = direccionActual.moverse(position)
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

