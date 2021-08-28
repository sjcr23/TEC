#include <bits/stdc++.h>
using namespace std;

#define ll long long int
#define mat vector<vector<ll>>
#define vi vector<ll>
#define pb push_back
#define MOD 1000000007


mat multiplicar_matrices(mat m1, mat m2){
	int FILAS = m1.size();
	int COLUMNAS = m2[0].size();
	int VECTOR = m2.size();
	mat nueva_matriz;
	
	for(int i = 0; i < FILAS; i++){
		vi fila;
		for(int j = 0; j < COLUMNAS; j++){
			fila.pb(0);
		}
		nueva_matriz.pb(fila);
	}

	for(int i = 0; i < FILAS; i++){
		for (int j = 0; j < COLUMNAS; j++){
			for (int k = 0; k < VECTOR; k++){
				nueva_matriz[i][j] += m1[i][k]*m2[k][j];
				nueva_matriz[i][j] %= MOD;
			}
		}
	}
	return nueva_matriz;
}


mat potencia_logaritmica(mat m, int exp){
	mat resultado;

	if(exp != 1){
		resultado = potencia_logaritmica(m, exp/2);
		resultado = multiplicar_matrices(resultado, resultado);

		if(exp & 1){
			resultado = multiplicar_matrices(m, resultado);
		}
		return resultado;
	}
	else{
		return m;
	}
}


ll fibonacci(int n){
	mat mat_fibo;
	vi f1; vi f2;
	f1.pb(0);
	f1.pb(1);
	f2.pb(1);
	f2.pb(1);
	mat_fibo.pb(f1);
	mat_fibo.pb(f2);
	mat fib = potencia_logaritmica(mat_fibo, n);
	return fib[0][1];
}


ll fibonacci_terrible(int n){
	return (!n || n == 1)? n : fibonacci_terrible(n-1)+fibonacci_terrible(n-2);
}


ll fibonacci_iterativo(int n){
	if(n != 1){
		ll ult = 1;
		ll ante = 0;

		for(int i = 1; i<n; i++){
			ult += ante;
			ante = (MOD+(ult-ante))%MOD;
			ult %= MOD;
		}
		return ult % MOD;
	}
	else{
		return 1;
	}
}


int main(){
	cout<<fibonacci(100000000)<<endl;
	return 0;
}



