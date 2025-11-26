import wollok.game.*
import tablero.*
import logica.*

object menu {
    var property enMenu = true
    const property position = game.origin()
    
    method image() = "menu.png" // Asegúrate de tener esta imagen en assets
    
    method iniciar() {
        game.addVisual(self)
        keyboard.enter().onPressDo({ self.empezarJuego() })
    }
    
    method empezarJuego() {
        if (enMenu) {
            enMenu = false
            game.removeVisual(self)
            self.configurarJuego()
        }
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
        enMenu = true
        game.addVisual(self)
    }
}

object pantallaGanadorRojo {
    const property position = game.origin()
    
    method image() = "ganadorRojo.png"
    
    method mostrar() {
        game.addVisual(self)
        
        /*// Mostrar mensaje de ganador
        game.schedule(500, {
            game.say(self, "¡Ganó el jugador rojo! Presiona R para reiniciar")
        })*/
        
        // Configurar tecla R para reiniciar
        game.schedule(2000, {
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
        
        /*// Mostrar mensaje de ganador
        game.schedule(500, {
            game.say(self, "¡Ganó el jugador azul! Presiona R para reiniciar")
        })*/
        
        // Configurar tecla R para reiniciar
        game.schedule(2000, {
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
        
        /*// Mostrar mensaje de empate
        game.schedule(500, {
            game.say(self, "¡Empate! Presiona R para reiniciar")
        })*/
        
        // Configurar tecla R para reiniciar
        game.schedule(2000, {
            keyboard.r().onPressDo({ self.reiniciar() })
        })
    }
    
    method reiniciar() {
        game.removeVisual(self)
        logica.volverAJugar()
    }
}