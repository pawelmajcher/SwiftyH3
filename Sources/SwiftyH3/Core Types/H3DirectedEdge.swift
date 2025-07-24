
public struct H3DirectedEdge: H3Indexable {
    private let _id: UInt64

    public init(_ id: UInt64) {
        self._id = id
    }
}

extension H3DirectedEdge: Identifiable {
    public var id: UInt64 { self._id }
}