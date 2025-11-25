
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
    }

    object verificador {
        method verificarAlgunaCombinacion (columna, fila, matriz) = horizontal.esCombinacion(columna, fila, matriz) or vertical.esCombinacion(columna, fila, matriz) 
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

    object diagonales inherits Trayectoria{
        //debe ser recursivo, si la columna no es la 6ta o la fila la 5ta, se volvería a llamar y buscar el valor de esa posición
        method obtenerLaSiguiente(columna, fila, matriz, _diagonal) {
            var c 
            var v 
            if (columna == 6 or fila == 5) {
                c = utils.obtenerColumna(columna, matriz)
                v = c.get(fila)
                _diagonal.add(v)
                return _diagonal
            } else {
                c = utils.obtenerColumna(columna+1, matriz)
                v = c.get(fila+1)
                _diagonal.add(v)
                return self.obtenerLaSiguiente(columna+1, fila+1, matriz, _diagonal)
            }       

        }
    
        override method esCombinacion (columna, fila, matriz) {
            var diagonal = []
            //esta lista binaria que generamos, va a tener solo 6 elementos o depende
            // para la primera diagonal (de izquierda a derecha desde abajo)
            //voy a necesitar saber en que punto x, y de la matriz estoy y de ahí calcular n en escalera
                //estoy por ejemplo en la segunda columna (1) y 6ta fila (6) .:.
                //Desplazarse hacia abajo e izquierda el número de columnas 
            //la inicial, sea cual sea el caso, ya hice el desplazamiento hacia la izquierda 

            const colInicial  = utils.obtenerColumna(0, matriz)           
            var v = colInicial.get(fila-columna) // con esto ya me debería haber desplazado hacia abajo el número de veces que me desplace para la columna 
            diagonal.add(v) //agrego el binario incial a la diagonal
            diagonal = self.obtenerLaSiguiente(0, fila-columna, matriz, diagonal)
            return self.hayCuatroEnLinea(diagonal)
        }

        //debe retornar el número de fila, ya que la columna va a ser siempre 0
        method calcularInicioDiagonal (c, f)  = if (c > 0 and f > 0) self.calcularInicioDiagonal(c-1, f-1) else f 
    }

