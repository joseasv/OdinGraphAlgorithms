package graphtypes

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

WGraphList :: struct {
	adj:          [][dynamic]WEdge,
	init:         proc(graph: ^WGraphList, vertexCount: int),
	initWithTxt:  proc(graph: ^WGraphList, filePath: string),
	vertexCount:  proc(graph: WGraphList) -> int,
	addEdge:      proc(graph: ^WGraphList, v: int, w: int, p: f32),
	adjacent:     proc(graph: WGraphList, v: int) -> [dynamic]WEdge,
	edges:        proc(graph: WGraphList) -> [dynamic]WEdge,
	showVertices: proc(graph: WGraphList),
}

wGInit :: proc(graph: ^WGraphList, vertexCount: int) {

	graph.adj = make([][dynamic]WEdge, vertexCount)
}

wGInitWithTxt :: proc(graph: ^WGraphList, filePath: string) {
	fmt.println("reading file ", filePath)
	data, ok := os.read_entire_file(filePath)
	if !ok {
		fmt.println("file not found")
		return
	}
	defer delete(data)

	lines := strings.split_lines(string(data))
	vertexCount: int
	vertexCount, ok = strconv.parse_int(lines[0])

	graph.adj = make([][dynamic]WEdge, vertexCount)

	for i in 1 ..< len(lines) {
		edgeLine := strings.split(lines[i], " ")
		if len(edgeLine) > 1 {
			v, w: int
			p: f32
			v, ok = strconv.parse_int(edgeLine[0])
			w, ok = strconv.parse_int(edgeLine[1])
			p, ok = strconv.parse_f32(edgeLine[2])
			graph->addEdge(v, w, p)
		}

	}

}

wGVertexCount :: proc(graph: WGraphList) -> int {
	return len(graph.adj)
}

wGAddEdge :: proc(graph: ^WGraphList, v: int, w: int, weight: f32) {
	edge := WEdge {
		init     = eInit,
		oneEnd   = eOneEnd,
		otherEnd = eOtherEnd,
	}

	edge->init(v, w, weight)
	append(&graph.adj[v], edge)
	append(&graph.adj[w], edge)

}

wGAdjacent :: proc(graph: WGraphList, v: int) -> [dynamic]WEdge {
	return graph.adj[v]
}

wGEdges :: proc(graph: WGraphList) -> [dynamic]WEdge {
	uniqueEdges: [dynamic]WEdge

	for i in 0 ..< graph->vertexCount() {
		adyi := graph->adjacent(i)

		for j in 0 ..< len(adyi) {
			edge := adyi[j]

			if (i == edge->oneEnd()) {
				append(&uniqueEdges, edge)
			}
		}
	}

	return uniqueEdges
}

wGShowVertices :: proc(graph: WGraphList) {
	for vertex in 0 ..< graph->vertexCount() {
		fmt.print(vertex, ": ")
		for edge in graph->adjacent(vertex) {

			fmt.print(
				"[",
				edge->oneEnd(),
				"-",
				edge->otherEnd(edge->oneEnd()),
				": ",
				edge.weight,
				"]",
			)
		}
		fmt.println()

	}
}

