import wollok.game.*
import tablero.*
import logica.*

object menu {
    // var pantallaActual = 0 // 0: título, 1: controles/reglas, 2: juego iniciado
    const property position = game.origin()
    method image () = "menu.png"

    // method image() {
    //     if (pantallaActual == 0) {
    //         return "menu.png" // Imagen del nombre del juego
    //     } else if (pantallaActual == 1) {
    //         return "controles.png" // Imagen con controles y reglas
    //     } else {
    //         return "menu.png" // Por si acaso, aunque no debería mostrarse
    //     }
    // }
    
    // method iniciar() {
    //     pantallaActual = 0
    //     game.addVisual(self)
    //     keyboard.enter().onPressDo({ self.siguientePantalla() })
    // }
    
  method iniciar () {
    game.addVisual(self)
    keyboard.enter().onPressDo({ self.mostrarControles() })
    }

    method mostrarControles() {
        game.removeVisual(self)
        controles.mostrar()
    }

    method empezarJuego() {
        self.configurarJuego()
    }



    // method siguientePantalla() {
    //     if (pantallaActual == 0) {
    //         // Pasar de título a controles/reglas
    //         pantallaActual = 1
    //         game.removeVisual(self)
    //         game.addVisual(self)
    //     } else if (pantallaActual == 1) {
    //         // Pasar de controles a iniciar el juego
    //         pantallaActual = 2
    //         self.empezarJuego()
    //     }
    // }
    
    // method siguientePantalla(tematica) {
    //     tematica.mostrar()
    //     tematica.remover()
    //     self.configurarJuego()
    // }

    
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
    
    // method volverAlMenu() {
    //     pantallaActual = 0
    //     game.addVisual(self)
    // }
    method volverAlMenu() {
        self.iniciar()
    }
}

//utilizado para mostrar la imagen de los controles, después de esta imagen empezaría el juego
object controles {
    const property position = game.origin() 
    method image () = "controles.png"
    method mostrar() {
        game.addVisual(self)
        keyboard.enter().onPressDo({
            self.remover()
            menu.empezarJuego()
        })
    }
    method remover() = game.removeVisual(self)

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

class PantallaColumnaOcupada inherits Pantalla {
    override method mostrar() {
        game.addVisual(self)

        game.schedule(1000, {
            game.removeVisual(self)
        })
    }
}

// salvo mensajeColumnaOcupada, los demás se pueden abstraer en clases y crear las diferentes instancias pasandoles por Parámetro la temática
// de la pantalla: azul, rojo, empate... 



