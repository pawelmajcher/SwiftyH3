
/// An ordered collection of `H3LatLng`, usually representing a linear ring.
public typealias H3Loop = [H3LatLng]

/// A struct representing a polygon (one exterior ring with possible holes/interior rings).
public struct H3Polygon: Hashable, Sendable {
    /// Polygon's boundary (exterior ring).
    public let boundary: H3Loop

    /// Polygon's holes (interior rings).
    public let holes: [H3Loop]

    public init(_ boundary: H3Loop, holes: [H3Loop] = []) {
        self.boundary = boundary
        self.holes = holes
    }
}

/// A collection of `H3Polygon`, usually representing a multipolygon.
public typealias H3MultiPolygon = [H3Polygon]