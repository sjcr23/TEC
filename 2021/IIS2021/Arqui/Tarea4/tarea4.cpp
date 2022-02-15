#include <string>
#include <iostream>
#include <bits/stdc++.h>
#include <omp.h>
#include <unistd.h>
#define THREAD_NUM 4

using namespace std;


class Tabla{
    public:
        string nombre;
        string filas[10] = {"Mes0", "Mes1", "Mes2", "Mes3", "Mes4", "Mes5", "Mes6", "Mes7", "Mes8", "Mes9"};
        string columnas[10] = {"Alajuela", "La Concepción", "Turrúcares", "Hatillo", "La Uruca", "Río Segundo", "Liberia", "Cariari", "Cartago", "_eredia"};

        int mat[10][10] = { 
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        };

        Tabla(string name){
            nombre = name;
        }

        void generar_casos(){
            for (int i = 0; i < 10; i++){
                for (int j = 0; j < 10; j++){
                    int num = rand()% 100001;
                    mat[i][j] = num;
                }
            }
        }
        
        void imprimir_tabla(){
            cout << endl << "\t\t\t\t\t\t\t\t\t" << nombre << endl;
            cout << "\t_________________________________________________________________________________________________________________________________________________________________________" << endl << endl;
            cout << "\t\t     " << columnas[0] << "\t   " << columnas[1] << "    " << columnas[2] << "\t     " << columnas[3] << "\t     " << columnas[4] << "\t   " << columnas[5] << "\t     " << columnas[6] << "\t     " << columnas[7] << "\t      " << columnas[8] << "\t      " << columnas[9] << endl;
            cout << "\t_________________________________________________________________________________________________________________________________________________________________________";

            for (int i = 0; i < 10; i++){    
                cout << endl << "\t" << "| " << filas[i] << "\t";
                
                for (int j = 0; j < 10; j++){
                    cout << "|\t" << mat[i][j]  << "\t";
                }
                
                cout << "| ";
            }

            cout << endl << endl;
        }

        void desgloce_meses(int meses[10]){
            for (int i = 0; i < 10; i++){
                meses[i] = total_por_mes(filas[i]);
            }
        }
        int total_por_mes(string mes){
            int total = 0;
            int mes_id;

            for (int i = 0; i < 10; i++){
                if (filas[i] == mes){
                    mes_id = i;
                    break;
                }
            }

            for (int i = 0; i < 10; i++){
                if (mes_id == i){
                    for (int j = 0; j < 10; j++){
                        total += mat[i][j];
                    }
                    break;
                }
            }
            return total;
        }


        void desgloce_ciudades(int ciudades[10]){
            for (int i = 0; i < 10; i++){
                ciudades[i] = total_por_ciudad(columnas[i]);
            }
        }
        int total_por_ciudad(string ciudad){
            int total = 0;
            int ciudad_id;

            for (int i = 0; i < 10; i++){
                if (columnas[i] == ciudad){
                    ciudad_id = i;
                    break;
                }
            }
            
            for (int i = 0; i < 10; i++){
                for (int j = 0; j < 10; j++){
                    if (ciudad_id == j){
                        total += mat[i][j];
                        continue;
                    }
                }
            }
            return total;
        }

};

void procedimiento_serial(Tabla tabla, int meses[10], int ciudades[10]){

    int meses_en_total = 0;
    int ciudad_en_total = 0;
    tabla.desgloce_meses(meses);
    tabla.desgloce_ciudades(ciudades);
    cout << endl;

    for (int i = 0; i < 10; i++){
        meses_en_total += meses[i];
        ciudad_en_total += ciudades[i];

        cout << "\t Total de casos en el mes <" << tabla.filas[i] << ">: " << meses[i] << "   |   Total de casos en la zona <" << tabla.columnas[i] << ">: \t" << ciudades[i] << endl;
    }

    cout << endl << "\t Total de casos por meses : \t  " << meses_en_total << "  |   Total de casos por zonas : \t\t\t" << ciudad_en_total << endl << endl;

}

void procedimiento_paralelizado(Tabla tabla, int meses[10], int ciudades[10]){

    int meses_en_total = 0;
    int ciudad_en_total = 0;
    tabla.desgloce_meses(meses);
    tabla.desgloce_ciudades(ciudades);
    cout << endl;

    #pragma omp parallel for
    for (int i = 0; i < 10; i++){


        #pragma omp critical
        {
            meses_en_total += meses[i];
            cout << "\t Total de casos en el mes <" << tabla.filas[i] << ">: " << meses[i];
        }

        #pragma omp critical
        {
            ciudad_en_total += ciudades[i];
            cout << "   |   Total de casos en la zona <" << tabla.columnas[i] << ">: \t" << ciudades[i] << endl;
        }

    }

    cout << endl << "\t Total de casos por meses : \t  " << meses_en_total << "  |   Total de casos por zonas : \t\t\t" << ciudad_en_total << endl << endl;

}


int main(){
    string tabla = "REPORTE DE CASOS COVID-19 EN LOS PRIMEROS 10 MESES";   
    int total_meses[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    int total_ciudades[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    Tabla mi_tabla = Tabla(tabla);

    mi_tabla.generar_casos();
    mi_tabla.imprimir_tabla();
    
    procedimiento_serial(mi_tabla, total_meses, total_ciudades);
    //procedimiento_paralelizado(mi_tabla, total_meses, total_ciudades);

    return 0;
}