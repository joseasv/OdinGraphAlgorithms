# Graph algorithms implemented in Odin

This is a repo for my graph algorithms implementations made with the Odin programming language. The code definitely doesn't adhere to the Odin way of programming or even the imperative programming paradigm due to my Java object oriented background. For example, I heavily use dynamic dispatch via structs with proc fields.

## Run the code
You need to install the Odin programming language first. Then, run this in the root folder:
```
odin run . -- graphsTxts/dag.txt  
```

## Graph text file
The included graph text field represents a directed acyclic graph. The first line sets the total number of vertices and the second line is 0 if the graph is undirected or 1 if the graph is directed. The rest of the lines are a pair of numbers representing the graph's edges.

## graphtypes package
There's only one package called graphtypes that will also contain the adjacenty matrix graph implementation. Currently, the package only contains the adjacency list implementation of graphs.

All graph algorithms will reside on the root folder. 

## Algorithms

### Basic depth and breadth first traversals
The breadth first traversal (BFTraversal) struct uses a graph implemented with an adjacenty list and the depth first traversal  (DFTraversal) uses a graph implemented with an adjacency matrix. Both traversals have these proc fields:

 - init: Meant to be used after like a constructor method. Initializes the state and inmediately starts the traversal with an origin vertex.
 - traversal: Proc with the actual traversal code.
 - pathTo: Returns a dynamic array with a path that leads to a given vertex
 
### Kruskal Minimum Spanning Tree
For the MST algorithms there's another graph implementation that handles edges's weight. This Kruskal algorithm implementation uses a simple weighted union find data structure without path compression.
