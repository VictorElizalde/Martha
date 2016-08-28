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

/*
Title: ChecaDireccion
Input: string sDirec, int &Valor_Ruta
Output: Tu jefa
Description: Hace algo bien mamalon
Author: Victor Elizalde
*/
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

/*
Title: Minimo
Input: int a, int b
Output: 3
Description: Saca el minimo
Author: Victor Elizalde
*/
int Minimo(int a, int b)
{
    return (a<b)? a : b;
}

