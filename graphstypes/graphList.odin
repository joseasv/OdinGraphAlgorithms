package graphstypes

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

GraphList :: struct {
	adj:          [][dynamic]int,
	directed:     bool,
	init:         proc(graph: ^GraphList, vNum: int, isDirected: bool),
	initWithTxt:  proc(graph: ^GraphList, filePath: string),
	vertexCount:  proc(graph: GraphList) -> int,
	addEdge:      proc(graph: ^GraphList, v: int, w: int),
	adjacent:     proc(graph: GraphList, v: int) -> [dynamic]int,
	showVertices: proc(graph: GraphList),
}

gLInit :: proc(graph: ^GraphList, vNum: int, isDirected: bool) {

	graph.adj = make([][dynamic]int, vNum)

	graph.directed = isDirected
}

gLInitWithTxt :: proc(graph: ^GraphList, filePath: string) {
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
	if isDirected == 1 {
		graph.directed = true
	} else {
		graph.directed = false
	}


	graph.adj = make([][dynamic]int, vNum)

	for i in 2 ..< len(lines) {
		//fmt.println(lines[i])
		edgeLine := strings.split(lines[i], " ")
		v, w: int
		v, ok = strconv.parse_int(edgeLine[0])
		w, ok = strconv.parse_int(edgeLine[1])
		graph->addEdge(v, w)
	}

}

gLVertexCount :: proc(graph: GraphList) -> int {
	return len(graph.adj)
}

gLAddEdge :: proc(graph: ^GraphList, v: int, w: int) {
	append(&graph.adj[v], w)
	if !graph.directed {
		append(&graph.adj[w], v)
	}
}

gLAdjacent :: proc(graph: GraphList, v: int) -> [dynamic]int {
	return graph.adj[v]
}

gLShowVertices :: proc(graph: GraphList) {
	for vertex in 0 ..< graph->vertexCount() {
		fmt.println(vertex, ": ", graph.adj[vertex])
	}
}

