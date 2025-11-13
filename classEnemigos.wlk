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
  method image(){return "enemigo-" + elegido +".png"}
  var property position = elegido.position()
  var mapa = primerNivel
  const velocidad = 2000 //milisegundos entre cada movimiento

  method puntos() { return 100 }

  var property accionAlMorir = null

  method onMorirDo(bloque) {
    accionAlMorir = bloque
  }

  // method morir() {
  //   // if (!accionAlMorir.isNull()) 
  //   self.accionAlMorir()
  //   game.removeVisual(self)
  //   mapa.sacarEnemigo(self)
  // }
/*
  method serAtacado() {
    self.morir()
  }
  */
    
  method serAtacado() { 
    //al ser atacado, el enemigo desaparece
    self.accionAlMorir()
    game.removeVisual(self) 
    mapa.sacarEnemigo(self)
  }

  method atacar(protagonista) {
    //esto ocurre solamente cuando el enemigo logra llegar a Quirrel, y por tanto lo lastima
    protagonista.recibirDanio(1)
    game.removeVisual(self)
  }

  method moverse() {
    //se mueve segun el elegido
     position = elegido.moverse(position)
  }
  
  method moverHaciaQuirrel(){
    game.onTick(velocidad, "mover enemigo", { self.moverse() })
  }

  
  method spawnear() {
    if (!game.hasVisual(self)) {
      mapa.añadirEnemigo(self)
        game.addVisual(self)
        self.moverHaciaQuirrel()
    }   
  }
  
  method esEnemigo(){
    return true
  }
}

/*------------------------------------------------------
                     HORNET
-------------------------------------------------------*/

object hornet inherits Enemigo {
  override method image() {
    return "hornet.png"
  }
  override method spawnear() {
    if (!game.hasVisual(self)) {
      mapa.añadirEnemigo(self)
      game.addVisual(self)
    }   
  }

  method lanzarCuchillo(){
    const nuevoCuchillo = new Cuchillo()
    nuevoCuchillo.spawnear()
  }
}