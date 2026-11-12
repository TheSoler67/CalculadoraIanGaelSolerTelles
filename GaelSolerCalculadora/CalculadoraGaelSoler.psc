// ------------------------------------------------------------
// Programa: calculadora de números y de matrices
// Módulos solicitados: OperarNumero (Funcion) y OperarMatriz (SubProceso)
// ------------------------------------------------------------

// OperarNumero: aplica el operador op (+, -, *, /, %) a los valores
// x y y, y regresa el valor obtenido.
Funcion res <- OperarNumero(op, x, y)
	Definir res Como Real;
	Si op = "+" Entonces
		res <- x + y;
	SiNo
		Si op = "-" Entonces
			res <- x - y;
		SiNo
			Si op = "*" Entonces
				res <- x * y;
			SiNo
				Si op = "/" Entonces
					res <- x / y;
				SiNo
					// único caso restante: "%"
					res <- x MOD y;
				FinSi
			FinSi
		FinSi
	FinSi
FinFuncion

// OperarMatriz: deja en R la suma (op = "+") o la resta (op = "-")
// elemento por elemento de M1 y M2, que tienen nf filas y nc columnas.
// Como en PSeInt una función no puede regresar un arreglo, R se manda
// como parámetro (los arreglos pasan por referencia) y aquí se llena.
SubProceso OperarMatriz(op, M1, M2, R, nf, nc)
	Definir f, c, signo Como Entero;
	signo <- 1;
	Si op = "-" Entonces
		signo <- -1;
	FinSi
	Para f <- 1 Hasta nf Con Paso 1 Hacer
		Para c <- 1 Hasta nc Con Paso 1 Hacer
			R[f,c] <- M1[f,c] + signo * M2[f,c];
		FinPara
	FinPara
FinSubProceso

// Regresa el símbolo de la operación que corresponde a cada opción del menú.
Funcion simbolo <- SimboloDeOpcion(n)
	Definir simbolo Como Caracter;
	Segun n Hacer
		1, 6:
			simbolo <- "+";
		2, 7:
			simbolo <- "-";
		3:
			simbolo <- "*";
		4:
			simbolo <- "/";
		5:
			simbolo <- "%";
		De Otro Modo:
			simbolo <- "";
	FinSegun
FinFuncion

// Imprime las opciones disponibles.
SubProceso MostrarMenu()
	Escribir "";
	Escribir "**********************************************";
	Escribir "*        MENÚ  -  CALCULADORA PSEINT         *";
	Escribir "**********************************************";
	Escribir " [1] Sumar dos números";
	Escribir " [2] Restar dos números";
	Escribir " [3] Multiplicar dos números";
	Escribir " [4] Dividir dos números";
	Escribir " [5] Obtener el módulo de dos números";
	Escribir " [6] Sumar dos matrices";
	Escribir " [7] Restar dos matrices";
	Escribir " [8] Terminar";
	Escribir "**********************************************";
FinSubProceso

// Solicita uno por uno los elementos de la matriz M.
SubProceso CapturarMatriz(M, nf, nc, etiqueta)
	Definir f, c Como Entero;
	Escribir "Captura de la matriz ", etiqueta, " (", nf, "x", nc, "):";
	Para f <- 1 Hasta nf Con Paso 1 Hacer
		Para c <- 1 Hasta nc Con Paso 1 Hacer
			Escribir Sin Bajar "  Fila ", f, ", columna ", c, ": ";
			Leer M[f,c];
		FinPara
	FinPara
FinSubProceso

// Despliega la matriz M renglón por renglón.
SubProceso ImprimirMatriz(M, nf, nc)
	Definir f, c Como Entero;
	Para f <- 1 Hasta nf Con Paso 1 Hacer
		Escribir Sin Bajar "  | ";
		Para c <- 1 Hasta nc Con Paso 1 Hacer
			Escribir Sin Bajar M[f,c], "   ";
		FinPara
		Escribir "|";
	FinPara
FinSubProceso

// Pide dos valores, revisa la división entre cero y muestra el resultado.
SubProceso CalcularConNumeros(op)
	Definir n1, n2, r Como Real;
	Escribir Sin Bajar "Ingresa el primer valor: ";
	Leer n1;
	Escribir Sin Bajar "Ingresa el segundo valor: ";
	Leer n2;
	Si n2 = 0 && (op = "/" || op = "%") Entonces
		Escribir "No se puede dividir ni sacar módulo entre 0.";
	SiNo
		r <- OperarNumero(op, n1, n2);
		Escribir "=> ", n1, " ", op, " ", n2, " = ", r;
	FinSi
FinSubProceso

// Pide el tamaño, captura A y B, llama a OperarMatriz y muestra el resultado.
SubProceso CalcularConMatrices(op)
	Definir nf, nc Como Entero;
	Definir mA, mB, mR Como Real;

	Escribir "Las matrices A y B tendrán el mismo tamaño.";
	Escribir "Escribe primero el número de filas y luego el de columnas:";
	Leer nf, nc;
	Mientras nf < 1 || nc < 1 Hacer
		Escribir "Tamaño inválido (el mínimo es 1x1). Escribe otra vez filas y columnas:";
		Leer nf, nc;
	FinMientras

	Dimension mA[nf, nc], mB[nf, nc], mR[nf, nc];

	CapturarMatriz(mA, nf, nc, "A");
	CapturarMatriz(mB, nf, nc, "B");
	OperarMatriz(op, mA, mB, mR, nf, nc);

	Escribir "";
	Escribir "Matriz resultante (A ", op, " B):";
	ImprimirMatriz(mR, nf, nc);
FinSubProceso

// ------------------------------------------------------------
// Algoritmo principal
// ------------------------------------------------------------
Algoritmo CalculadoraNumerosYMatrices
	Definir eleccion Como Entero;
	Definir op Como Caracter;
	Definir seguir Como Logico;

	seguir <- Verdadero;
	Mientras seguir Hacer
		MostrarMenu();
		Escribir Sin Bajar "Opción elegida: ";
		Leer eleccion;

		Si eleccion >= 1 && eleccion <= 7 Entonces
			op <- SimboloDeOpcion(eleccion);
			Si eleccion <= 5 Entonces
				CalcularConNumeros(op);
			SiNo
				CalcularConMatrices(op);
			FinSi
		SiNo
			seguir <- Falso;
			Si eleccion = 8 Entonces
				Escribir "Cerrando la calculadora. ¡Hasta luego!";
			SiNo
				Escribir "La opción ", eleccion, " no existe. El programa termina.";
			FinSi
		FinSi
	FinMientras
FinAlgoritmo
