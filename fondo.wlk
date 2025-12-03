// object fondo 
import wollok.game.*
import direccionesEnemigos.*
import classProyectiles.*
import classEnemigos.*
import niveles.*
import juego.*
 
object fondo {
  var property position = game.at(0,0)
  var property contador = 1
  var property nivelActual = nivel1
  var property saltearCinematica = false

    
  method image(){  return ""+nivelActual+"-cinematica"+ contador+".png"}

  method saltarCinematica(){
    saltearCinematica = true
    game.removeTickEvent("aumentarCinematica")
    nivelActual.iniciar()
  }

  method cinematica(nivel, limite){
    nivelActual = nivel
    game.onTick(5000, "aumentarCinematica", {self.cambiarImagenCinematica(nivel, limite)})
  }
  

  method cambiarImagenCinematica(nivel, limite){
    contador = contador + 1 
    if (contador > limite){
      game.removeTickEvent("aumentarCinematica")
      nivel.iniciar()}
    }
 }
