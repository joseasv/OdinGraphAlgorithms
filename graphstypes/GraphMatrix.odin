package graphstypes

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

GraphMatrix :: struct {
	adj:          [dynamic][dynamic]int,
	directed:     bool,
	init:         proc(graph: ^GraphMatrix, vNum: int, directed: bool),
	initWithTxt:  proc(graph: ^GraphMatrix, filePath: string),
	vertexCount:  proc(graph: GraphMatrix) -> int,
	addEdge:      proc(graph: ^GraphMatrix, v: int, w: int),
	showVertices: proc(graph: GraphMatrix),
	adjacent:     proc(graph: GraphMatrix, v: int) -> [dynamic]int,
}

gMInit :: proc(graph: ^GraphMatrix, vNum: int, directed: bool) {
	for row in 0 ..< vNum {
		append(&graph.adj, [dynamic]int{})
		for column in 0 ..< vNum {
			append(&graph.adj[row], 0)
		}
	}

	graph.directed = directed
}

gMInitWithTxt :: proc(graph: ^GraphMatrix, filePath: string) {
	fmt.println("reading file ", filePath)
	data, ok := os.read_entire_file(filePath)
	if !ok {
		fmt.println("file not found")
		return
	}
	defer delete(data)

	lines := strings.split_lines(string(data))
	vNum: int
	vNum, ok = strconv.parse_int(lines[0])
	isDirected: int
	isDirected, ok = strconv.parse_int(lines[1])

	graph->init(vNum, isDirected == 1 ? true : false)

	for i in 2 ..< len(lines) {
		//fmt.println(lines[i])
		edgeLine := strings.split(lines[i], " ")
		v, w: int
		v, ok = strconv.parse_int(edgeLine[0])
		w, ok = strconv.parse_int(edgeLine[1])
		graph->addEdge(v, w)
	}

}

gMVertexCount :: proc(graph: GraphMatrix) -> int {
	return len(graph.adj)
}

gMAddEdge :: proc(graph: ^GraphMatrix, v: int, w: int) {
	graph.adj[v][w] = 1
	if !graph.directed {
		graph.adj[w][v] = 1
	}
}

gMShowVertices :: proc(graph: GraphMatrix) {
	for vertex in 0 ..< len(graph.adj) {
		fmt.println(vertex, ":", graph.adj[vertex])
	}
}

gMAdjacent :: proc(graph: GraphMatrix, v: int) -> [dynamic]int {
	vAdjacent: [dynamic]int

	for column in 0 ..< len(graph.adj) {
		if graph.adj[v][column] == 1 {
			append(&vAdjacent, column)
		}
	}

	return vAdjacent
}

