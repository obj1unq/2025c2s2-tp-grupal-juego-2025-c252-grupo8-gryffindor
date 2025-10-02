import wollok.game.*
import juego.*
import enemigo.*


class Enemigo {
  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  var elegido = posiciones.anyOne()
  var property image = elegido.image()
  var property position = elegido.spawn()

  method serAtacado() { 
    game.removeVisual(self) 
  }

  method atacar(protagonista) {
    protagonista.recibirDanio(1)
    game.removeVisual(self)
  }

  method moverse() {
    position = elegido.moverse(position)
  }

  method spawnear() {
    if (!game.hasVisual(self)) {
      elegido = posiciones.anyOne() // Elige una dirección aleatoria
      position = elegido.spawn()
      game.addVisual(self)
      game.onTick(1000, "mover enemigo", { self.moverse() })
    }
  }
}

class Proyectil {
  var property image = "bala.png"
  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  var elegido = posiciones.anyOne()
  var property position = elegido.position()

  method moverse() {
    position = elegido.moverse(position)
  }

  method spawnear() {
    if (!game.hasVisual(self)) {
      elegido = posiciones.anyOne() //direccion aleatoria
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
