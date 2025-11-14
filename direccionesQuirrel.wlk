import wollok.game.*
import classProyectiles.*
import juego.*
import direccionesEnemigos.*
import estadosQuirrel.*


object arriba inherits Direcc{
  method moverse(aMover) {
    return aMover.up(1)
  }
  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() + 1, self.position().y() + 2)
  }
}


object abajo inherits Direcc{

 method moverse(aMover) {
    return aMover.down(1)
  }
  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() - 2, self.position().y() - 1)
  }
}


object izquierda inherits Direcc {

  method moverse(aMover) {
    return aMover.left(1)
  }
  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() - 2, self.position().x() - 1)
  }
}


object derecha inherits Direcc {
  
  method moverse(aMover) {
    return aMover.right(1)
  }
  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() + 1, self.position().x() + 2)
  }
}






//---------------SUPERCLASE------------------------

class Direcc { // este nombre es temporaL, se deberia cambiar por uno mas adecuado
  var property position = game.center()
  var estadoPersonaje = null


}