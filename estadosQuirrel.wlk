import wollok.game.*
import classProyectiles.*
import juego.quirrel.*
import direccionesEnemigos.*
import direccionesQuirrel.*

class EstadoQuirrel {
method puedeAtacar(){
    return true}

method puedeRecibirDanio(){
    return true}

}



object atacando inherits EstadoQuirrel {

    method enemigosCercanos(mapa,dirección){  // devuelve una lista con los enemigos cercanos que vienen en la direccion actual.
    return mapa.enemigos().filter{ enemigo =>  dirección.puedeAtacarA(enemigo) }//
  }
  method validarSiHayAmigosCercanos(mapa, dirección){
     if (self.enemigosCercanos(mapa, dirección).isEmpty()) {
      self.error("No hay enemigos cercanos ")        
    }   
  }
   method atacarAEnemigos(mapa, dirección) {
    self.validarSiHayAmigosCercanos(mapa, dirección)
    self.enemigosCercanos(mapa, dirección).forEach{ enemigo => self.atacarEnemigo(enemigo)}//agregar aca que despues de atacar al enemigo se sumeel puntaje al mapa
   }

   method atacarEnemigo(enemigo){
    enemigo.serAtacado()
   }
  
  }



object cubriendo inherits EstadoQuirrel {
   override method puedeAtacar(){
        return false }
    override method puedeRecibirDanio(){
        return false
    }
}

object normal inherits EstadoQuirrel {
    override method puedeAtacar(){
        return false
    }
   
}