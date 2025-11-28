import logica.*
    import wollok.game.*
    object utils {
        method nuevaLista(size) {
            const lista = []
            (0..size).forEach{ n => lista.add(n)}
            return lista
        }     

        method listVacia(size) {
            const lista = []
            (0..size).forEach{_ => lista.add(0)}
            return lista
        }
        
        method obtenerFilaMatriz (fila, matriz) = (0..6).map{ c => matriz.get(c).get(fila) }
        method obtenerColumna(columna, matriz) = matriz.get(columna)
        
        // Método para obtener diagonal ascendente (de abajo-izquierda a arriba-derecha)
        method obtenerDiagonalAscendente(columna, fila, matriz) {
            // Calcular el punto de inicio de la diagonal (abajo-izquierda)
            const diferencia = columna.min(fila)
            const cInicio = columna - diferencia
            const fInicio = fila - diferencia
            
            // Calcular cuántas posiciones tiene esta diagonal
            const longitud = (6 - cInicio + 1).min(5 - fInicio + 1)
            
            // Recolectar la diagonal
            return (0..longitud-1).map{ i => matriz.get(cInicio + i).get(fInicio + i) }
        }
        
        // Método para obtener diagonal descendente (de arriba-izquierda a abajo-derecha)
        method obtenerDiagonalDescendente(columna, fila, matriz) {
            // Calcular el punto de inicio de la diagonal (arriba-izquierda)
            const diferencia = columna.min(5 - fila)
            const cInicio = columna - diferencia
            const fInicio = fila + diferencia
            
            // Calcular cuántas posiciones tiene esta diagonal
            const longitud = (6 - cInicio + 1).min(fInicio + 1)
            
            // Recolectar la diagonal
            return (0..longitud-1).map{ i => matriz.get(cInicio + i).get(fInicio - i) }
        }
    }

    object verificador {
        method verificarAlgunaCombinacion (columna, fila, matriz) = 
            horizontal.esCombinacion(columna, fila, matriz) or 
            vertical.esCombinacion(columna, fila, matriz) or
            diagonalAscendente.esCombinacion(columna, fila, matriz) or
            diagonalDescendente.esCombinacion(columna, fila, matriz)
    } 

    class Trayectoria {
        var hay4 = false
        var actual = 0

        
        method reset() {
            hay4 = false
            actual = 0
        }

        method esCombinacion(columna, fila, matriz) 
        method hayCuatroEnLinea(lista) {
            self.reset()
            lista.forEach{n => 
                    if (n == 1 ) {
                        actual +=1
                        if (actual == 4 ) hay4 = true
                    } else {
                        actual = 0 
                    }
            }
            return hay4
        }

    }

    object horizontal inherits Trayectoria {
        override method esCombinacion (columna, fila, matriz) {
            const f = utils.obtenerFilaMatriz(fila, matriz)
            return self.hayCuatroEnLinea(f)
        }
    }
    
    object vertical inherits Trayectoria {
        override method esCombinacion (columna, fila, matriz) {
            const c = utils.obtenerColumna(columna, matriz)
            return self.hayCuatroEnLinea(c)        
        }
    }
    
    object diagonalAscendente inherits Trayectoria {
        override method esCombinacion (columna, fila, matriz) {
            const d = utils.obtenerDiagonalAscendente(columna, fila, matriz)
            return self.hayCuatroEnLinea(d)
        }
    }
    
    object diagonalDescendente inherits Trayectoria {
        override method esCombinacion (columna, fila, matriz) {
            const d = utils.obtenerDiagonalDescendente(columna, fila, matriz)
            return self.hayCuatroEnLinea(d)
        }
    }