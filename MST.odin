package graphs

import "core:container/priority_queue"
import "core:fmt"
import "core:math"
import "core:slice"
import gt "graphtypes"


KruskalMST :: struct {
	uF:        WQUnion,
	mst:       [dynamic]gt.WEdge,
	init:      proc(kMST: ^KruskalMST, graph: gt.WGraphList),
	printTree: proc(kMST: KruskalMST),
}

kMSTInit :: proc(kMST: ^KruskalMST, graph: gt.WGraphList) {
	edges := graph->edges()[:]

	queue: priority_queue.Priority_Queue(gt.WEdge)

	priority_queue.init(&queue, proc(a, b: gt.WEdge) -> bool {
			return a.weight < b.weight
		}, priority_queue.default_swap_proc(gt.WEdge))

	kMST.uF = WQUnion {
		init      = uFInit,
		find      = uFFind,
		join      = uFJoin,
		connected = uFConnected,
	}
	kMST.uF->init(graph->vertexCount())

	for edge in edges {

		priority_queue.push(&queue, edge)
	}

	kMST.mst = [dynamic]gt.WEdge{}

	for priority_queue.len(queue) > 0 && len(kMST.mst) < graph->vertexCount() - 1 {
		edge := priority_queue.pop(&queue)

		v := edge->oneEnd()
		w := edge->otherEnd(v)

		if !kMST.uF->connected(v, w) {
			kMST.uF->join(v, w)
			append(&kMST.mst, edge)
		}
	}
}

kMSTPrintTree :: proc(kMST: KruskalMST) {
	fmt.println("Kruskal MST")
	for edge, i in kMST.mst {
		fmt.println(i, " = [", edge->oneEnd(), "-", edge->otherEnd(edge->oneEnd()), "]")
	}
}

PrimMSTLazy :: struct {
}

PrimMSTEager :: struct {
}

