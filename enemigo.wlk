import wollok.game.game
import juego.*


 object enemigo {

  const posiciones = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}
  var property elegido = posiciones.anyOne()
  var property image = elegido.image()
  var property position =  elegido.position()

  method serAtacado(){ 
    game.removeVisual(self) 
  }   

  method atacar(protagonista){
    protagonista.recibirDanio(1)
   }

  method moverse(){
    elegido.moverse()
    position = elegido.position()
   }

 }
///--------------- DIRECCIONES ENEMIGO---------------------------

object dirUpEnemy {
  var property image = "quirrel-muerto.png"
  var property position = game.at(6, 12)   

  method moverse() {
    position = position.down(1) 
    return position
  }
}

object dirDownEnemy {

  var property position = game.at(6, 0)   
  var property image = "quirrel-muerto.png"
  method dir(pasos){
    return position.up(pasos)
  }

  method moverse() {
    position = position.up(1) 
    return position
  }
}

object dirLeftEnemy {
  var property position = game.at(0, 6)   
  var property image = "quirrel-muerto.png"

  method moverse() {
    position = position.right(1)
    return position
  }   
}

object dirRightEnemy {
  var property position = game.at(12, 6)   
  var property image = "quirrel-muerto.png"

  method moverse() {
    position = position.left(1)
    return position
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







