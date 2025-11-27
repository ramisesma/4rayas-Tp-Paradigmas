import wollok.game.*
import tablero.*
import logica.*

object menu {
    var pantallaActual = 0 // 0: título, 1: controles/reglas, 2: juego iniciado
    const property position = game.origin()
    
    method image() {
        if (pantallaActual == 0) {
            return "menu.png" // Imagen del nombre del juego
        } else if (pantallaActual == 1) {
            return "controles.png" // Imagen con controles y reglas
        } else {
            return "menu.png" // Por si acaso, aunque no debería mostrarse
        }
    }
    
    method iniciar() {
        pantallaActual = 0
        game.addVisual(self)
        keyboard.enter().onPressDo({ self.siguientePantalla() })
    }
    
    method siguientePantalla() {
        if (pantallaActual == 0) {
            // Pasar de título a controles/reglas
            pantallaActual = 1
            game.removeVisual(self)
            game.addVisual(self)
        } else if (pantallaActual == 1) {
            // Pasar de controles a iniciar el juego
            pantallaActual = 2
            self.empezarJuego()
        }
    }
    
    method empezarJuego() {
        game.removeVisual(self)
        self.configurarJuego()
    }
    
    method configurarJuego() {
        tablero.iniciarTablero()
        logica.cargarLogica()
        self.configurarTeclas()
    }
    
    method configurarTeclas() {
        (0..6).forEach { numero => 
            keyboard.num(numero).onPressDo({ logica.quiereJugar(numero) })
        }
    }
    
    method volverAlMenu() {
        pantallaActual = 0
        game.addVisual(self)
    }
}

class Pantalla {
    const property position = game.origin()
    var property tematicaPantalla 

    method image () = tematicaPantalla + ".png"
    method mostrar () {
        game.addVisual(self)

        game.schedule(1000, {
            keyboard.r().onPressDo({ self.reiniciar() })
        })
    }
    method reiniciar() {
        game.removeVisual(self)
        logica.volverAJugar()
    }
}

// salvo mensajeColumnaOcupada, los demás se pueden abstraer en clases y crear las diferentes instancias pasandoles por Parámetro la temática
// de la pantalla: azul, rojo, empate... 
object pantallaGanadorRojo {
    const property position = game.origin()
    
    method image() = "ganadorRojo.png"
    
    method mostrar() {
        game.addVisual(self)
        
        // Configurar tecla R para reiniciar
        game.schedule(1000, {
            keyboard.r().onPressDo({ self.reiniciar() })
        })
    }
    
    method reiniciar() {
        game.removeVisual(self)
        logica.volverAJugar()
    }
}

object pantallaGanadorAzul {
    const property position = game.origin()
    
    method image() = "ganadorAzul.png"
    
    method mostrar() {
        game.addVisual(self)
        
        // Configurar tecla R para reiniciar
        game.schedule(1000, {
            keyboard.r().onPressDo({ self.reiniciar() })
        })
    }
    
    method reiniciar() {
        game.removeVisual(self)
        logica.volverAJugar()
    }
}

object pantallaEmpate {
    const property position = game.origin()
    
    method image() = "empate.png"
    
    method mostrar() {
        game.addVisual(self)
        
        // Configurar tecla R para reiniciar
        game.schedule(1000, {
            keyboard.r().onPressDo({ self.reiniciar() })
        })
    }
    
    method reiniciar() {
        game.removeVisual(self)
        logica.volverAJugar()
    }
}

object mensajeColumnaOcupada {
    const property position = game.origin()
    
    method image() = "columnaOcupada.png"
    
    method mostrar() {
        game.addVisual(self)
        // Remover el mensaje después de 3 segundos
        game.schedule(2000, {
            game.removeVisual(self)
        })
    }
}
