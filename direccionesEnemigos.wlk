import wollok.game.*
import classProyectiles.*
import classEnemigos.*
import juego.*
import direccionesQuirrel.*
import estadosQuirrel.*

//--------------- DIRECCIONES ENEMIGOS---------------------------

object dirUpEnemy inherits DirEnemigo (facing = arriba){
  var property position = game.at(6, 12)   
  
  method moverse(aMover) {
    return aMover.down(1)
  }
  
  method calcularMovimientoHacia(posActual, target) {
    const diffY = target.y() - posActual.y()
    return if (diffY > 0) posActual.up(1) else posActual // Mueve hacia arriba si Quirrel está más arriba
  }
}



object dirDownEnemy inherits DirEnemigo (facing = abajo){
  var property position = game.at(6, 0)   

   method moverse(aMover) {
    return aMover.up(1)
  }
  method calcularMovimientoHacia(posActual, target) {
    const diffY = target.y() - posActual.y()
    return if (diffY < 0) posActual.down(1) else posActual // Mueve hacia abajo si Quirrel está más abajo
  }
}




object dirLeftEnemy inherits DirEnemigo (facing = izquierda){
  var property position = game.at(0, 6)   

   method moverse(aMover) {
    return aMover.right(1)
  }
  method calcularMovimientoHacia(posActual, target) {
    const diffX = target.x() - posActual.x()
    return if (diffX < 0) posActual.left(1) else posActual // Mueve a la izquierda si Quirrel está a la izquierda
  }
}




object dirRightEnemy inherits DirEnemigo (facing = derecha){  
  var property position = game.at(12, 6)   

   method moverse(aMover) {
    return aMover.left(1)
  }
  method calcularMovimientoHacia(posActual, target) {
    const diffX = target.x() - posActual.x()
    return if (diffX > 0) posActual.right(1) else posActual // Mueve a la derecha si Quirrel está a la derecha
  }

}
 
 

//---------------- SUPERCLASE------------------

class DirEnemigo { 
  var property image = "quirrel-muerto.png"
  const protagonista = quirrel
  const facing 

  method puedeBloquearse() {
    return protagonista.direccionActual() == facing and not protagonista.puedeRecibirDanio()
  }

}
