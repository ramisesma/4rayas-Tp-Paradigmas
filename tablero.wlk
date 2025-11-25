import logica.*
import wollok.game.*

//cosas visuales + tablero
object tablero {
	const property image = "tableroRojo.png"
	const property position = game.origin()

	const posicionesTablero = [	
    	// Fila 5 (superior)
		[ game.at(0,10), game.at(2,10), game.at(4,10), game.at(6,10), game.at(8,10), game.at(10,10), game.at(12,10) ],

		// Fila 4
		[ game.at(0,8), game.at(2,8), game.at(4,8), game.at(6,8), game.at(8,8), game.at(10,8), game.at(12,8) ],

		// Fila 3
		[ game.at(0,6), game.at(2,6), game.at(4,6), game.at(6,6), game.at(8,6), game.at(10,6), game.at(12,6) ],

		// Fila 2
		[ game.at(0,4), game.at(2,4), game.at(4,4), game.at(6,4), game.at(8,4), game.at(10,4), game.at(12,4) ],

		// Fila 1
		[ game.at(0,2), game.at(2,2), game.at(4,2), game.at(6,2), game.at(8,2), game.at(10,2), game.at(12,2) ],

		// Fila 0 (inferior)
		[ game.at(0,0), game.at(2,0), game.at(4,0), game.at(6,0), game.at(8,0), game.at(10,0), game.at(12,0) ]
	]

	//lista de posiciones game.at, la cuál nos va a servir para después limpiar todas las visuales en caso de finalzar el juego
	const posicionesOcupadas = []

	method iniciarTablero () {
	/* CONFIGURACIONES DEL TABLERO */
		// self.cargarPosiciones()
		// game.addVisual(self)

	}

	method mostrarJugada(nombre, columna, fila) {
		const c = new Color(color = nombre, position = self.obtenerCoordenadas(columna, fila))
		game.addVisual(c)
		posicionesOcupadas.add(c)
	}
	method mostrarJugadaTest() {
		game.addVisual(new Color (color = "rojo", position = self.obtenerCoordenadas(6, 5) ))
	}
	method mostrarColumnaTest(columna) {
		game.addVisual(new Color(color = "azul", position = self.obtenerCoordenadas(columna, 2)))
	}


	method obtenerCoordenadas(columna, fila) {
		if(!columna.between(0, 6) or !fila.between(0, 5)) { 
			throw new DomainException(message = "Número inválido")
		}
		return posicionesTablero.get(fila).get(columna)
	}
	method imprimirGanador(_color) {
		game.say(new Color (color = _color, position = game.at(20,30)), "Ganador el color: " + _color)
	}

	//debería limpiar las visuales de todas las fichas
	method volverAJugar (){
		posicionesOcupadas.forEach{p => game.removeVisual(p)}
		posicionesOcupadas.clear()
	}
}

