import sys
sys.setrecursionlimit(100000000)


def cb1(n,k):
	if(n == k or not k):
		return 1
	return cb1(n-1,k)+cb1(n-1,k-1)


def cb2(n,k):
	if(n == k or not k):
		return 1
	s = 0
	for i in range(k+1):
		s+=cb2(n-1-i, k-i)
	return s

def fact(n):
	r = 1
	for i in range(n):
		r*=(1+i)
	return r

def cb3(n,k):
	return fact(n)//(fact(n-k)*fact(k))

def cb4(n,k):
	resp = 1
	for i in range(1,k+1):
		resp*=(n-i+1)
		resp//=i
	return resp

def cb5(n,k):
	resp = 1
	for i in range(1,min(k,n-k)+1):
		resp*=(n-i+1)
		resp//=i
	return resp


n = 100
for _ in range(10000):
	for i in range(n+1):
		cb5(n,i)

