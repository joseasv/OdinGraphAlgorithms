package graphs

import "core:fmt"
import gt "graphstypes"

DFTraversal :: struct {
	visited:     [dynamic]bool,
	distance:    [dynamic]int,
	predecessor: [dynamic]int,
	init:        proc(dFT: ^DFTraversal, graph: gt.GraphMatrix, origin: int),
	traversal:   proc(dFT: ^DFTraversal, graph: gt.GraphMatrix, v: int),
	pathTo:      proc(dFT: DFTraversal, v: int) -> [dynamic]int,
}

dFTInit :: proc(dFT: ^DFTraversal, graph: gt.GraphMatrix, origin: int) {
	for vertex in 0 ..< graph->vertexCount() {
		append(&dFT.visited, false)
		append(&dFT.distance, 0)
		append(&dFT.predecessor, -1)
	}

	dFT->traversal(graph, origin)
}

dFTTraversal :: proc(dFT: ^DFTraversal, graph: gt.GraphMatrix, v: int) {
	dFT.visited[v] = true
	for w in graph->adjacent(v) {
		if dFT.visited[w] == false {
			dFT.distance[w] = dFT.distance[v] + 1
			dFT.predecessor[w] = v
			dFT->traversal(graph, w)
		}
	}
}

dFTPathTo :: proc(dFT: DFTraversal, v: int) -> [dynamic]int {
	camino: [dynamic]int

	if (dFT.visited[v] != false) {
		for i := v; i != -1; i = dFT.predecessor[i] {
			inject_at(&camino, 0, i)
		}
	}

	return camino
}

