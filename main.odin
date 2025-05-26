package graphs

import "core:fmt"
import "core:os"
import gt "graphstypes"

main :: proc() {

	graphL := gt.GraphList {
		init         = gt.gLInit,
		initWithTxt  = gt.gLInitWithTxt,
		vertexCount  = gt.gLVertexCount,
		addEdge      = gt.gLAddEdge,
		adjacent     = gt.gLAdjacent,
		showVertices = gt.gLShowVertices,
	}

	graphL->initWithTxt(os.args[1])
	graphL->showVertices()

	bFT := BFTraversal {
		init      = bFTInit,
		traversal = bFTTraversal,
		pathTo    = bFTPathTo,
	}

	bFT->init(graphL, 0)
	fmt.println("Path from 0 to 5", bFT->pathTo(5))


}

