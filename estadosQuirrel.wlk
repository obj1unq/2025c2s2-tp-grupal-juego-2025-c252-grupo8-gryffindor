import wollok.game.*
import clases.*
import juego.quirrel.*
import direccionesEnemigos.*
import direccionesQuirrel.*

object atacando {
    method puedeAtacar(){
        return true
    }
    method puedeRecibirDanio(){
        return true
    }
  
}
object cubriendo {
    method puedeAtacar(){
        return false
    }
    method puedeRecibirDanio(){
        return false
    }
}

object normal {
    method puedeAtacar(){
        return false
    }
    method puedeRecibirDanio(){
        return true
    }
}