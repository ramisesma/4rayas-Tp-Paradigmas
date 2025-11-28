import wollok.game.*
import tablero.*
import logica.*

object menu {
    const property position = game.origin()
    method image () = "menu.png"


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
