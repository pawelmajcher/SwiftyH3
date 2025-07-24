
public struct H3Vertex: H3Indexable {
    private let _id: UInt64

    public init(_ id: UInt64) {
        self._id = id
    }
}

extension H3Vertex: Identifiable {
    public var id: UInt64 { self._id }
}