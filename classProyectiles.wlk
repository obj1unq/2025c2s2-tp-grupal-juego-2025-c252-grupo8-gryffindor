import wollok.game.*
import juego.*
import direccionesEnemigos.*
import classEnemigos.*

import mapa.*


class Proyectil {
  var mapa = primerNivel
  method image (){
    return "bala.png"
  }
  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  const elegido = posiciones.anyOne()
  var property position = elegido.position()
 

  method moverse() {
    position = elegido.moverse(position)
  }
  
  method moverHaciaQuirrel(){
    game.onTick(1000, "mover proyectil", {  self.moverse() })
  }
  method spawnear() {
    if (!game.hasVisual(self)) {
    game.addVisual(self)
    mapa.añadirProyectil(self)
    self.moverHaciaQuirrel()
    }
  }

  method verificarSiPuedeAtacar(){
    if(elegido.puedeBloquearse()){
      game.removeVisual(self)
      self.error("Quirrel esta protegido")
    }
  }
  method atacar(protagonista) {
      self.verificarSiPuedeAtacar()
      protagonista.recibirDanio(1)
      game.removeVisual(self)
  }

  method serBloqueado() {
    game.removeVisual(self)
    mapa.sacarProyectil(self)
  }

  method esEnemigo(){
    return true
  }
}

//subtipo de proyectil de hornet
/*------------------------------------------------------
                     CUCHILLO
-------------------------------------------------------*/
class Cuchillo inherits Proyectil{
  override method image (){
    return "cuchillo-"+elegido+".png"
  }
  override method atacar(protagonista) {
      self.verificarSiPuedeAtacar()
      protagonista.recibirDanio(2)
      game.removeVisual(self)
  }

  
}