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

  method moverse() {
    position = position.up(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() + 1, self.position().y() + 2)
  }


  method atacar(enemigo){
    if(game.hasVisual(enemigo)){
      self.moverse()
      enemigo.serAtacado()
      personaje.enemigoEliminado()
      game.schedule(500, { position = game.center() }) 
    }
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

  method moverse() {
    position = position.down(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() - 2, self.position().y() - 1)
  }

  method atacar(enemigo){
    if(game.hasVisual(enemigo)){
      self.moverse()
      enemigo.serAtacado()
      personaje.enemigoEliminado()
      game.schedule(500, { position = game.center() }) 
    }
  
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

  method moverse() {
    position = position.left(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() - 2, self.position().x() - 1)
  }

  method atacar(enemigo){
    if(game.hasVisual(enemigo)){
      self.moverse()
      enemigo.serAtacado()
      personaje.enemigoEliminado()
      game.schedule(500, { position = game.center() }) 
    }
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

  method moverse() {
    position = position.right(1)
  }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() + 1, self.position().x() + 2)
  }

  method atacar(enemigo){
    if(game.hasVisual(enemigo)){
      self.moverse()
      enemigo.serAtacado()
      personaje.enemigoEliminado()
      game.schedule(500, { position = game.center() }) 
      }
    }
}


