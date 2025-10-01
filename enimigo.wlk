import wollok.game.game
import juego.*




class Enemigo {
    var property position // al llamar a esta clase se le pasa la posicion inicial 
    var property imagen 
    var property enemigo = quirrel
    method imagen() { return imagen }
    method position() { return position }

    
    method atacarAquerril() {
      if (position == enemigo.position()){
        enemigo.recibirDanio(10)
      } 
    }
      
}
const enemigoDerecho = new Enemigo(
    imagen = "enemigoDerecha.png",
    position = game.at(0, 5)   
)
const enemigoIzquierdo = new Enemigo(
    imagen = "enemigoIzquierda.png",
    position = game.at(10, 5)
)
const enemigoArriba = new Enemigo(
    imagen = "enemigoArriba.png",
    position = game.at(5, 10)
)
const enemigoAbajo = new Enemigo(
    imagen = "enemigoAbajo.png",
    position = game.at(5, 0)    
)

 /*
class Enemigo {
    var  position 
    var  imagen

    method atacarAquerril(quirrel) {
      if (position == querril.position){
        querril.recibirDanio(10)
      } 
    }
    direccion = direccion
    //this.imagen = imagenPorDireccion(direccion)
    //this.posicion = posicionInicial(direccion)
  }

  method imagenPorDireccion(direccion) {
    direccion == "norte" ifTrue: [ return "enemigoNorte.png" ]
    direccion == "sur"   ifTrue: [ return "enemigoSur.png" ]
    direccion == "este"  ifTrue: [ return "enemigoEste.png" ]
    direccion == "oeste" ifTrue: [ return "enemigoOeste.png" ]
  }

  method posicionInicial(direccion) {
    direccion == "norte" ifTrue: [ return posicion(5, 0) ]
    direccion == "sur"   ifTrue: [ return posicion(5, 10) ]
    direccion == "este"  ifTrue: [ return posicion(10, 5) ]
    direccion == "oeste" ifTrue: [ return posicion(0, 5) ]
  }

  method moverHaciaCentro() {
    posicion := posicion.moverHacia(posicion(5, 5))
  }

  method atacarSiColisionaCon(jugador) {
    (posicion == jugador.posicion) ifTrue: [
      jugador.recibirDanio(10)
    ]
  }
}
*/