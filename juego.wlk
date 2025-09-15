import wollok.game.*
 object quirrel {
   var property imagen = "img.png"
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

// atacar


 }

 object dirUp {
   var property imagen = "img.png"
   var property position = quirrel.position().y()+1

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method variante(){
    return Y()
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

