import wollok.game.game
import juego.*


object proyectil {
  var property image = "bala.png"
  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  var property elegido = posiciones.anyOne()
  var property position =  elegido.position()

  method moverse(){
    position = elegido.moverse(position)
   }

 method spawnear(){
    if (!game.hasVisual(self)) {
      elegido = posiciones.anyOne() // Elige una dirección aleatoria
    position = elegido.spawn()
    game.addVisual(self)

    }
 }
method atacar(protagonista){
if (elegido.puedeBloquearse()){
  self.serBloqueado()}
else{
  protagonista.recibirDanio(2)
}
}
method serBloqueado(){
        game.removeVisual(self)
     }


     }


 object enemigo {

  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  var property elegido = posiciones.anyOne()
  var property image = elegido.image()
  var property position =  elegido.spawn()
  method serAtacado(){ 
    game.removeVisual(self) 
  }   

  method atacar(protagonista){
    protagonista.recibirDanio(1)
   }

  method moverse(){
    position = elegido.moverse(position)
   }
  
  method spawnear(){
    if (!game.hasVisual(self)) {
      elegido = posiciones.anyOne() // Elige una dirección aleatoria
    position = elegido.spawn()
    game.addVisual(self)

    }
  }
 }
///--------------- DIRECCIONES ENEMIGO---------------------------

object dirUpEnemy {
  var property image = "quirrel-muerto.png"
  var property position = game.at(6, 12)   
 const protagonista = quirrel
 const facing = dirUp

   method spawn() {
    return position
  }
  method moverse(aMover) {
    return aMover.down(1)
  }
  method puedeBloquearse() {
    return protagonista.direccionActual() == facing
  }
}

object dirDownEnemy {

  var property position = game.at(6, 0)   
  var property image = "quirrel-muerto.png"
  const protagonista = quirrel
  const facing = dirDown
 
   method puedeBloquearse() {
    return protagonista.direccionActual() == facing
  }


  method dir(pasos){
    return position.up(pasos)
  }
  method spawn() {
    return position
  }

  method moverse(aMover) {
    
    return aMover.up(1)
  }
}

object dirLeftEnemy {
  var property position = game.at(0, 6)   
  var property image = "quirrel-muerto.png"
const protagonista = quirrel
const facing = dirLeft
  method moverse(aMover) {
    return aMover.right(1)
  }   
    method spawn() {
    return position
  }
  method puedeBloquearse() {
    return protagonista.direccionActual() == facing
  }
}

object dirRightEnemy {
  var property position = game.at(12, 6)   
  var property image = "quirrel-muerto.png"
const protagonista = quirrel
const facing = dirRight
    method puedeBloquearse() {
    return protagonista.direccionActual() == facing
  }

  method spawn() {
    return position
  }
  method moverse(aMover) {
    
    return aMover.left(1)
  }
}




/*
///------------------DIRECCIONES Enemigo-------------------///

 object enemigo {
   var property imagen = "quirrel-muerto.png"
   var property position =game.origin()
   var property posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
   var property elegido = posiciones.anyOne()
   method image() {
    return imagen 
   }
   method position(){
    return position
   }
   method serAtacado(){ 
   
        game.removeVisual(self) 
   }
   method moverse(){
     //imagen = "quirell-muerto.png"
    position = elegido.dir(1)
    //return position
   }

   method atacar(protagonista){
    protagonista.recibirDanio(1)

   }
 }



 object dirUpEnemy {
   var property imagen = "img.png"
   var property position = game.at(5, 10)   
   method image() {return imagen }
   method position(){return position}

   method dir(pasos){
     return position.up(pasos)
  }
 }

object dirDownEnemy {
    var property position = game.at(0, 5)   
    var property imagen = "quirrel-muerto.png"
    method image() { return imagen }
    method position() { return position }
      
}
  object dirLeftEnemy {
      var property position = game.at(10, 5)   
      var property imagen = "img.png"
      method image() { return imagen }
      method position() { return position }
        
  }
  object dirRightEnemy {
      var property position = game.at(0, 5)   
      var property imagen = "img.png"
      method image() { return imagen }
      method position() { return position }
        
  }

*/







