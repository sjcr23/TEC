#include <bits/stdc++.h>
using namespace std;

#define ll long long int
#define ld long double
#define err 0.00000000001


//Exponenciacion logaritmica
ll pot(int a, int n){
	if(!n) return 1;
	ll r = pot(a,n/2);
	r*=r;
	if(n%2) r*=a;
	return r;
}

ld cuad(ld v){return v*v;}

//Biseccion para raiz 
ld raizCuad(int n){
	ld sup = n;
	ld inf = 0.0;
	ld m = sup/2;
	while(!(cuad(m-err)< n && cuad(m+err)>n)){
		m = (sup+inf)/2;
		if(cuad(m)>n) sup = m;
		else inf = m;
	}
	return m;
}

int main(){
//	for(int i = 0; i<5; i++,cout<<(1<<i)<<" - ");
	cout<<pot(2,15)<<" "<<(1<<15)<<endl;
	cout<<raizCuad(2)<<" "<<sqrt(2)<<endl;
}

