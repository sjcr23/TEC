import Trie as t

arbol = t.Trie()
T = int(input())
assert (1 <= T <= 200)
i = 0
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
		for nombre in nombres:
			arbol.insertar(nombre, carrera)
	
	# Recopilación de datos de los CVs.
	for cvs in range(R):
		cantidad = int(input())
		profesiones = input().split()
		assert (len(profesiones) == cantidad)
		validos = []
		for descripcion in profesiones:
			caso = arbol.validar_carrera(descripcion)
			if caso and caso not in validos:
				validos.append(caso)
		print(len(validos))
	i += 1
# 1
# 3 4
# 2
# dentist dntist
# 2
# inga ingena
# 3
# doctor phd dr
# 3
# salmon sin dr
# 4
# inga ingen ingena ing
# 2
# ph ing
# 2
# d perm

