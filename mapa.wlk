import wollok.game.*
import direccionesEnemigos.*
import clases.*
object primerNivel {
const  enemigos = []
const proyectiles = []
const property spawns = #{dirUpEnemy, dirDownEnemy, dirLeftEnemy, dirRightEnemy}

method añadirEnemigo(enemigo){
    enemigos.add(enemigo)
}

method añadirProyectil(proyectil){
    proyectiles.add(proyectil)
}

}