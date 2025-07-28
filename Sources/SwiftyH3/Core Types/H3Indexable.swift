
/// A protocol for common properties of all structures representable with an H3 index.
public protocol H3Indexable: Hashable, Sendable, LosslessStringConvertible {
    /// An integer representation of the H3 index.
    var id: UInt64 { get }

    /// `true` if the index is a valid representation of its type and `false` otherwise.
    var isValid: Bool { get }

    /// A string representation of the H3 index.
    var description: String { get }

    /// Instantiates an instance of the conforming type from an integer representation.
    init(_ id: UInt64)

    init?(_ h3String: String)
}