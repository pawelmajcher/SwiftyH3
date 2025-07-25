
/// A struct representing a directed edge from origin to destination cell.
public struct H3DirectedEdge: H3Indexable {
    private let _id: UInt64

    /// Initialize an H3DirectedEdge from an index represented as an unsigned 64-bit integer.
    /// 
    /// This initializer doesn't check the validity of the index. To check if the value
    /// of the index is a valid cell, use the `isValid` property.
    public init(_ id: UInt64) {
        self._id = id
    }
}

extension H3DirectedEdge: Identifiable {
    /// The H3 index value of the edge stored as an unsigned 64-bit integer.
    public var id: UInt64 { self._id }
}