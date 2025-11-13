import wollok.game.*
import classProyectiles.*
import juego.quirrel.*
import direccionesEnemigos.*
import direccionesQuirrel.*

class EstadoQuirrel {
method puedeAtacar(){
    return true}

method puedeRecibirDanio(){
    return true}

}



object atacando inherits EstadoQuirrel {
}

object cubriendo inherits EstadoQuirrel {
   override method puedeAtacar(){
        return false }
    override method puedeRecibirDanio(){
        return false
    }
}

object normal inherits EstadoQuirrel {
    override method puedeAtacar(){
        return false
    }
   
}