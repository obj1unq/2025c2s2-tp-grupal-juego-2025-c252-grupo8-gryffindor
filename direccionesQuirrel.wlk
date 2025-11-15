import wollok.game.*
import classProyectiles.*
import juego.*
import direccionesEnemigos.*
import estadosQuirrel.*


object arriba {
  var property position = game.center()

  method moverse(aMover) {
    return aMover.up(1)
  }
  
  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() + 1, self.position().y() + 2)
  }
}


object abajo {
  var property position = game.center()

  method moverse(aMover) {
    return aMover.down(1)
  }
  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() - 2, self.position().y() - 1)
  }
}


object izquierda {
  var property position = game.center()

  method moverse(aMover) {
    return aMover.left(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() - 2, self.position().x() - 1)
  }
}


object derecha  {
  var property position = game.center()

  method moverse(aMover) {
    return aMover.right(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() + 1, self.position().x() + 2)
  }
}
