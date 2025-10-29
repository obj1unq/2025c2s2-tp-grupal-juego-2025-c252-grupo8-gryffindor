import wollok.game.*
import juego.*
import direccionesEnemigos.*


import mapa.*

class Enemigo {

  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  var elegido = posiciones.anyOne()
  method image(){return "quirrel-muerto.png"}
  var property position = elegido.position()
  var mapa = primerNivel
  method serAtacado() { 
    //al ser atacado, el enemigo desaparece
    game.removeVisual(self) 
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
    game.onTick(2000, "mover enemigo", { self.moverse() })
  }

  
  method spawnear() {
    if (!game.hasVisual(self)) {
      mapa.añadirEnemigo(self)
    game.addVisual(self)
    self.moverHaciaQuirrel()
    }   
  }
}

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
}

//subtipo de proyectil de hornet

class Cuchillo inherits Proyectil{
override method image (){
    return "cuchillo"+ elegido + ".png"
}
override method atacar(protagonista) {
      self.verificarSiPuedeAtacar()
      protagonista.recibirDanio(2)
      game.removeVisual(self)
  }
}