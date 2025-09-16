import wollok.game.*
import enemigo.*

object juego {

  method cinematicaInicio(){

    game.boardGround("fondo.jpg")
 
    game.addVisual(quirrel)
    game.say(quirrel, "¡Hola! Soy Quirrel, el valiente aventurero.")
    game.schedule(3000, { game.say(quirrel, "Debo enfrentarme a los enemigos que se aproximan.") })
    game.schedule(6000, { game.say(quirrel, "Usa las flechas para moverme x para cubrirme, y c para atacar.") })
    game.schedule(9000, { game.say(quirrel, "¡Buena suerte!") })
    game.schedule(12000, { self.iniciar() }) // Inicia el juego después de la cinemática
  }
  method iniciar(){
   
    keyboard.right().onPressDo{quirrel.mirarHaciaDireccion(dirRight)}
    keyboard.left().onPressDo{quirrel.mirarHaciaDireccion(dirLeft)}
    keyboard.up().onPressDo{quirrel.mirarHaciaDireccion(dirUp)}
    keyboard.down().onPressDo{quirrel.mirarHaciaDireccion(dirDown)}
    keyboard.c().onPressDo{quirrel.atacarAEnemigo(enemigo)}
    keyboard.x().onPressDo{quirrel.bloquear()}
    game.boardGround("fondo2.jpg")
   // game.onTick(1000.randomUpTo(3000), "enemigo Mover", { => enemigo.moverse() })
    game.onCollideDo(quirrel, {cosa => cosa.atacar(quirrel)})    
 // game.onTick(2000, "spawnear enemigo", { => enemigo.spawnear() }) // cada 2 segundos se spawnea un enemigo
  game.onTick(3000, "spawnear proyectil", { => proyectil.spawnear() }) // cada 3 segundos se spawnea un proyectil
  game.onTick(2000, "mover proyectil", { => proyectil.moverse() }) // cada 0.5 segundos se mueve el proyectil

}
}

object quirrel {
var property direccionActual = dirRight // esta variable guarda la ultima direccion hacia la que miraba  quirrel
  var property image = "quirrel.png"
  var property position = game.center()
  var vidasDeQuirrel = 1
  var puntitos = 0
  var property modo = "normal" //puede ser normal, atacando,o cubriendo
  

 method modoAtacando(){modo = "atacando"}
 method modoCubriendo(){modo = "cubriendo"}
 method modoNormal(){modo = "normal"}
  method position() { return position}
  method sumarPuntaje(puntaje) {puntitos += puntaje}

///------------------ELIMINAR ENEMIGO OK-------------------///

    method recibirDanio(danioRecibido) { // Se utiliza en la colision de enemigo con Quirrel.
      vidasDeQuirrel -= danioRecibido
      if (vidasDeQuirrel <= 0){
        game.say(self, "Me quede sin vidas")        // los game.say() no se estan ejecutando correctamente
        game.schedule(2000, { game.stop() })        // el programa si se detiene cuando quirrel se queda sin vida.
      }
    }

  method mirarHaciaDireccion(direccion) {
    direccionActual = direccion
    image = direccion.image()
  }

  method atacarAEnemigo(enemigo) {
      self.modoAtacando()                 //Le agregue esto para que solo ataque si la imagen visual esta en el tablero
      direccionActual.atacar(enemigo)                 // delegue la accion de atacar a la direccion, ya que este evalua si el enemigo se encuentra dentro de su margen de ataque..
    
  }
  method bloquear() {
    self.modoCubriendo()
    image = direccionActual.image() 
   game.schedule(3000, {self.modoNormal()})  // despues de segundo vuelve a modo normal 
  }
  
  method atacarEnemigoEnDireccion(enemigo, direccion){// si el enemigo esta dentro del margen  de ataque de la direccion actual hacia la que mira quirrel se ejecuta este metodo
    if(game.hasVisual(enemigo) && modo == "atacando"){  // si el enemigo esta en el tablero y quirrel esta en modo atacando
    position = direccion.dir()                        // hace que quirrel se desplace una celda hacia la direccion actual para atacar al enemigo 
    enemigo.serAtacado()
    game.say(self, "fuiste eliminado")                //se ejecuta correctamente
    self.sumarPuntaje(100)
    game.schedule(500, {position = game.center() })   // esto hace que quirrel vuelva a su posicion luego de eliminar al enemigo
    
    }
  }
 
}


///------------------DIRECCIONES Quirrel-------------------///
 object dirUp {
   var property imagen = "quirrel-arriba.png"
   var property position = game.center()
   const property enemigos = #{enemigo}
   var property personaje = quirrel



   method image() {return if (personaje.modo() == "cubriendo"){
      "quirrel-cubriendo-arriba.png"
   } 
   else if (personaje.modo() == "atacando"){
      "quirrel-atacando-arriba.png"
   } else {
      "quirrel-arriba.png"
   }
  }
   method position(){return position}

  method puedeAtacarA(enemigo){
    return  enemigo.position().y().between(self.position().y()+1, self.position().y()+2)
  }

  method dir(){
    return position.up(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección")  // Este else no se esta ejecutando correctamente
    }
  }
    
 }



object dirDown {

  var property imagen = "quirrel-abajo.png"
  var property position = game.center()
  var property personaje = quirrel

   method image() {return if (personaje.modo() == "cubriendo"){
      "quirrel-cubriendo-abajo.png"
   } 
   else if (personaje.modo() == "atacando"){
      "quirrel-atacando-abajo.png"
   } else {
      "quirrel-abajo.png"
   }
  }
  method position(){return position}

  method puedeAtacarA(enemigo) {
      return enemigo.position().y().between(self.position().y() - 2, self.position().y() - 1)
  }

  method dir(){
    return position.down(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección") 
    }
  }
}


object dirLeft {
  var property image = "quirrel-izquierda.png"
  var property position = game.center()
  var property personaje = quirrel

  method image() {return if (personaje.modo() == "cubriendo"){
      "quirrel-cubriendo-izquierda.png"
   } 
   else if (personaje.modo() == "atacando"){
      "quirrel-atacando-izquierda.png"
   } else {
      "quirrel-izquierda.png"
   } }
  method position(){return position}

  method puedeAtacarA(enemigo){
    return enemigo.position().x().between(self.position().x()-2, self.position().x()-1)
  }

  method dir(){
    return position.left(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección") 
    }
  }
}



object dirRight {
  var property image = "quirrel.png"
  var property position = game.center()
  var property personaje = quirrel

  method image() {return if (personaje.modo() == "cubriendo"){
      "quirrel-cubriendo-derecha.png"
   } 
   else if (personaje.modo() == "atacando"){
      "quirrel-atacando-derecha.png"
   } else {
      "quirrel.png"
   }
  }

  method position(){return position}

  method puedeAtacarA(enemigo){
    return  enemigo.position().x().between(self.position().x()+1, self.position().x()+2)
  }

  method dir(){
    return position.right(1)
  }

  method atacar(enemigo) {
    if (self.puedeAtacarA(enemigo)) {
      personaje.atacarEnemigoEnDireccion(enemigo, self)
    } else {
      game.say(personaje, "No hay enemigos cercanos en esa dirección") 
    }
  }
}







 



 /*
  object quirrel {
   var property imagen = "quirrel.png"
   var property position = game.center()
   var property rival = enemigo
   var vidasDeQuirrel = 1
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
    direccion.enemigos().forEach({enemigo => enemigo.serAtacado()})
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

    method recibirDanio(danioRecibido) { // Se puede utilizar en una colision
      vidasDeQuirrel -= danioRecibido
      if (vidasDeQuirrel == 0){
        imagen = "quirrel-muerto.png" //
        game.schedule(2000, {game.stop() })
      }
    }

 }





///------------------DIRECCIONES Quirrel-------------------///
 object dirUp {
   var property imagen = "quirrel-arriba.png"
   var property position = game.center()
   const property enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

   method puedeAtacarA(enemigo){
        return  enemigo.position().y().between(self.position().y()+1, self.position().y()+2)
    }

    method filtrarEnemigos() {
      return enemigos.filter{enemigo => self.puedeAtacarA(enemigo)}
    }


 }

  object dirDown {
   var property imagen = "quirrel-abajo.png"
   var property position = game.center()
   const property enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }
    method puedeAtacarA(enemigo){
        return  enemigo.position().y().between(self.position().y()-1, self.position().y()-2)
    }
     method filtrarEnemigos() {
      return enemigos.filter{enemigo => self.puedeAtacarA(enemigo)}
    }


   }
 

  object dirLeft {
   var property imagen = "quirrel-izquierda.png"
   var property position = game.center()
   const property enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

    method puedeAtacarA(enemigo){
        return  enemigo.position().x().between(self.position().x()-1, self.position().x()-2)
    }
  method filtrarEnemigos() {
      return enemigos.filter{enemigo => self.puedeAtacarA(enemigo)}
    }

 }

  object dirRight {
   var property imagen = "quirrel-derecha.png"
   var property position = game.center()
   const property enemigos = #{enemigo}

   method image() {
    return imagen 
   }
   method position(){
    return position
   }

    method puedeAtacarA(enemigo){
        return  enemigo.position().x().between(self.position().x()+1, self.position().x()+2)
    }
method filtrarEnemigos() {
      return enemigos.filter{enemigo => self.puedeAtacarA(enemigo)}
    }
 }*/








