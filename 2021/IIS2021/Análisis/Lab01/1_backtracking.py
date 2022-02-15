def comparar_strings(str1, str2):
	igual = ''
	for i in range(len(str1)):
		if str1[i] == str2[i]:
			igual += str1[i]
		else:
			break
	if not igual:
		return ''
	return igual

def buscar_coincidencias(carreras, profeciones):
	cn, cc = [], []
	for profecion in range(len(profeciones)):
		for carrera in range(len(carreras)):
			for nombre in range(len(carreras[carrera])):
				n = comparar_strings(profeciones[profecion], carreras[carrera][nombre])
				if n != '' and n not in cn and carrera not in cc:
					cc.append(carrera)
					cn.append(n)
	print(cc, cn)
	return 0

def validar_coincidencias(l1, l2)

T = int(input())
assert (1 <= T <= 200)
i = 0
carreras, cvs = [], []
while i < T:
	entrada = input().split()
	P = int(entrada[0])
	R = int(entrada[1])
	assert (1 <= P <= 30) and (1 <= R <= 1000)
	# Recopilación de datos de las carreras
	for carrera in range(P):
		cantidad = int(input())
		nombres = input().split()
		assert (len(nombres) == cantidad)
		carreras.append(nombres)
	
	# Recopilación de datos de los CVs.
	for j in range(R):
		p = []
		cantidad = int(input())
		profesiones = input().split()
		assert (len(profesiones) == cantidad)
		buscar_coincidencias(carreras, profesiones)
	i += 1
	
