import wollok.game.*
import juego.*
import direccionesEnemigos.*


import mapa.*

class Enemigo {

  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  var elegido = posiciones.anyOne()
  var property image = elegido.image()
 

  method position(){
    return elegido.position()
  }
  method serAtacado() { 
    game.removeVisual(self) 
  }

  method atacar(protagonista) {
    protagonista.recibirDanio(1)
    game.removeVisual(self)
  }

  method moverse() {
     return elegido.moverse()
  }
  
  method moverHaciaQuirrel(){
    game.onTick(2000, "mover enemigo", { self.moverse() })
  }

  
  method spawnear() {
    if (!game.hasVisual(self)) {
    game.addVisual(self)
    self.moverHaciaQuirrel()
    }   
  }
}

class Proyectil {
  var property image = "bala.png"
  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  var elegido = posiciones.anyOne()
 
  method position(){
    return elegido.position()
  }
  method moverse() {
    return elegido.moverse()
  }
  method moverHaciaQuirrel(){
    game.onTick(1000, "mover proyectil", {  self.moverse() })
  }
  method spawnear() {
    if (!game.hasVisual(self)) {
    game.addVisual(self)
    self.moverHaciaQuirrel()
    }
  }

  method verificarSiPuedeAtacar(){
    if(elegido.puedeBloquearse()){
      self.error("Quirrel esta protegido")
    }
  }
  method atacar(protagonista) {
      self.verificarSiPuedeAtacar()
      protagonista.recibirDanio(2)
      game.removeVisual(self)
  }

  method serBloqueado() {
    game.removeVisual(self)
  }
}
