
/// A struct representing an H3 vertex.
public struct H3Vertex: H3Indexable {
    private let _id: UInt64

    /// Initialize an H3Vertex from an index represented as an unsigned 64-bit integer.
    /// 
    /// This initializer doesn't check the validity of the index. To check if the value
    /// of the index is a valid cell, use the `isValid` property.
    public init(_ id: UInt64) {
        self._id = id
    }
}

extension H3Vertex: Identifiable {
    /// The H3 index value of the vertex stored as an unsigned 64-bit integer.
    public var id: UInt64 { self._id }
}