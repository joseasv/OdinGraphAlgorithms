package graphs

import "core:fmt"
import "core:os"
import gt "graphtypes"

main :: proc() {

	graphL := gt.GraphList {
		init         = gt.gLInit,
		initWithTxt  = gt.gLInitWithTxt,
		vertexCount  = gt.gLVertexCount,
		addEdge      = gt.gLAddEdge,
		adjacent     = gt.gLAdjacent,
		showVertices = gt.gLShowVertices,
	}

	graphL->initWithTxt("graphsTxts/dag.txt")
	graphL->showVertices()

	bFT := BFTraversal {
		init      = bFTInit,
		traversal = bFTTraversal,
		pathTo    = bFTPathTo,
	}

	bFT->init(graphL, 0)
	fmt.println("Breadth-first path from 0 to 5", bFT->pathTo(5))

	graphM := gt.GraphMatrix {
		init         = gt.gMInit,
		initWithTxt  = gt.gMInitWithTxt,
		vertexCount  = gt.gMVertexCount,
		addEdge      = gt.gMAddEdge,
		adjacent     = gt.gMAdjacent,
		showVertices = gt.gMShowVertices,
	}

	graphM->initWithTxt("graphsTxts/dag.txt")
	graphM->showVertices()

	dFT := DFTraversal {
		init      = dFTInit,
		traversal = dFTTraversal,
		pathTo    = dFTPathTo,
	}

	dFT->init(graphM, 0)
	fmt.println("Depth-first path from 0 to 5", dFT->pathTo(5))

	fmt.println("\nWeighted graph")

	wGraph := gt.WGraphList {
		init         = gt.wGInit,
		initWithTxt  = gt.wGInitWithTxt,
		vertexCount  = gt.wGVertexCount,
		addEdge      = gt.wGAddEdge,
		adjacent     = gt.wGAdjacent,
		showVertices = gt.wGShowVertices,
		edges        = gt.wGEdges,
	}

	wGraph->initWithTxt("graphsTxts/undirected.txt")
	wGraph->showVertices()

	kMST := KruskalMST {
		init      = kMSTInit,
		printTree = kMSTPrintTree,
	}

	fmt.println("Kruskal")
	kMST->init(wGraph)
	kMST->printTree()


}

