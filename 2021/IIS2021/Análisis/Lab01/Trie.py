class Nodo:
	def __init__(self, chr: str, id: int):
		self.letra = chr
		self.fin = False
		self.hijos = [None] * 54
		self.lista_ids = [id]
	
	def sumar_id(self, id):
		if id not in self.lista_ids:
			self.lista_ids.append(id)
class Trie:
	def __init__(self):
		self.raiz = Nodo('!', 0)
	
	def insertar(self, palabra, id):
		actual = self.raiz
		for letra in palabra:
			indice = ord(letra) - ord('A')
			if actual.hijos[indice] == None:
				actual.hijos[indice] = Nodo(letra, id)
			actual = actual.hijos[indice]
			actual.sumar_id(id)
		actual.fin = True
	
	def buscar(self, palabra):
		actual = self.raiz
		for letra in palabra:
			indice = ord(letra) - ord('A')
			if actual.hijos[indice] == None:
				return False
			actual = actual.hijos[indice]
		return actual.fin
		
	def validar_carrera(self, carrera):
		actual = self.raiz
		for letra in carrera:
			indice = ord(letra) - ord('A')
			if actual.hijos[indice] == None:
				return False
			actual = actual.hijos[indice]
		
		if len(actual.lista_ids) > 1:
			return False
		return actual.lista_ids[0]