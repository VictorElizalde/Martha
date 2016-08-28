#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>

using namespace std;
const int N=100, C=1000, R=10000;

struct Mapa
{
    string Location_A, Location_B;
    int Direccion; /* 1=Izquierda   2=Derecha   3=Ambos */
    int Valor;
};

struct Garage
{
    int Number_Locations, Broken_Cars, Number_Roads;
    string Location, Locations_Broken_Cars[C];
    Mapa Mapa_Carros[R];
}Prueba;

int ChecaDireccion(string sDirec, int &Valor_Ruta)
{
    int largo = sDirec.length();
    string Aux="";
    char Aux1=sDirec[2], Aux2=sDirec[3], Aux3=sDirec[4], Aux4=sDirec[5];
    switch (largo)
    {
        case 5:
            Aux = Aux1;
            Valor_Ruta = atoi(Aux.c_str());
            break;
        case 6:
            Aux = Aux + Aux1 + Aux2;
            Valor_Ruta = atoi(Aux.c_str());
            break;
        case 7:
            Aux = Aux + Aux1 + Aux2 + Aux3;
            Valor_Ruta = atoi(Aux.c_str());
            break;
        case 8:
            Aux = Aux + Aux1 + Aux2 + Aux3 + Aux4;
            Valor_Ruta = atoi(Aux.c_str());
            break;
    }

    if(sDirec[0]=='<' and sDirec[largo-1]=='>')
    {
        return 3;
    }
    else if (sDirec[0]=='<' and sDirec[largo-1]=='-')
    {
        return 1;
    }
    else if (sDirec[0]=='-' and sDirec[largo-1]=='>')
    {
        return 2;
    }
    return -1;
}

int Minimo(int a, int b)
{
    return (a<b)? a : b;
}

void Floyd(int n, int Mat_Adyacencias[N][N])
{
    for(int k=0; k<n; k++)
        for(int i=0; i<n; i++)
            for(int j=0; j<n; j++)
                Mat_Adyacencias[i][j] = Minimo(Mat_Adyacencias[i][j], Mat_Adyacencias[i][k] + Mat_Adyacencias[k][j]);
}

void EncuentraTotal(int Mat_Adyacencias[N][N], Garage Prueba, string Nombres[N])
{
    int Sumatoria=0, Inicio=0;
    for(int i=0; i<Prueba.Number_Locations; i++)
    {
        if (Prueba.Location == Nombres[i])
            Inicio = i;
    }
    for(int i=0; i<Prueba.Broken_Cars; i++)
    {
        for(int j=0; j<Prueba.Number_Locations; j++)
        {
            if(Prueba.Locations_Broken_Cars[i] == Nombres[j])
            {
                Sumatoria+= Mat_Adyacencias[Inicio][j];
                Sumatoria+= Mat_Adyacencias[j][Inicio];
            }
        }
    }
    cout << endl << "1. " << Sumatoria << endl;
}

void Imprime(int Mat_Adyacencias[N][N], Garage Prueba, string Nombres[N])
{
    for(int i=0; i<Prueba.Number_Locations; i++)
    {
        for(int j=0; j<Prueba.Number_Locations; j++)
            cout << Mat_Adyacencias[i][j] << " \t";
        cout << endl;
    }
}

void Escribe_Cantidad_Nombres(Garage Prueba, string Nombres[N])
{
    int cont=0;
    bool bandera1, bandera2;
    /*Introduce la cantidad de nombres de lugares y los escribe en un arreglo*/
    for(int i=0; i<Prueba.Number_Roads; i++)
    {
        bandera1=false; bandera2=false;
        for(int j=0; j<Prueba.Number_Locations; j++)
        {
            if(Prueba.Mapa_Carros[i].Location_A == Nombres[j])
            {
                bandera1=true;
            }
            if(Prueba.Mapa_Carros[i].Location_B == Nombres[j])
            {
                bandera2=true;
            }
        }
        if(!bandera1)
        {
            Nombres[cont]=Prueba.Mapa_Carros[i].Location_A;
            cont++;
        }
        if(!bandera2)
        {
            Nombres[cont]=Prueba.Mapa_Carros[i].Location_B;
            cont++;
        }
    }
}

void Rellena_Matriz(Garage Prueba, int Mat_Adyacencias[N][N], string Nombres[N])
{
    /*Coloca valores de posibles caminos en la matriz de adyacencias*/
    int I1, I2;
    for(int i=0; i<Prueba.Number_Roads; i++)
    {
        I1=0; I2=0;
        if(Prueba.Mapa_Carros[i].Direccion == 1)
        {
            for(int k=0; k<Prueba.Number_Locations; k++)
            {
                if(Prueba.Mapa_Carros[i].Location_A == Nombres[k])
                {
                    I1=k;
                }
                if(Prueba.Mapa_Carros[i].Location_B == Nombres[k])
                {
                    I2=k;
                }
            }
            Mat_Adyacencias[I2][I1]=Prueba.Mapa_Carros[i].Valor;
        }
        else if(Prueba.Mapa_Carros[i].Direccion == 2)
        {
            for(int k=0; k<Prueba.Number_Locations; k++)
            {
                if(Prueba.Mapa_Carros[i].Location_A == Nombres[k])
                {
                    I1=k;
                }
                if(Prueba.Mapa_Carros[i].Location_B == Nombres[k])
                {
                    I2=k;
                }
            }
            Mat_Adyacencias[I1][I2]=Prueba.Mapa_Carros[i].Valor;
        }
        else if(Prueba.Mapa_Carros[i].Direccion == 3)
        {
            for(int k=0; k<Prueba.Number_Locations; k++)
            {
                if(Prueba.Mapa_Carros[i].Location_A == Nombres[k])
                {
                    I1=k;
                }
                if(Prueba.Mapa_Carros[i].Location_B == Nombres[k])
                {
                    I2=k;
                }
            }
            Mat_Adyacencias[I1][I2]=Prueba.Mapa_Carros[i].Valor;
            Mat_Adyacencias[I2][I1]=Prueba.Mapa_Carros[i].Valor;
        }
    }
}

void Crea_Tabla_Adyacencias(Garage Prueba)
{
    int Mat_Adyacencias[N][N];
    string Nombres[4];

    Escribe_Cantidad_Nombres(Prueba, Nombres);

    /*Rellena la matriz de infinitos*/
    for(int i=0; i<Prueba.Number_Locations; i++)
    {
        for(int j=0; j<Prueba.Number_Locations; j++)
            Mat_Adyacencias[i][j]=999;
    }

    Rellena_Matriz(Prueba, Mat_Adyacencias, Nombres);
    Imprime(Mat_Adyacencias, Prueba, Nombres);
    cout << endl << endl;
    Floyd(Prueba.Number_Locations, Mat_Adyacencias);
    Imprime(Mat_Adyacencias, Prueba, Nombres);
    EncuentraTotal(Mat_Adyacencias, Prueba, Nombres);
}

int main()
{
    ifstream Archivo;
    Archivo.open("datos.txt");
    string sDirec, string1;
    int Valor_Ruta;

    Archivo >> Prueba.Number_Locations;
    Archivo >> Prueba.Broken_Cars;
    Archivo >> Prueba.Number_Roads;
    cout << Prueba.Number_Locations << " " << Prueba.Broken_Cars << " " << Prueba.Number_Roads << endl;

    /* Saca las locations de los broken cars*/
    Archivo >> Prueba.Location;
    cout << Prueba.Location << " ";
    for(int i=0; i<Prueba.Broken_Cars; i++)
    {
        Archivo >> string1;
        Prueba.Locations_Broken_Cars[i] = string1;
        cout << Prueba.Locations_Broken_Cars[i] << " ";
    }

    cout << endl << endl;
    /* Saca la informacion de las rutas A a la B y su valor */
    for(int i=0; i<Prueba.Number_Roads; i++)
    {
        Valor_Ruta=0;

        Archivo >> Prueba.Mapa_Carros[i].Location_A;
        Archivo >> sDirec;
        Prueba.Mapa_Carros[i].Direccion = ChecaDireccion(sDirec, Valor_Ruta);
        Prueba.Mapa_Carros[i].Valor = Valor_Ruta;
        Archivo >> Prueba.Mapa_Carros[i].Location_B;
        cout << Prueba.Mapa_Carros[i].Location_A << " " << sDirec << " " << Prueba.Mapa_Carros[i].Location_B << endl;
        cout << Prueba.Mapa_Carros[i].Direccion << " " << Prueba.Mapa_Carros[i].Valor << endl << endl;
    }

    /*Crea la matriz de adyacencias de los nodos y sus valores*/
    Crea_Tabla_Adyacencias(Prueba);

    Archivo.close();
    return 0;
}
