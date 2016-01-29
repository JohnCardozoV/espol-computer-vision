 //*****************************************************************//
 //            Como calibrar una c�mara en OpenCv				    // 
 //   Calibraci�n de c�mara a partir de un patr�n de calibraci�n    //
 //          Nombre: Dr. Boris Vintimilla B.   					    //
 //*****************************************************************//

//En este laboratorio se aprender� el proceso para la calibraci�n de una c�mara dado 
//un patr�n de calibraci�n. El patr�n de calibraci�n a usar es un tablero de ajedrez, 
//las librer�as de OpenCv ofrecen funciones que permiten este proceso dado este tipo  
//de patr�n de calibraci�n (tablero de ajedrez). El c�digo esta documentado de tal forma
//que el usuario pueda comprender el proceso seguido y poner en pr�ctica usando un tablero 
//de ajedrez a trav�s de una se�al de video, visualice la detecci�n de esquinas, y los
//resultados de la imagen calibrada.

//El codigo de este program usa como referencia bibliografica el siguiente enlace: http://aishack.in/tutorials/calibrating-undistorting-opencv-oh-yeah/

//librerias usadas
#include <opencv2\opencv.hpp>
#include <opencv2\highgui\highgui.hpp>
#include <vector>
#include <stdlib.h>
#include <stdio.h>


using namespace cv;
using namespace std;

int main()
{
int numBoards = 0;  //define el n�mero de tableros de ajedrez que se va a capturar
int numCornersHor; //n�mero de esquinas internas a lo ancho del tablero (pts_imgeto patr�n de calibraci�n)
int numCornersVer; //n�mero de esquinas internas a lo largo del tablero (pts_imgeto patr�n de calibraci�n)

//obtenemos estos valores por teclado
printf("Enter number of inner corners along width: ");
scanf("%d", &numCornersHor);
printf("Enter number of inner corners along height: ");
scanf("%d", &numCornersVer);
printf("Enter number of boards: ");
scanf("%d", &numBoards);

//variables adicionales que se usar�n mas adelante
int numTotalCorners = numCornersHor * numCornersVer; 
Size board_sz = Size(numCornersHor, numCornersVer);


VideoCapture capture = VideoCapture(0); //captura las im�genes con el patr�n de calibraci�n (tablero de ajedrez) desde una c�mara
//VideoCapture capture = VideoCapture("tablero.jpg"); //captura las im�genes con el patr�n de calibraci�n (tablero de ajedrez) desde un archivo de imagen

//Para cada imagen creamos una lista que contiene una lista de puntos-3D de la escena del mundo real.
//coord3D contendr� la posici�n 3D de los puntos que representa a las esquinas internas de los cuadros del tablero en la escena 3D del mundo real.
vector<vector<Point3f>> coord3D; 

//Para cada imagen creamos una lista que contiene una lista de puntos-2D en la imagen
//coord2D contendr� la posici�n 2D de los puntos que representan a las esquinas internas de los cuadros del tablero en la imagen 2D.
vector<vector<Point2f>> coord2D; 

//Una vez que se tienen las posiciones 3D y las posiciones 2D de las esquinas internas del tablero se puede calcular la relaci�n entre ambas
//NOTA: dado que usamos un tablero de ajedrez estos puntos tienen una relaci�n definida entre ellos, esto es:
//la posici�n de los puntos est� sobre las lineas y los cuadrados del tablero.
//entonces la relaci�n (esperado-real) puede ser usada para corregir la distorsi�n de la imagen.

vector<Point2f> corners; //lista temporal de las esquinas internas de los cuadrados del tablero para la imagen actual.
int successes=0; //successes es una 'bandera' que me indicar� si un tablero ha sido detetado en la imagen.

//creamos dos im�genes a usarse durante el proceso de calibraci�n
Mat image;
Mat gray_image;

//asigna cada frame de la se�al de video a la variable image (imagen a color).
capture >> image;

//pts_img contiene una lista de puntos que corresponde a las coordenadas 3D de todos las esquinas que se repiten para cada una de las im�genes.
vector<Point3f> pts_img;

//tomamos las medidas del cuadrado del tablero, lo que va de esquina a esquina (ladoy, ladox) en este caso en mil�metros.
const float ladox = 20.0;
const float ladoy = 20.0;

//inicializa la lista de puntos pts_img. Se considera que el tablero est� en el plano Z=0.
for( int i = 0; i < numCornersVer; i++ ) {
	for( int j = 0; j < numCornersHor; j++ ) {
		pts_img.push_back( Point3f(float( j*ladox ), float( i*ladoy ), 0.0f ) );
	}
}
//for(int j=0; j<numTotalCorners; j++)
    //pts_img.push_back( Point3f(float(j/numCornersHor), float(j%numCornersHor), 0.0f ) ); 

//////////////////// Bloque principal del algoritmo de calibraci�n ///////////////////////

while( successes < numBoards ) //permanecemos en el lazo siempre y cuando el n�mero de tableros que la c�mara observe sea menor al n�mero de tablero ingresado
{ 
    cvtColor(image, gray_image, CV_BGR2GRAY); //convertimos la captura en escala de grises

//El algoritmo tiene 2 etapas: 
//Etapa 1: detecta las esquinas del tablero.
//Etapa 2: proceso de calibraci�n.

////////////////////////////////////////////////////////////////////////////////////////////
//  ETAPA 1: detecta las esquinas del tablero y sus correspondientes coordenadas 2D y 3D ///
////////////////////////////////////////////////////////////////////////////////////////////

    // findChessboardCorners detecta el n�mero de esquinas en el tablero de la imagen y lo compara con el board_sz previamente definido.
    // Si estos valores son iguales devuelve 1 caso contrario 0.
	// si las esquinas fueron detectadas almacena sus coordenadas en 'corners'.
    bool found = findChessboardCorners(gray_image, board_sz, corners, CV_CALIB_CB_ADAPTIVE_THRESH | CV_CALIB_CB_FILTER_QUADS);

    if(found) //si encuentra las esquinas en la imagen
    {
		//se calculan los pixeles vecinos que conforman las esquinas con el prop�sito de mejorar la precisi�n de la calibraci�n (esto se lo hace desde la imagen de grises) 
		//estos p�xeles vecinos son llamados sub-p�xeles de la esquina detectada
		//Size define el tama�o del vecindario (sub-p�xeles) de la esquina detectada, (-1,-1) es para no definirla.
		//TermCriteria ayuda a establecer parametros como: cuantas iteraciones realiza, cantidad de error permitido.
        cornerSubPix(gray_image, corners, Size(11, 11), Size(-1, -1), TermCriteria(CV_TERMCRIT_EPS | CV_TERMCRIT_ITER, 30, 0.1));


		//dibuja las esquinas detectadas en una imagen de grises
		drawChessboardCorners(gray_image, board_sz, corners, found); 		
		drawChessboardCorners(image, board_sz, corners, found); //dibuja las esquinas en la imagen de grises
	}

	//mostramos las esquinas detectadas por pantalla
    imshow("Imagen Original 1", image);
    imshow("Imagen Gris", gray_image);
	
    capture >> image; //capturamos el siguiente frame y se repite el proceso

    int key = waitKey(1); //esperamos una tecla

    if(key==27) //si es ESC salimos del programa
        return 0;

    if(key==' ' && found!=0) //si es espacio o alcanz� un numero suficiente de frames, almacenamos las esquinas en la lista y procedemos a la calibraci�n
	{
        coord2D.push_back(corners);
        coord3D.push_back(pts_img);
        printf("Snap stored!\n");

        successes++;

        if(successes>=numBoards)
            break;
    }
}

////////////////////////////////////
//ETAPA 2: Proceso de Calibraci�n///
////////////////////////////////////

//declaramos las variables que almacenar�n los par�metros intr�nsecos: cameraMatrix y los coeficientes de distorsi�n (distCoeffs).
Mat cameraMatrix = Mat(3, 3, CV_32FC1);
Mat distCoeffs;

//declaramos las variables que almacenar�n los par�metros extr�nsecos: vectores de rotaci�n y traslaci�n respectivamente (rvecs, tvecs).
vector<Mat> rvecs; //vectores de rotaci�n
vector<Mat> tvecs; //vectores de traslaci�n

// los valores (0,0) y (1,1) representan la distancia focal a lo largo del eje X y Y respectivamente
cameraMatrix.ptr<float>(0)[0] = 1; 
cameraMatrix.ptr<float>(1)[1] = 1; 

//Esta funci�n permite la calibraci�n de la c�mara. Recibe como parametros las coordenadas 3D y 2D previamente encontradas,
//y adem�s recibe la matriz cameraMatrix que guardar� los valores intrinsecos y la matriz distCoeffs que guardar� los coeficientes de distorsi�n.
//Despu�s de la ejecuci�n de esta funci�n se obtendr�n dichas matrices llenas, as� como los vectores rvecs, tvecs de rotaci�n y traslaci�n respectivamente.
double rms = cv::calibrateCamera(coord3D, coord2D, image.size(), cameraMatrix, distCoeffs, rvecs, tvecs);

//declaro la variable en donde se almacenar� la imagen sin distorsi�n
Mat imageUndistorted; 

while(1)
{
    capture >> image;

	//una vez que tenemos los coeficientes de distorsi�n, se usa la funci�n "undistort" para calibrar las distorsiones en la imagen.
    undistort(image, imageUndistorted, cameraMatrix, distCoeffs);

	//finalmente mostramos las im�genes: original y calibrada.
    imshow("Imagen Original 2", image);
    imshow("Imagen sin Distorsi�n", imageUndistorted);
    waitKey(1);
}

capture.release();

return 0;
}