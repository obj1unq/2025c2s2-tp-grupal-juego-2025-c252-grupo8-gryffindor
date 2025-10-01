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
    direccion.puedeAtacarA(enemigo)
    enemigo.eliminarEnemigo()
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

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method puedeAtacarA(enemigo){
        return  enemigo.position().y().between(self.position().y()+1, self.position().y()+2)
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
   var property position = game.at(0, quirrel.position().y())
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
    position = game.at(position.x()+1, position.y())
    return position
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

