//
//  main.cpp
//  Boogle
//
//  Created by Victor Elizalde on 20/11/15.
//  Copyright © 2015 Victor Elizalde. All rights reserved.
//

#include <iostream>
#include <string>
using namespace std;

struct Hola{
  int a = 2;
}

int Puntaje(string strPalabras, int sum)
{
    if(strPalabras.length() == 3 or strPalabras.length() == 4)
        return sum += 1;
    else if(strPalabras.length() == 5)
        return sum += 2;
    else if(strPalabras.length() == 6)
        return sum += 3;
    else if(strPalabras.length() == 7)
        return sum += 5;
    else if(strPalabras.length() >= 8)
        return sum += 11;
    return sum;
}

Hola Posicion(int a)
{
  Hola i;
  i.a = a;
  return i;
}

bool ChecaAlrededor(int i, int j, string strPalabras, char matBoggle[4][4], bool matbool[4][4], int h)
{
    bool b = false;
    if(i < 0 or i > 3 or j < 0 or j > 3)
    {
        return false;
    }

        if(matbool[i+1][j-1] == false && matBoggle[i+1][j-1] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 7 << endl;
            matbool[i+1][j-1] = true;
            b = ChecaAlrededor(i+1, j-1, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

        if(matbool[i][j+1] == false && matBoggle[i][j+1] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 1 << endl;
            matbool[i][j+1] = true;
            b = ChecaAlrededor(i, j+1, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

        if(matbool[i+1][j+1] == false && matBoggle[i+1][j+1] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 2 << endl;
            matbool[i+1][j+1] = true;
            b = ChecaAlrededor(i+1, j+1, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

        if(matbool[i+1][j] == false && matBoggle[i+1][j] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 3 << endl;
            matbool[i+1][j] = true;
            b = ChecaAlrededor(i+1, j, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

        if(matbool[i][j-1] == false && matBoggle[i][j-1] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 4 << endl;
            matbool[i][j-1] = true;
            b = ChecaAlrededor(i, j-1, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

        if(matbool[i-1][j-1] == false && matBoggle[i-1][j-1] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 5 << endl;
            matbool[i-1][j-1] = true;
            b = ChecaAlrededor(i-1, j-1, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

        if(matbool[i-1][j+1] == false && matBoggle[i-1][j+1] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 6 << endl;
            matbool[i-1][j+1] = true;
            b = ChecaAlrededor(i-1, j+1, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

        if(matbool[i-1][j] == false && matBoggle[i-1][j] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 8 << endl;
            matbool[i-1][j] = true;
            b = ChecaAlrededor(i-1, j, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

        if(matbool[i+1][j-1] == false && matBoggle[i+1][j-1] == strPalabras[h])
        {
            if(h == strPalabras.length()-1)
            {
                return true;
            }
            //cout << 7 << endl;
            matbool[i+1][j-1] = true;
            b = ChecaAlrededor(i+1, j-1, strPalabras, matBoggle, matbool, h+1);
            if(b)
                return true;
        }

    return false;
}

int main()
{
    int h = 1, sum = 0, cantjuegos, juego = 1, cant = 0;
    bool matbool[4][4], Existe = true, bContinue;
    char matBoggle[4][4], letra;
    string strPalabras;

    for(int i=0; i < 4; i++)
    {
        for(int j=0; j < 4; j++)
        {
            matbool[i][j] = false;
        }
    }

    cin >> cantjuegos;

    for(int L = 0; L < cantjuegos; L++)
    {
        sum = 0;
        cant = 0;
        for(int i=0; i < 4; i++)
        {
            for(int j=0; j < 4; j++)
            {
                cin >> letra;
                matBoggle[i][j] = letra;
            }
        }

        cin >> cant;
        for(int k = 0; k < cant; k++)
        {
            cin >> strPalabras;
            bContinue = true;
            for(int i = 0; i < 4 && bContinue; i++)
            {
                for(int j = 0; j < 4 && bContinue; j++)
                {
                    if(matBoggle[i][j] == strPalabras[0])
                    {
                        h = 1;
                        matbool[i][j] = true;
                        Existe = ChecaAlrededor(i, j, strPalabras, matBoggle, matbool, h);
                        //cout << strPalabras<< " ";
                        if(Existe)
                        {
                            sum = Puntaje(strPalabras, sum);
                            bContinue = false;
                            //cout << sum;
                        }
                            //cout << endl;
                        for(int i = 0; i < 4; i++)
                        {
                            for(int j = 0; j < 4; j++)
                            {
                                matbool[i][j] = false;
                            }
                        }
                        bContinue = false;
                    }
                }
            }
        }
        cout << "Game " << juego << ": " << sum << endl;
        juego++;
    }
return 0;
}
