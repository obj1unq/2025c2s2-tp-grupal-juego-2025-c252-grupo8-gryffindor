import wollok.game.*
import juego.*
import direccionesEnemigos.*
import classEnemigos.*

import mapa.*


class Proyectil {
  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  const elegido = posiciones.anyOne()
  var property position = elegido.position()

  method image (){
    return "bala.png"
  } 

  method nivelActual(unNivel) {
    return unNivel
  }

  method moverse() {
    position = elegido.moverse(position)
  }
  
  method moverHaciaQuirrel(){
    game.onTick(1000, "mover proyectil", {  self.moverse() })
  }

  method serBloqueado(nivel) {
    game.removeVisual(self)
    self.nivelActual(nivel).sacarProyectil(self)
  }  

  method atacar(protagonista) {
      self.verificarSiPuedeAtacar()
      protagonista.recibirDanio(1)
      game.removeVisual(self)
  }  

  method spawnear(nivel) {
    if (!game.hasVisual(self)) {
    game.addVisual(self)
    nivel.anadirProyectil(self)
    self.moverHaciaQuirrel()
    }
  }

  method verificarSiPuedeAtacar(){
    if(elegido.puedeBloquearse()){
      game.removeVisual(self)
      self.error("Quirrel esta protegido")
    }
  }

}

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