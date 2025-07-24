
public struct H3Cell: H3Indexable {
    private let _id: UInt64

    public init(_ id: UInt64) {
        self._id = id
    }
}

extension H3Cell: Identifiable {
    public var id: UInt64 { self._id }
}