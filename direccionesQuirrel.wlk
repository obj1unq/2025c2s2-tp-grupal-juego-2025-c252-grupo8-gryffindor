import wollok.game.*
import clases.*
import juego.*
import direccionesEnemigos.*
import estadosQuirrel.*


object dirUp {
  var property position = game.center()
  var property personaje = quirrel


  method image() {
    return self.imagenSegunEstado(personaje.estado())
  }

  method imagenSegunEstado(estado){
    return "quirrel-"+estado+"-arriba.png"
  }

  method moverse(aMover) {
    return aMover.up(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() + 1, self.position().y() + 2)
  }


  
}

object dirDown {
  var property position = game.center()
  var property personaje = quirrel

  method image() {
    return self.imagenSegunEstado(personaje.estado())
  }

  method imagenSegunEstado(estado){
    return "quirrel-"+estado+"-abajo.png"
  }

 method moverse(aMover) {
    return aMover.down(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() - 2, self.position().y() - 1)
  }

  
  }


object dirLeft {
  var property position = game.center()
  var property personaje = quirrel


  method image() {
    return self.imagenSegunEstado(personaje.estado())
  }

  method imagenSegunEstado(estado){
    return "quirrel-"+estado+"-izquierda.png"
  }

method moverse(aMover) {
    return aMover.left(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() - 2, self.position().x() - 1)
  }


}


object dirRight {
  var property position = game.center()
  var property personaje = quirrel

  method image() {
    return self.imagenSegunEstado(personaje.estado())
  }

  method imagenSegunEstado(estado){
    return "quirrel-"+estado+"-derecha.png"
  }

  method moverse(aMover) {
    return aMover.right(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() + 1, self.position().x() + 2)
  }


}


