package graphs

/* Standard weighted quick join-find implementation without path compression
 * The join proc would be named union but in Odin that's a reserved word
 */

WQUnion :: struct {
	elems:     []int,
	setCount:  int,
	size:      []int,
	init:      proc(uF: ^WQUnion, n: int),
	find:      proc(uF: WQUnion, p: int) -> int,
	join:      proc(uF: ^WQUnion, p: int, q: int),
	connected: proc(uF: WQUnion, p: int, q: int) -> bool,
}

uFInit :: proc(uF: ^WQUnion, n: int) {
	uF.setCount = n
	uF.elems = make([]int, n)
	uF.size = make([]int, n)

	for i in 0 ..< uF.setCount {
		uF.elems[i] = i
		uF.size[i] = 1
	}
}

uFFind :: proc(uF: WQUnion, p: int) -> int {
	indice: int = p

	for indice != uF.elems[indice] {
		indice = uF.elems[indice]
	}

	return indice
}

uFJoin :: proc(uF: ^WQUnion, p: int, q: int) {
	raizP: int = uF->find(p)
	raizQ: int = uF->find(q)

	if raizP != raizQ {
		if uF.size[raizP] < uF.size[raizQ] {
			uF.elems[raizP] = raizQ
			uF.size[raizQ] += uF.size[raizP]
		} else {
			uF.elems[raizQ] = uF.elems[raizP]
			uF.size[raizP] += uF.size[raizQ]
		}

		uF.setCount -= 1
	}
}

uFConnected :: proc(uF: WQUnion, p: int, q: int) -> bool {
	return uF->find(p) == uF->find(q)
}

