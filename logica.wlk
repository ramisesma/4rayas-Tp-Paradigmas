import wollok.game.*
import tablero.*
import utils.*
import menu.* 

//logica del juego
object logica {
    const casillerosLibres  = new Dictionary ()
    const columnasOcupadas = []
    var juegoActivo = false
    const pantallaEmpate = new Pantalla (tematicaPantalla = "empate")
    const pantallaColumnaOcupada = new PantallaColumnaOcupada (tematicaPantalla = "columnaOcupada")

    var jugadores = [
        new Jugador (color = "rojo", tematica = new Pantalla (tematicaPantalla = "ganadorRojo")),
        new Jugador (color ="azul", tematica = new Pantalla (tematicaPantalla = "ganadorAzul"))
    ]
    var indiceTurnos = 0


    method cargarLogica() {
        self.cargarCasillerosLibres()
        jugadores.forEach{j => j.cargarPosiciones()}
        juegoActivo = true 
    }


    method cargarCasillerosLibres () {
        (0..6).forEach{n =>
            casillerosLibres.put(n, utils.nuevaLista(5))
        }
    }

    method estaOcupada (columna) = columnasOcupadas.contains(columna)

    method ocuparColumna(columna) {
        columnasOcupadas.add(columna)
    }


    method ocuparFila(columna, fila) {
        utils.obtenerColumna(columna, casillerosLibres).remove(fila)
    }

    method quiereJugar (columna) {
        if (juegoActivo) {
            if (self.estaOcupada(columna)) {
                pantallaColumnaOcupada.mostrar()
            } else {
                self.juegaTurno(self.jugadorActual(), columna)
            }
        }
    }

    method juegaTurno(_jugadorActual, columna) {
        const fila = utils.obtenerColumna(columna, casillerosLibres).last()
        _jugadorActual.guardarPosicion(columna, fila)

        if (_jugadorActual.esGanador(columna, fila)) {
            console.println("Es ganador el jugador: " + _jugadorActual.color())
            juegoActivo = false // desactivar el juego cuando hay ganador
            self.mostrarPantallaGanador(_jugadorActual.tematica())
        } else {
            self.ocuparFila(columna, fila)
            // Verificar si la columna está llena
            if (utils.obtenerColumna(columna, casillerosLibres).isEmpty()) {
                self.ocuparColumna(columna)
            }
            // verificar si hay empate (todas las columnas ocupadas)
            if (columnasOcupadas.size() == 7) {
                console.println("¡Empate!")
                juegoActivo = false // desactivar el juego cuando hay empate
                pantallaEmpate.mostrar()
            } else {
                self.cambiarTurno()
            }
        }
    }


    method mostrarPantallaGanador(tematica) {
        tematica.mostrar()
    }

    //manejo de turnos
    method cambiarTurno() {
        indiceTurnos = (indiceTurnos+1) % jugadores.size()
    }

    method jugadorActual () = jugadores.get(indiceTurnos)

    //limpia el estado interno de la logica del juego, en caso de que el juego tenga un ganador
    method limpiar () {
        casillerosLibres.clear()
        columnasOcupadas.clear()
        jugadores.forEach{j => j.limpiar()}
        indiceTurnos = 0
        juegoActivo = false // Desactivar el juego al limpiar
    }

    method volverAJugar () {
        self.limpiar()
        tablero.volverAJugar()
        self.volverACrear()
    }

    method volverACrear() {
        self.cargarLogica()
        tablero.iniciarTablero()
    }
}

class Jugador{
    var property color 
    var property tematica
    const posicionesOcupadas  = new Dictionary ()

    method cargarPosiciones() {
        (0..6).forEach{n =>
            posicionesOcupadas.put(n, utils.listVacia(5))
        }
    }

    method guardarPosicion(columna, fila) {
        tablero.mostrarJugada(color, columna, fila)
        self.setearPosicionEnDiccionario(columna, fila)
    }

    method setearPosicionEnDiccionario(columna, fila) {
        const listaVieja = posicionesOcupadas.get(columna)
        const nuevaLista = []
        (0..listaVieja.size() - 1).forEach { i =>
            if (i == fila) {
                nuevaLista.add(1)
            } else {
                nuevaLista.add(listaVieja.get(i))
            }
        }
        posicionesOcupadas.put(columna, nuevaLista)
    }

    method esGanador (columna, fila) = verificador.verificarAlgunaCombinacion(columna, fila, posicionesOcupadas)

    method estaOcupada(columna, fila) {
        const lista = posicionesOcupadas.get(columna)
        return lista.get(fila) == 1
    }

    //limpia el estado interno de un jugador, el diccionario de posiciones ocupadas
    method limpiar() {
        posicionesOcupadas.clear()
    }
}

class Color {
    var property color
    var property position
    method image () = color + ".png"
}