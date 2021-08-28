#include <bits/stdc++.h>

using namespace std;

#define vi vector<int>
#define vvi vector<vector<int>>
#define pb push_back

int TAM;

int esSolucion(vi tablero){return tablero.size() == TAM;}

vi copia(vi tab){
	vi resp;
	for(int i = 0; i<tab.size(); i++)
		resp.pb(tab[i]);
	return resp;
}

vvi hijos(vi tab){
	int siz = tab.size();
	vvi resp;
	for(int i = 0; i < TAM; i++){
		int puedoMeterlo = 1;
		for(int j = 0 ; j < siz; j++){
			if(tab[j]==i) puedoMeterlo = 0;
			if(abs(j-siz) == abs(tab[j]-i)) puedoMeterlo = 0;
		}
		if(puedoMeterlo) {
			vi cp = copia(tab);
			cp.pb(i);
			resp.pb(cp);
		}
	}
	return resp;
}


void imprimeTab(vi tab){
	for(int i = 0; i<TAM; i++){
		for(int j = 0; j<TAM; j++){
			if(tab[i]==j)cout<<"Q";
			else cout<<".";
		}
		cout<<endl;
	}
	cout<<endl;
}


void nReinas(){ //DFS
	int sols = 0;
	stack<vi> pila;
	vi tablero;
	pila.push(tablero);
	while(!pila.empty()){
		vi tope = pila.top();
		pila.pop();
		if(esSolucion(tope)){imprimeTab(tope);sols++;}
		else{
			vvi vecinos = hijos(tope);
			for(int i = 0; i<vecinos.size(); i++){
				pila.push(vecinos[i]);
			}
		}
	}
	cout<<"Soluciones "<<sols<<endl;
}

int main(){
	for(TAM = 4; TAM<14;TAM++)
		nReinas();
	return 0;
}


