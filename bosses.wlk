
import wollok.game.*
import clases.*
import direccionesQuirrel.*
import direccionesEnemigos.*
import estadosQuirrel.*
import BarraDeVida.*
import mapa.*



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