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
  
 
}



object dirDownEnemy inherits DirEnemigo (facing = abajo){
  var property position = game.at(6, 0)   

   method moverse(aMover) {
    return aMover.up(1)
  }

}




object dirLeftEnemy inherits DirEnemigo (facing = izquierda){
  var property position = game.at(0, 6)   

   method moverse(aMover) {
    return aMover.right(1)
  }
  
}




object dirRightEnemy inherits DirEnemigo (facing = derecha){  
  var property position = game.at(12, 6)   

   method moverse(aMover) {
    return aMover.left(1)
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
