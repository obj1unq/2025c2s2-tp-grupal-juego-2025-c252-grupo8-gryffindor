import wollok.game.*
import juego.*
import direccionesEnemigos.*
import classProyectiles.*
import direccionesQuirrel.*
import estadosQuirrel.*
import BarraDeVida.*
import mapa.*

class Enemigo {
  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  const elegido = posiciones.anyOne()
  var property position = elegido.position()
  const velocidad = 2000 

  method puntos() { 
    return 100 
  } 

  method image(){
    return "enemigo-" + elegido +".png"
  }

  method nivelActual(unNivel) {
    return unNivel
  }

  method moverse() {
     position = elegido.moverse(position)
  }  

  method moverHaciaQuirrel(){
    game.onTick(velocidad, "mover enemigo", { self.moverse() })
  }   

  method serAtacado(nivel) { 
    self.nivelActual(nivel).sacarEnemigo(self)
    self.nivelActual(nivel).sumarPuntos(self.puntos())
    game.removeVisual(self) 
  }

  method atacar(protagonista) {
    protagonista.recibirDanio(1)
    game.removeVisual(self)
  }

  method spawnear(nivel) {
    if (!game.hasVisual(self)) { 
    game.addVisual(self)
    self.nivelActual(nivel).agregarEnemigo(self)
    self.moverHaciaQuirrel()
    }   
  }
  
}

/*------------------------------------------------------
                     HORNET
-------------------------------------------------------*/

object hornet inherits Enemigo {

  override method image() {
    return "hornet.png"
  }
  override method spawnear(nivel) {
    if (!game.hasVisual(self)) {
      game.addVisual(self) 
      self.nivelActual(nivel).agragarEnemigo(self) 
    }   
  }

  method lanzarCuchillo(){
    const nuevoCuchillo = new Cuchillo()
    nuevoCuchillo.spawnear()
  }
}