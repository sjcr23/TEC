#include <bits/stdc++.h>
using namespace std;

int cuad(int n){return n*n;}

int main(){
	int n = 1000000;
	int r = floor(sqrt(n))+1;
	for(int a = 0; a<r; a++)
		for(int b = a; b<r; b++)
			for(int c = b; c<r; c++)
				{
				int d = round(sqrt(n-(cuad(a)+cuad(b)+cuad(c))));
					if(n == cuad(a)+cuad(b)+cuad(c)+cuad(d))
						cout<<n<<"="<<a<<"^2+"<<b<<"^2+"<<c<<"^2+"<<d<<"^2"<<endl;
				}
	return 0;
}
