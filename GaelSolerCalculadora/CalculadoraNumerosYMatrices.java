import java.util.Scanner;

// ------------------------------------------------------------
// Programa: calculadora de números y de matrices
// Métodos solicitados: operarNumero y operarMatriz
// ------------------------------------------------------------
public class CalculadoraNumerosYMatrices {

    // Scanner compartido por todos los métodos para leer del teclado
    static Scanner sc = new Scanner(System.in);

    // operarNumero: aplica el operador op (+, -, *, /, %) a los valores
    // x y y, y regresa el valor obtenido.
    public static double operarNumero(char op, double x, double y) {
        double res;
        if (op == '+') {
            res = x + y;
        } else if (op == '-') {
            res = x - y;
        } else if (op == '*') {
            res = x * y;
        } else if (op == '/') {
            res = x / y;
        } else {
            // único caso restante: '%'
            res = x % y;
        }
        return res;
    }

    // operarMatriz: deja en r la suma (op = '+') o la resta (op = '-')
    // elemento por elemento de m1 y m2, que tienen nf filas y nc columnas.
    // Igual que en el pseudocódigo, r llega como parámetro y aquí se llena:
    // el método recibe una referencia al arreglo, así que los cambios
    // se conservan al regresar.
    public static void operarMatriz(char op, double[][] m1, double[][] m2,
                                    double[][] r, int nf, int nc) {
        int signo = 1;
        if (op == '-') {
            signo = -1;
        }
        for (int f = 0; f < nf; f++) {
            for (int c = 0; c < nc; c++) {
                r[f][c] = m1[f][c] + signo * m2[f][c];
            }
        }
    }

    // Regresa el símbolo de la operación que corresponde a cada opción del menú.
    public static char simboloDeOpcion(int n) {
        char simbolo;
        switch (n) {
            case 1:
            case 6:
                simbolo = '+';
                break;
            case 2:
            case 7:
                simbolo = '-';
                break;
            case 3:
                simbolo = '*';
                break;
            case 4:
                simbolo = '/';
                break;
            case 5:
                simbolo = '%';
                break;
            default:
                simbolo = ' ';
        }
        return simbolo;
    }

    // Imprime las opciones disponibles.
    public static void mostrarMenu() {
        System.out.println();
        System.out.println("**********************************************");
        System.out.println("*         MENÚ  -  CALCULADORA JAVA          *");
        System.out.println("**********************************************");
        System.out.println(" [1] Sumar dos números");
        System.out.println(" [2] Restar dos números");
        System.out.println(" [3] Multiplicar dos números");
        System.out.println(" [4] Dividir dos números");
        System.out.println(" [5] Obtener el módulo de dos números");
        System.out.println(" [6] Sumar dos matrices");
        System.out.println(" [7] Restar dos matrices");
        System.out.println(" [8] Terminar");
        System.out.println("**********************************************");
    }

    // Solicita uno por uno los elementos de la matriz m.
    // (Java cuenta desde 0, pero al usuario se le muestra desde 1.)
    public static void capturarMatriz(double[][] m, int nf, int nc, String etiqueta) {
        System.out.println("Captura de la matriz " + etiqueta + " (" + nf + "x" + nc + "):");
        for (int f = 0; f < nf; f++) {
            for (int c = 0; c < nc; c++) {
                System.out.print("  Fila " + (f + 1) + ", columna " + (c + 1) + ": ");
                m[f][c] = sc.nextDouble();
            }
        }
    }

    // Despliega la matriz m renglón por renglón.
    public static void imprimirMatriz(double[][] m, int nf, int nc) {
        for (int f = 0; f < nf; f++) {
            System.out.print("  | ");
            for (int c = 0; c < nc; c++) {
                System.out.print(m[f][c] + "   ");
            }
            System.out.println("|");
        }
    }

    // Pide dos valores, revisa la división entre cero y muestra el resultado.
    public static void calcularConNumeros(char op) {
        double n1, n2, r;
        System.out.print("Ingresa el primer valor: ");
        n1 = sc.nextDouble();
        System.out.print("Ingresa el segundo valor: ");
        n2 = sc.nextDouble();
        if (n2 == 0 && (op == '/' || op == '%')) {
            System.out.println("No se puede dividir ni sacar módulo entre 0.");
        } else {
            r = operarNumero(op, n1, n2);
            System.out.println("=> " + n1 + " " + op + " " + n2 + " = " + r);
        }
    }

    // Pide el tamaño, captura A y B, llama a operarMatriz y muestra el resultado.
    public static void calcularConMatrices(char op) {
        int nf, nc;

        System.out.println("Las matrices A y B tendrán el mismo tamaño.");
        System.out.println("Escribe primero el número de filas y luego el de columnas:");
        nf = sc.nextInt();
        nc = sc.nextInt();
        while (nf < 1 || nc < 1) {
            System.out.println("Tamaño inválido (el mínimo es 1x1). Escribe otra vez filas y columnas:");
            nf = sc.nextInt();
            nc = sc.nextInt();
        }

        double[][] mA = new double[nf][nc];
        double[][] mB = new double[nf][nc];
        double[][] mR = new double[nf][nc];

        capturarMatriz(mA, nf, nc, "A");
        capturarMatriz(mB, nf, nc, "B");
        operarMatriz(op, mA, mB, mR, nf, nc);

        System.out.println();
        System.out.println("Matriz resultante (A " + op + " B):");
        imprimirMatriz(mR, nf, nc);
    }

    // ------------------------------------------------------------
    // Método principal
    // ------------------------------------------------------------
    public static void main(String[] args) {
        int eleccion;
        char op;
        boolean seguir = true;

        while (seguir) {
            mostrarMenu();
            System.out.print("Opción elegida: ");
            eleccion = sc.nextInt();

            if (eleccion >= 1 && eleccion <= 7) {
                op = simboloDeOpcion(eleccion);
                if (eleccion <= 5) {
                    calcularConNumeros(op);
                } else {
                    calcularConMatrices(op);
                }
            } else {
                seguir = false;
                if (eleccion == 8) {
                    System.out.println("Cerrando la calculadora. ¡Hasta luego!");
                } else {
                    System.out.println("La opción " + eleccion + " no existe. El programa termina.");
                }
            }
        }
        sc.close();
    }
}
