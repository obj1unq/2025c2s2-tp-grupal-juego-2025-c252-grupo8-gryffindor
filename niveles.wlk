import wollok.game.*
import classProyectiles.*
import classEnemigos.*
import direccionesQuirrel.*
import direccionesEnemigos.*
import estadosQuirrel.*
import BarraDeVida.*
import mapa.*
import juego.*
import fondo.*
import boss.*


class Nivel {
  var property enemigos = []
  var property proyectiles = []
  var property puntajeActual = 0
  var property completado = false
  const marcadorDePuntos = marcadorPuntos
  const personaje = quirrel

  method musicaDeNivel(){
    return game.sound("musicaDeFondoNivel1.mp3")
  }

  method puntajeRequerido()

  const fondoGeneral = fondo

  method numeroCinematica(){
  return 5}

  //-------------------------------------------------------------------------

  const property spawns = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}

  method agregarEnemigo(enemigo){
      enemigos.add(enemigo)
  }
  method sacarEnemigo(enemigo){
      enemigos.remove(enemigo)
  }
  method agregarProyectil(proyectil){
      proyectiles.add(proyectil)
  }
  method sacarProyectil(proyectil){
      proyectiles.remove(proyectil)
  }
  //-------------------------------------------------------------------------



  method cinematicaInicio() {
    keyboard.e().onPressDo{ fondoGeneral.saltarCinematica() }
    game.clear()
    self.tocarMusica()
    game.addVisual(fondo)
    fondoGeneral.cinematica(self, self.numeroCinematica())
    game.say(quirrel, "¡Hola! Soy Quirrel, el valiente aventurero.")
    game.schedule(3000, { game.say(quirrel, "Debo enfrentarme a los enemigos que se aproximan.") })
    game.schedule(6000, { game.say(quirrel, "Usa las flechas para moverme x para cubrirme, y c para atacar.") })
    game.schedule(8000, { game.say(quirrel, "¡Buena suerte!") })
  }

  method tocarMusica(){
    self.musicaDeNivel().play()
  }

  method pararMusica(){
     self.musicaDeNivel().stop()
  }

  method iniciar() {
    personaje.nivelActual(self) 
    marcadorDePuntos.nivelActual(self)
    game.schedule(4000, {game.addVisual(personaje)})
    game.addVisual(mascaraDeVida)
    game.addVisual(marcadorPuntos)
    game.addVisual(marcadorVidas)
    self.configurarControles()
    self.spawnear()
    self.configurarColisiones()
  }

  method configurarControles() {
    keyboard.right().onPressDo{ personaje.mirarHaciaDireccion(derecha) }
    keyboard.left().onPressDo{ personaje.mirarHaciaDireccion(izquierda) }
    keyboard.up().onPressDo{ personaje.mirarHaciaDireccion(arriba) }
    keyboard.down().onPressDo{ personaje.mirarHaciaDireccion(abajo) }
    keyboard.x().onPressDo{ personaje.atacarAEnemigos(self) }
    keyboard.c().onPressDo{ personaje.bloquear() }
  }

  method spawnear() {
    game.onTick(4000, "spawnear enemigo",{ self.configurarSpawns(new Enemigo())})
    game.onTick(10000, "spawnear proyectil",{ self.configurarSpawns(new Proyectil())})
  }

  method configurarSpawns(enemigo){
    const nuevoEnemigo = enemigo
    nuevoEnemigo.nivelActual(self)
    nuevoEnemigo.spawnear(self)
  }

  method configurarColisiones() {
    game.onCollideDo(personaje, { cosa => cosa.atacar(personaje) })  
  }

   
  method sumarPuntos(punto) {
    puntajeActual += punto
    self.verificarSiCompletoLospuntos()
    juego.verificarProgreso()
  }

  method verificarSiCompletoLospuntos(){
    if(puntajeActual >= self.puntajeRequerido()){
      completado = true
      }
  }

  method estaCompletado() {
    return completado
  }
  
}



object nivel1 inherits Nivel {
  override method puntajeRequerido(){
    return 500
  }
}


object nivel2 inherits Nivel {
  override method numeroCinematica(){return 4}
  override method puntajeRequerido(){
    return 500
  }
}


object juego {
  var property niveles = [nivel1, nivel2, nivel3]
  var property nivelActual = 0


  method iniciarNivelActual() {
    niveles.get(nivelActual).cinematicaInicio() }

  method verificarProgreso() {    
    if (self.juegoTermino()) {
      game.say(self, "¡Juego completado!")
      game.schedule(1000, {game.stop()})
      game.stop()
    } else if (self.nivelCompletado()) {
      game.schedule(1000, { self.avanzarNivel() })
    }
  }

  method juegoTermino() {
    return nivelActual >= niveles.size()
  }

  method nivelCompletado() {
    return niveles.get(nivelActual).estaCompletado()
  }

  method avanzarNivel() {
    nivelActual = nivelActual + 1
    self.verificarProgreso() 
    self.iniciarNivelActual()
  }
}



object marcadorPuntos {
  var property position = game.at(3,12)
  var property nivelActual = null // me  obliga a darle un valor, si elimino esto y dejo solo el metodo los puntos no se muestran en pantalla

  method nivelActual(_nivel) {
    nivelActual =  _nivel
  }

  //si llamo al metodo que recibe el nivel, este metodo tambien deberia tener un parametro, cuando lo agrego este deja de mostrarse en pantalla
  method text() { 
    return "Puntos: " + nivelActual.puntajeActual()
  }
}



object marcadorVidas {
  var property position = game.at(1,12)
  var property personaje = quirrel

  method text() {
    return "Vidas: " + personaje.vidasDeQuirrel()
  }
}
