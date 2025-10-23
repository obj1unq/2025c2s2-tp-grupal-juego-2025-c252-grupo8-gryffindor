import wollok.game.*
import clases.*
import juego.*
import direccionesQuirrel.*
import estadosQuirrel.*

//--------------- DIRECCIONES DE LOS ENEMIGOSENEMIGO---------------------------

object dirUpEnemy {
  var property image = "quirrel-muerto.png"
  var property position = game.at(6, 12)   
  const protagonista = quirrel
  const facing = dirUp

  method moverse(){
    position = position.down(1)
  }

  method puedeBloquearse() {
    return protagonista.direccionActual() == facing and not protagonista.puedeRecibirDanio()
  }
  
  method calcularMovimientoHacia(posActual, target) {
    const diffY = target.y() - posActual.y()
    return if (diffY > 0) posActual.up(1) else posActual // Mueve hacia arriba si Quirrel está más arriba
  }
}

object dirDownEnemy {
  var property position = game.at(6, 0)   
  var property image = "quirrel-muerto.png"
  const protagonista = quirrel
  const facing = dirDown
 
  method puedeBloquearse() {
    return protagonista.direccionActual() == facing and not protagonista.puedeRecibirDanio()
  }

  method moverse(){
    position = position.up(1)
  }

  method calcularMovimientoHacia(posActual, target) {
    const diffY = target.y() - posActual.y()
    return if (diffY < 0) posActual.down(1) else posActual // Mueve hacia abajo si Quirrel está más abajo
  }
}

object dirLeftEnemy {
  var property position = game.at(0, 6)   
  var property image = "quirrel-muerto.png"
  const protagonista = quirrel
  const facing = dirLeft
 
  method moverse(){
    position = position.right(1)
  }
  
  method puedeBloquearse() {
    return protagonista.direccionActual() == facing and not protagonista.puedeRecibirDanio()
  }
  method calcularMovimientoHacia(posActual, target) {
    const diffX = target.x() - posActual.x()
    return if (diffX < 0) posActual.left(1) else posActual // Mueve a la izquierda si Quirrel está a la izquierda
  }
}

object dirRightEnemy {
  var property position = game.at(12, 6)   
  var property image = "quirrel-muerto.png"
  const protagonista = quirrel
  const facing = dirRight

  method moverse(){
    position = position.left(1)
  }

  method puedeBloquearse() {
    return protagonista.direccionActual() == facing and not protagonista.puedeRecibirDanio()
  }

}
 
 
 /* method calcularMovimientoHacia(posActual, target) {
    const diffX = target.x() - posActual.x()
    return if (diffX > 0) posActual.right(1) else posActual // Mueve a la derecha si Quirrel está a la derecha
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

*/







