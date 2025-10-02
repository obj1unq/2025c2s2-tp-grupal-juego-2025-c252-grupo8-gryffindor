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
        method atacarAEnemigos(nivel, dirección) {
    self.validarSiHayAmigosCercanos(nivel, dirección)
    self.enemigosCercanos(nivel, dirección).forEach{ enemigo => self.atacarEnemigo(enemigo, nivel)}//agregar aca que despues de atacar al enemigo se sumeel puntaje al mapa
   }
     
       method validarSiHayAmigosCercanos(nivel, dirección){
     if (self.enemigosCercanos(nivel, dirección).isEmpty()) {
      self.error("No hay enemigos cercanos ")        
    }   
  }
      method enemigosCercanos(nivel,dirección){  // devuelve una lista con los enemigos cercanos que vienen en la direccion actual.
    return nivel.enemigos().filter{ enemigo =>  dirección.puedeAtacarA(enemigo) }//
  }

   method atacarEnemigo(enemigo, nivel){
    enemigo.serAtacado(nivel)
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