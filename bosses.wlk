
import wollok.game.*
import clases.*
import direccionesQuirrel.*
import direccionesEnemigos.*
import estadosQuirrel.*
import BarraDeVida.*
import mapa.*



object hornet inherits Enemigo {

  const mapa = primerNivel

  override method image() {
    return "hornet.png"
}
override method spawnear() {
    if (!game.hasVisual(self)) {
      mapa.añadirEnemigo(self)
    game.addVisual(self)
    self.iniciarBatalla()
    }   
  }


method lanzarCuchillo(){
    const nuevoCuchillo = new Cuchillo()
    nuevoCuchillo.spawnear()
  }

  method moverse{
    elegido = posiciones.anyOne()
    position = elegido
  }
}