package graphs

import cq "core:container/queue"
import "core:fmt"
import gt "graphstypes"

BFTraversal :: struct {
	visited:     []bool,
	distance:    []int,
	predecessor: []int,
	init:        proc(bFT: ^BFTraversal, graph: gt.GraphList, v: int),
	traversal:   proc(bFT: ^BFTraversal, graph: gt.GraphList, origin: int),
	pathTo:      proc(bFT: BFTraversal, v: int) -> [dynamic]int,
}

bFTInit :: proc(bFT: ^BFTraversal, graph: gt.GraphList, v: int) {
	bFT.visited = make([]bool, graph->vertexCount())
	bFT.distance = make([]int, graph->vertexCount())
	bFT.predecessor = make([]int, graph->vertexCount())

	for vertex in 0 ..< graph->vertexCount() {
		bFT.predecessor[vertex] = -1
	}

	bFT->traversal(graph, v)
}

bFTTraversal :: proc(bFT: ^BFTraversal, graph: gt.GraphList, origin: int) {
	queue: cq.Queue(int)
	cq.init(&queue)

	bFT.visited[origin] = true
	cq.append(&queue, origin)
	bFT.distance[origin] = 0

	for cq.len(queue) > 0 {
		v: int = cq.pop_front(&queue)

		for w in graph->adjacent(v) {
			if bFT.visited[w] == false {
				bFT.visited[w] = true
				bFT.distance[w] = bFT.distance[v] + 1
				bFT.predecessor[w] = v
				cq.append(&queue, w)
			}
		}
	}

}

bFTPathTo :: proc(bFT: BFTraversal, v: int) -> [dynamic]int {
	path: [dynamic]int
	if (bFT.predecessor[v] != -1) {
		for i := v; i != -1; i = bFT.predecessor[i] {
			inject_at(&path, 0, i)
		}
	}


	return path
}

