
public protocol H3Indexable: Hashable, Sendable {
    var id: UInt64 { get }
    var isValid: Bool { get }
    var description: String { get }

    init(_ id: UInt64) throws
}