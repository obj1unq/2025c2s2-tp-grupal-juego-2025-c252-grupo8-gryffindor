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
        enemigo.recibirDanio()
      } 
    }
      
}
// falta definir las imagenes del enemigo
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