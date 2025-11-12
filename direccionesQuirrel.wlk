import wollok.game.*
import clases.*
import juego.*
import direccionesEnemigos.*
import estadosQuirrel.*


class Direcc { // este nombre es temporario, se deberia cambiar por uno mas adecuado
  var property position = game.center()
  var estadoPersonaje = null

  method estadoPersonaje(_estadoPersonaje){
     estadoPersonaje = _estadoPersonaje
  }
  method image() {
    return self.imagenSegunEstado(estadoPersonaje)
  }
  method imagenSegunEstado(estado){
    return 
  }

}


object dirUp inherits Direcc{

  override method imagenSegunEstado(estado){
    return "quirrel-"+estado+"-arriba.png"
  }

  method moverse(aMover) {
    return aMover.up(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() + 1, self.position().y() + 2)
  }

}


object dirDown inherits Direcc{

  override method imagenSegunEstado(estado){
    return "quirrel-"+estado+"-abajo.png"
  }

 method moverse(aMover) {
    return aMover.down(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() - 2, self.position().y() - 1)
  }
  
}


object dirLeft inherits Direcc {

  override method imagenSegunEstado(estado){
    return "quirrel-"+estado+"-izquierda.png"
  }

  method moverse(aMover) {
    return aMover.left(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() - 2, self.position().x() - 1)
  }


}


object dirRight inherits Direcc {

  override method imagenSegunEstado(estado){
    return "quirrel-"+estado+"-derecha.png"
  }

  method moverse(aMover) {
    return aMover.right(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() + 1, self.position().x() + 2)
  }


}


