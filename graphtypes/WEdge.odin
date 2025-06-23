package graphtypes

import "core:fmt"

WEdge :: struct {
	origin:      int,
	destination: int,
	weight:      f32,
	init:        proc(edge: ^WEdge, v: int, w: int, weight: f32),
	oneEnd:      proc(edge: WEdge) -> int,
	otherEnd:    proc(edge: WEdge, v: int) -> int,
}

eInit :: proc(edge: ^WEdge, v: int, w: int, weight: f32) {
	edge.origin = v
	edge.destination = w
	edge.weight = weight
}

eOneEnd :: proc(edge: WEdge) -> int {
	return edge.origin
}

eOtherEnd :: proc(edge: WEdge, v: int) -> int {
	if (v == edge.origin) {
		return edge.destination
	} else {
		return edge.origin
	}
}

