import wollok.game.*
import juego.*
import enemigo.*
import mapa.*

class Enemigo {
  var mapa = primerNivel
  var elegido = mapa.spawns().anyOne()
  var property image = elegido.image()
  var property position = elegido.spawn()

  method serAtacado() { 
    // la reaccion del enemigo al ser atacado
    game.removeVisual(self) 
  }

  method atacar(protagonista) {
    //cada enemigo pude hacer un nivel de daño al protagonista
    protagonista.recibirDanio(1)
    game.removeVisual(self)
  }

  method moverse() {
    // la dirección en la que spawne+o se encarga de moverlo en la dirección correcta
    position = elegido.moverse(position)
  
    /* tal vez usar despues     position = elegido.calcularMovimientoHacia(position, quirrel.position())
    game.say(self, "Moviendo enemigo a " + position.toString()) */ 
  }
  

  method spawnear() {
    // el enemigo aparece en uno de los 4 posibles
    if (!game.hasVisual(self)) {
      elegido = mapa.spawns().anyOne() // Elige una dirección aleatoria
      position = elegido.spawn()
      game.addVisual(self)
      game.onTick(1000, "mover enemigo", { self.moverse() })
    }
  }
}

class Proyectil {
  var property image = "bala.png"
  var mapa = primerNivel
  var elegido = mapa.spawns().anyOne()
  var property position = elegido.position()

  method moverse() {
    position = elegido.moverse(position)
  }

  method spawnear() {
    if (!game.hasVisual(self)) {
      elegido = mapa.spawns().anyOne() //direccion aleatoria
      position = elegido.spawn()
      game.addVisual(self)
      game.onTick(1000, "mover proyectil", {  self.moverse() })
    }
  }

  method atacar(protagonista) {
    if (elegido.puedeBloquearse()) {
      self.serBloqueado()
    } else {
      protagonista.recibirDanio(2)
      game.removeVisual(self)
    }
  }

  method serBloqueado() {
    game.removeVisual(self)
  }
}
