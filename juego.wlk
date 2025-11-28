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

  var property vidasDeQuirrel = 4  
  var property direccionActual = derecha
  var property estado = normal  
  var property position = game.center()
  


    
  method image(){
    return "quirrel-"+ estado+"-"+direccionActual+".png"
  }

  method nivelActual(nuevoNivel){
    return nuevoNivel
  }

// ------------QUIRREL ATACANDO---------------

  method enemigosCercanos(nivel){  // DEVUELVE UNA LISTA DE LOS ENEMIGOS CERCANOS HACIA LA DIRECCION EN LA QUE ESTA
    return self.nivelActual(nivel).enemigos().filter{ enemigo =>  direccionActual.puedeAtacarA(enemigo) }//
  }

  method validarSiHayAmigosCercanos(nivel){ // si ni hay un enemigo cerca lanza un error
     if (self.enemigosCercanos(nivel).isEmpty()) {
          self.error("No hay enemigos cercanos ")        
    }   
  }

  method atacarAEnemigos(nivel) {
    estado = atacando
    self.moverseAlAtacar()
    game.sound("desenvaina.wav").play()
    estado.atacarAEnemigos(nivel, direccionActual) // deriba la accion de atacat al estado
    game.schedule(500, {estado = normal })
    
  }
    /*self.validarSiHayAmigosCercanos(nivel)
    self.enemigosCercanos(nivel).forEach{ enemigo => self.atacarEnemigo(enemigo, self.nivelActual(nivel)) }
    game.schedule(500, { => estado = normal })*/
  
 method moverseAlAtacar(){
  if (position == game.center())
    position = direccionActual.moverse(position)
    game.schedule(500, { position = game.center()})
 }

 /* method atacarEnemigo(enemigo, nivel){
    estado = atacando
    position = direccionActual.moverse(position)
    enemigo.serAtacado(nivel) 
    game.schedule(500, { position = game.center() }) 
  }*/



//-------------QUIRREL RECIBIR DAÑO

  method puedeRecibirDanio(){ 
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
    game.schedule(1000, { => estado = normal })
  }

  method mirarHaciaDireccion(direccion) {
    direccionActual = direccion
  }

}
