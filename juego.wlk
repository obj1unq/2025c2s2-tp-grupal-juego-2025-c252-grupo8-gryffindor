import wollok.game.*
import enemigo.*
 object quirrel {
   var property imagen = "quirrel.png"
   var property position = game.center()
   var property rival = enemigo
   var vidasDeQuirrel = 5
   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method atacarDireccion(direccion) {
     if (position == rival.position()){
        imagen = direccion.imagen()
        rival.eliminarEnemigo(direccion)
     }
   }
    method puedeAtacarA(enemigo){
        return  enemigo.position().y().between(self.position().y(), self.position().y()+2)
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

   
 }

///------------------DIRECCIONES Enemigo-------------------///

 object enemigo {
   var property imagen = "img.png"
   var property position = game.at(3, 5)
   method image() {
    return imagen 
   }
   method position(){
    return position
   }
   method eliminarEnemigo(){ 
        game.removeVisual(self) 
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

