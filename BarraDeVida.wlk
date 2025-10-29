import wollok.game.*
import juego.*

object mascaraDeVida {
  const usuario = quirrel 
  method position() {
    return game.at(6, 12)
  }
method image (){
    return "mascaraDeVida"+ usuario.vidasDeQuirrel() + ".png"
}

}
