package graphs

import "core:fmt"
import gt "graphstypes"

DFTraversal :: struct {
	visited:     []bool,
	distance:    []int,
	predecessor: []int,
	init:        proc(dFT: ^DFTraversal, graph: gt.GraphMatrix, origin: int),
	traversal:   proc(dFT: ^DFTraversal, graph: gt.GraphMatrix, v: int),
	pathTo:      proc(dFT: DFTraversal, v: int) -> [dynamic]int,
}

dFTInit :: proc(dFT: ^DFTraversal, graph: gt.GraphMatrix, origin: int) {

	dFT.visited = make([]bool, graph->vertexCount())
	dFT.distance = make([]int, graph->vertexCount())
	dFT.predecessor = make([]int, graph->vertexCount())

	for vertex in 0 ..< graph->vertexCount() {
		dFT.predecessor[vertex] = -1
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

