import wollok.game.*
import enemigo.*

object quirrel {

  var property imagen = "quirrel.png"
  var property position = game.center()
  var vidasDeQuirrel = 1
  var puntitos = 0
  var  direccionActual = dirUp // esta variable guarda la ultima direccion hacia la que miraba  quirrel

  method image() { return imagen}
  method position() { return position}
  method sumarPuntaje(puntaje) {puntitos += puntaje}

///------------------ELIMINAR ENEMIGO OK-------------------///

    method recibirDanio(danioRecibido) { // Se utiliza en la colision de enemigo con Quirrel.
      vidasDeQuirrel -= danioRecibido
      if (vidasDeQuirrel == 0){
        game.say(self, "Me quede sin vidas")        // los game.say() no se estan ejecutando correctamente
        game.schedule(2000, { game.stop() })        // el programa si se detiene cuando quirrel se queda sin vida.
      }
    }

  method mirarHaciaDireccion(direccion) {
    direccionActual = direccion
    imagen = direccion.image()
  }

  method atacarAEnemigo(enemigo) {
    if(game.hasVisual(enemigo)){                      //Le agregue esto para que solo ataque si la imagen visual esta en el tablero
      direccionActual.atacar(enemigo)                 // delegue la accion de atacar a la direccion, ya que este evalua si el enemigo se encuentra dentro de su margen de ataque..
    } 
  }

  method atacarEnemigoEnDireccion(enemigo, direccion){// si el enemigo esta dentro del margen  de ataque de la direccion actual hacia la que mira quirrel se ejecuta este metodo
    if(game.hasVisual(enemigo)){  
    position = direccion.dir()                        // hace que quirrel se desplace una celda hacia la direccion actual para atacar al enemigo 
    enemigo.serAtacado()
    game.say(self, "fuiste eliminado")                // no se ejecuta correctamente
    self.sumarPuntaje(100)
    game.schedule(500, {position = game.center() })   // esto hace que quirrel vuelva a su posicion luego de eliminar al enemigo
    }
  }

}



///------------------DIRECCIONES Quirrel-------------------///
 object dirUp {
   var property imagen = "quirrel-arriba.png"
   var property position = game.center()
   const property enemigos = #{enemigo}
   var property personaje = quirrel

   method image() {return imagen }
   method position(){return position}

  method puedeAtacarA(enemigo){
    return  enemigo.position().y().between(self.position().y()+1, self.position().y()+2)
  }

  method dir(){
    return position.up(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección")  // Este else no se esta ejecutando correctamente
    }
  }
    
 }



object dirDown {

  var property imagen = "quirrel-abajo.png"
  var property position = game.center()
  var property personaje = quirrel

  method image() {return imagen }
  method position(){return position}

  method puedeAtacarA(enemigo) {
      return enemigo.position().y().between(self.position().y() - 2, self.position().y() - 1)
  }

  method dir(){
    return position.down(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección") 
    }
  }
}


object dirLeft {
  var property imagen = "quirrel-izquierda.png"
  var property position = game.center()
  var property personaje = quirrel

  method image() {return imagen }
  method position(){return position}

  method puedeAtacarA(enemigo){
    return enemigo.position().x().between(self.position().x()-2, self.position().x()-1)
  }

  method dir(){
    return position.left(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección") 
    }
  }
}



object dirRight {
  var property imagen = "quirrel-derecha.png"
  var property position = game.center()
  var property personaje = quirrel

  method image() {return imagen }
  method position(){return position}

  method puedeAtacarA(enemigo){
    return  enemigo.position().x().between(self.position().x()+1, self.position().x()+2)
  }

  method dir(){
    return position.right(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección") 
    }
  }
}






 



 /*
  object quirrel {
   var property imagen = "quirrel.png"
   var property position = game.center()
   var property rival = enemigo
   var vidasDeQuirrel = 1
   var puntitos = 0
   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method atacarDireccion(direccion) {
     imagen = direccion.image()
    direccion.puedeAtacarA(enemigo)
    direccion.enemigos().forEach({enemigo => enemigo.serAtacado()})
   }

  
   
   method sumarPuntaje(puntaje) {
     puntitos = puntitos+puntaje
   }


 

///------------------ELIMINAR ENEMIGO PRUEBA-------------------///
    method eliminarEnemigo(direccion) {
      if (position == direccion.position()){// Esta condicion no funciona, ya que el enemigo no debe estar en la misma posicion que quirrel para ser eliminado.
          imagen = "transparente.png"
      } 
    }

    method recibirDanio(danioRecibido) { // Se puede utilizar en una colision
      vidasDeQuirrel -= danioRecibido
      if (vidasDeQuirrel == 0){
        imagen = "quirrel-muerto.png" //
        game.schedule(2000, {game.stop() })
      }
    }

 }





///------------------DIRECCIONES Quirrel-------------------///
 object dirUp {
   var property imagen = "quirrel-arriba.png"
   var property position = game.center()
   const property enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method puedeAtacarA(enemigo){
        return  enemigo.position().y().between(self.position().y()+1, self.position().y()+2)
    }

    method filtrarEnemigos() {
      return enemigos.filter{enemigo => self.puedeAtacarA(enemigo)}
    }


 }

  object dirDown {
   var property imagen = "quirrel-abajo.png"
   var property position = game.center()
   const property enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }
    method puedeAtacarA(enemigo){
        return  enemigo.position().y().between(self.position().y()-1, self.position().y()-2)
    }
     method filtrarEnemigos() {
      return enemigos.filter{enemigo => self.puedeAtacarA(enemigo)}
    }


   }
 

  object dirLeft {
   var property imagen = "quirrel-izquierda.png"
   var property position = game.center()
   const property enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

    method puedeAtacarA(enemigo){
        return  enemigo.position().x().between(self.position().x()-1, self.position().x()-2)
    }
  method filtrarEnemigos() {
      return enemigos.filter{enemigo => self.puedeAtacarA(enemigo)}
    }

 }

  object dirRight {
   var property imagen = "quirrel-derecha.png"
   var property position = game.center()
   const property enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

    method puedeAtacarA(enemigo){
        return  enemigo.position().x().between(self.position().x()+1, self.position().x()+2)
    }
method filtrarEnemigos() {
      return enemigos.filter{enemigo => self.puedeAtacarA(enemigo)}
    }
 }*/








