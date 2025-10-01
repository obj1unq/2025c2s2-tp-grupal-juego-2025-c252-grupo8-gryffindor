import wollok.game.*
import enemigo.*
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
 }
 

///------------------DIRECCIONES Enemigo-------------------///

 object enemigo {
   var property imagen = "quirrel-muerto.png"
   var property position =game.origin()
   var property posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
   var property elegido = posiciones.anyOne()
   method image() {
    return imagen 
   }
   method position(){
    return position
   }
   method serAtacado(){ 
   
        game.removeVisual(self) 
   }
   method moverse(){
     //imagen = "quirell-muerto.png"
    position = elegido.dir(1)
    //return position
   }

   method atacar(protagonista){
    protagonista.recibirDanio(1)

   }


 }



 object dirUpEnemy {
   var property imagen = "img.png"
   var property position = game.at(5, 10)   
   method image() {return imagen }
   method position(){return position}

   method dir(pasos){
     return position.up(pasos)
  }
 }

object dirDownEnemy {
    var property position = game.at(0, 5)   
    var property imagen = "quirrel-muerto.png"
    method image() { return imagen }
    method position() { return position }
      
}
  object dirLeftEnemy {
      var property position = game.at(10, 5)   
      var property imagen = "img.png"
      method image() { return imagen }
      method position() { return position }
        
  }
  object dirRightEnemy {
      var property position = game.at(0, 5)   
      var property imagen = "img.png"
      method image() { return imagen }
      method position() { return position }
        
  }




