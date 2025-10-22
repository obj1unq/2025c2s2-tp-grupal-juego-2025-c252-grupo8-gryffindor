import wollok.game.*
import enemigo.*
import clases.*

object juego {
  method cinematicaInicio() {
    game.boardGround("fondo.jpg")
    game.addVisual(quirrel)
    game.say(quirrel, "¡Hola! Soy Quirrel, el valiente aventurero.")
    game.schedule(3000, { game.say(quirrel, "Debo enfrentarme a los enemigos que se aproximan.") })
    game.schedule(6000, { game.say(quirrel, "Usa las flechas para moverme x para cubrirme, y c para atacar.") })
    game.schedule(9000, { game.say(quirrel, "¡Buena suerte!") })
    game.schedule(12000, { self.iniciar() })
  }

  method iniciar() {
    keyboard.right().onPressDo{ quirrel.mirarHaciaDireccion(derecha) }
    keyboard.left().onPressDo{ quirrel.mirarHaciaDireccion(izquierda) }
    keyboard.up().onPressDo{ quirrel.mirarHaciaDireccion(arriba) }
    keyboard.down().onPressDo{ quirrel.mirarHaciaDireccion(abajo) }
    keyboard.c().onPressDo{ quirrel.atacarAEnemigo() }
    keyboard.x().onPressDo{ quirrel.bloquear() }
    game.boardGround("fondo2.jpg")
    game.onCollideDo(quirrel, { cosa => cosa.atacar(quirrel) })    
    game.onTick(2000, "spawnear enemigo", { const nuevoEnemigo = new Enemigo(); nuevoEnemigo.spawnear() })
    game.onTick(3000, "spawnear proyectil", { const nuevoProyectil = new Proyectil(); nuevoProyectil.spawnear() })
    
    game.onTick(1000, "mover proyectil", { game.allVisuals().forEach{ visual => if (visual.className() == "Proyectil") visual.moverse() } })
    game.onTick(1000, "mover enemigo", { game.allVisuals().forEach{ visual => if (visual.className() == "Enemigo") visual.moverse() } })
  }
}


object quirrel {
  var property direccionActual = derecha
  var property position = game.center()
  var vidasDeQuirrel = 1
  var puntitos = 0
  var property modo = normal // puede ser normal,atacando, o cubriendo
  
 method image(){
  return "quirrel-" + modo + "-" + direccionActual + ".jpg"
 }


  method sumarPuntaje(puntaje) { puntitos += puntaje }

  method recibirDanio(danioRecibido) {
    vidasDeQuirrel -= danioRecibido
    if (vidasDeQuirrel <= 0) {
      game.say(self, "Me quede sin vidas")
      game.schedule(2000, { game.stop() })
    }
  }

  method mirarHaciaDireccion(direccion) {
    direccionActual = direccion
  }

  method atacarAEnemigo() {
    modo = atacando

  }

  method bloquear() {
    modo = cubriendo 
    game.schedule(3000, {self.modo(normal)})
  }
  
  method atacarEnemigoEnDireccion(enemigo, direccion) {
    if (game.hasVisual(enemigo) && modo == "atacando") {
      position = direccion.dir()
      enemigo.serAtacado()
      game.say(self, "fuiste eliminado")
      self.sumarPuntaje(100)
      game.schedule(500, { position = game.center() })
    }
  }
}


//------------------DIRECCIONES Quirrel-------------------///
object arriba {
  var property position = game.center()
  var property personaje = quirrel

  method image() {
    return if (personaje.modo() == "cubriendo") "quirrel-cubriendo-arriba.png"
    else if (personaje.modo() == "atacando") "quirrel-atacando-arriba.png"
    else "quirrel-arriba.png"
  }
  method position() { return position }

  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() + 1, self.position().y() + 2)
  }

  method dir() {
    return position.up(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección")
    }
  }
}

object abajo {
  var property position = game.center()
  var property personaje = quirrel
  method position() { return position }

  method puedeAtacarA(enemigo) {
    return enemigo.position().y().between(self.position().y() - 2, self.position().y() - 1)
  }

  method dir() {
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

object izquierda {
  var property position = game.center()
  var property personaje = quirrel

  method position() { return position }


  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() - 2, self.position().x() - 1)
  }

  method dir() {
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

object derecha {
  var property position = game.center()
  var property personaje = quirrel


  method position() { return position }

  method puedeAtacarA(enemigo) {
    return enemigo.position().x().between(self.position().x() + 1, self.position().x() + 2)
  }

  method dir() {
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




// Modos------------------

object atacando {
 const protagonista = quirrel

  method atacarEnemigoEnDireccion(enemigo, direccion) {
    if (game.hasVisual(enemigo)) {
      protagonista.position(direccion.dir())
      enemigo.serAtacado()
      game.say(protagonista, "fuiste eliminado")
      protagonista.sumarPuntaje(100)
      game.schedule(500, {protagonista.position(game.center())})
    }
  }
}
 object normal {}

 object cubriendo {}



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








