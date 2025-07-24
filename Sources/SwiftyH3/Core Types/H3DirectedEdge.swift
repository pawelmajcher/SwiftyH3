
struct H3DirectedEdge: H3Indexable {
    private let _id: UInt64

    init(_ id: UInt64) {
        self._id = id
    }
}

extension H3DirectedEdge: Identifiable {
    var id: UInt64 { self._id }
}