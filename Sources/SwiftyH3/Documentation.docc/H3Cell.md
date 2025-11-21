# ``SwiftyH3/H3Cell``

## Topics

### Initializers

- ``init(_:)-(UInt64)``
- ``H3Indexable/init(_:)-(String)``
- ``init(base:_:)``

### Indexing

- ``boundary``
- ``center``

### Inspection

- ``H3Indexable/description``
- ``H3Indexable/resolution``
- ``H3Indexable/baseCellNumber``
- ``H3Indexable/digit(for:)``
- ``H3Indexable/isSomeH3Index``
- ``H3Cell/isValid``
- ``isResClassIII``
- ``isPentagon``

### Traversal

- ``gridDistance(to:)``
- ``gridRing(distance:)``
- ``gridDisk(distance:)``
- ``path(to:)``

### Hierarchy

- ``parent(at:)``
- ``parent``
- ``children(at:)``
- ``children``
- ``ChildrenCollection``

### Compacting and uncompacting

- ``SwiftyH3/Swift/Sequence/compacted``
- ``SwiftyH3/Swift/Sequence/uncompacted(at:)``

### Region

- ``SwiftyH3/Swift/Sequence/multiPolygon``

### Directed edges

- ``isNeighbor(of:)``
- ``directedEdge(to:)``
- ``directedEdges``

### Vertices

- ``vertex(_:)``
- ``vertices``