import wollok.game.*
import enemigo.*
 object quirrel {
   var property imagen = "quirrel.png"
   var property position = game.center()
   var property rival = enemigo
   var vidasDeQuirrel = 5
   var puntitos = 0
   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method atacarDireccion(direccion) {
     imagen = direccion.image()
    direccion.validarAtacarA(enemigo)
    enemigo.eliminarEnemigo()
   }

    method atacar(direccion) {
      game.onTick(1000, "seguirSilvestre", { => quirrel.atacarDireccion(direccion) })
    }
   
   method sumarPuntaje(puntaje) {
     puntitos = puntitos+puntaje
   }


 

///------------------ELIMINAR ENEMIGO PRUEBA-------------------///
    method eliminarEnemigo(direccion) {
      if (position == direccion.position()){// Esta condicion no funciona, ya que el enemigo no debe estar en la misma posicion que quirrel para ser eliminado.
          imagen = "transparente.png"
      } 
    }

    method recibirDanio() { // Se puede utilizar en una colision
      vidasDeQuirrel -= 1
      if (vidasDeQuirrel == 0){
        imagen = "quirrel-muerto.png" //
        game.stop()
      }
    }

 }





///------------------DIRECCIONES Quirrel-------------------///
 object dirUp {
   var property imagen = "quirrel-arriba.png"
   var property position = game.center()
   const enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method puedeAtacarA(enemigo){
        return  enemigo.position().y().between(self.position().y()+1, self.position().y()+2)
    }

    method name() {
      enemigos.filter{enemigo => enemigo.puedeAtacarA(enemigo)}
    }


 }

  object dirDown {
   var property imagen = "quirrel-abajo.png"
   var property position = game.center()

   method image() {
    return imagen 
   }
   method position(){
    return position
   }
    method puedeAtacarA(enemigo){
        return  enemigo.position().y().between(self.position().y()-1, self.position().y()-2)
    }

   }
 

  object dirLeft {
   var property imagen = "quirrel-izquierda.png"
   var property position = game.center()

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

    method puedeAtacarA(enemigo){
        return  enemigo.position().x().between(self.position().x()-1, self.position().x()-2)
    }

 }

  object dirRight {
   var property imagen = "quirrel-derecha.png"
   var property position = game.center()

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

    method puedeAtacarA(enemigo){
        return  enemigo.position().x().between(self.position().x()+1, self.position().x()+2)
    }

 }
 

///------------------DIRECCIONES Enemigo-------------------///

 object enemigo {
   var property imagen = "quirrel-muerto.png"
   var property position = game.at(0,6)
   method image() {
    return imagen 
   }
   method position(){
    return position
   }
   method eliminarEnemigo(){ 
   
        game.removeVisual(self) 
   }
   method moverse(){
     //imagen = "quirell-muerto.png"
    position = position.right(1)
    //return position
   }
 }



 object dirUpEnemy {
   var property imagen = "img.png"
   var property position = game.center()
   method image() {
    return imagen 
   }
   method position(){
    return position
   }
 }

