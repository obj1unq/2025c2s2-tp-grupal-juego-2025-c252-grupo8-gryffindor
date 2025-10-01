import wollok.game.*
import enimigo.*
 object quirrel {
   var property imagen = "querri.png"
   var property position = game.center()
   var property enemigoe = enemigo
   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method atacarDireccion(direccion) {
     if (position == enemigoe.position()){
        imagen = direccion.imgaen()
        enemigoe.eliminarEnemigo(direccion)
     }
   }
    method puedeAtacarA(enemigo, direccion){
        return  enemigo.position().y().between(self.position().y(), self.position().y()+2)
    }
 }

 object dirUp {
   var property imagen = "querri-arriba.png"
   var property position = game.center()

   method image() {
    return imagen 
   }
   method position(){
    return position
   }
 }

  object dirDown {
   var property imagen = "querri-abajo.png"
   var property position = game.center()

   method image() {
    return imagen 
   }
   method position(){
    return position
   }
 }

  object dirLeft {
   var property imagen = "querri-izquierda.png"
   var property position = game.center()

   method image() {
    return imagen 
   }
   method position(){
    return position
   }
 }

  object dirRight {
   var property imagen = "querri-derecha.png"
   var property position = game.center()

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   
 }



 object enemigo {
   var property imagen = "img.png"
   var property position = game.center()
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

