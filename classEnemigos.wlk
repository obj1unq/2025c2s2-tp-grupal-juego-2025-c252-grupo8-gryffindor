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
  var property elegido = posiciones.anyOne()
  var property position = elegido.position()
  method lentitud(){return 1000 }

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
    game.onTick(self.lentitud(), "mover enemigo", { self.moverse() })
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
                     ARAÑA
-------------------------------------------------------*/
class Araña inherits Enemigo {

method ruido(){
  game.sound("caminar.mp3").play()
}

  override method image() {
    return "arana-" + elegido +".gif"
  }
  override method lentitud(){ return 1000 }
  override method moverse() {
     super()
      self.ruido()  

  }
}
/*------------------------------------------------------
                     HORNET
-------------------------------------------------------*/