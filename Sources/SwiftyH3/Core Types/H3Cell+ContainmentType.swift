
extension H3Cell {
    /// A containment type available for the ``H3Polygon/cellsExperimental(at:containmentType:)`` method.
    public enum ContainmentType: UInt32, Sendable {
        /// Cell center is contained in the shape.
        case center = 0
        /// Cell is fully contained in the shape.
        case full = 1
        /// Cell overlaps the shape at any point.
        case overlapping = 2
        /// The cell's bounding box overlaps shape.
        case overlappingBBox = 3
    }
}