
import Ch3

/// A random access collection of all children of the parent cell at a given resolution.
/// 
/// You do not initialize values of this type yourself. You can obtain them by calling
/// `parentCell.children(at: ...)` instead.
/// 
/// You can use values of this type like an Array, iterating over it, applying `.map`
/// and accessing children cells at given positions through subscripts.
/// 
/// If you need to mutate the values, you can initialize an array from this value with
/// `Array(childrenCollection)`.
public struct H3CellChildrenCollection: Hashable, Sendable {
    /// The parent cell of a collection of children.
    public let parent: H3Cell

    /// The resolution of the children cells.
    public let resolution: H3CellResolution

    internal init(parent: H3Cell, resolution: H3CellResolution) throws(SwiftyH3Error) {
        guard parent.isValid else { throw SwiftyH3Error.invalidInput }
        guard let parentRes = try? parent.resolution, resolution.rawValue > parentRes.rawValue else { throw SwiftyH3Error.invalidInput }

        self.parent = parent
        self.resolution = resolution
    }
}

extension H3CellChildrenCollection: RandomAccessCollection {
    public var startIndex: Int64 { 0 }
    public var endIndex: Int64 { (try? parent.childrenSize(at: resolution)) ?? 0 }
    
    /// The child cell at a given position within an ordered collection of all children
    /// of parent cell at a specific resolution.
    public subscript(i: Int64) -> H3Cell {
        try! parent.child(at: resolution, position: i)
    }
}

extension H3CellChildrenCollection {
    /// The center child in the collection.
    public var center: H3Cell {
        try! parent.centerChild(at: resolution)
    }

    public func index(of childCell: H3Cell) throws(SwiftyH3Error) -> Int64 {
        guard childCell.isValid else { throw SwiftyH3Error.invalidInput }
        guard try childCell.resolution == self.resolution else { throw SwiftyH3Error.invalidInput }

        var childPos: Int64 = -1
        let h3error = try Ch3.cellToChildPos(childCell.id, parent.resolution.rawValue, &childPos)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard childPos != -1 else { throw SwiftyH3Error.returnedInvalidValue }

        return childPos
    }
}

internal extension H3Cell {
    func childrenSize(at childRes: H3CellResolution) throws(SwiftyH3Error) -> Int64 {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        var childrenSize: Int64 = -1
        let h3error = Ch3.cellToChildrenSize(self.id, childRes.rawValue, &childrenSize)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard childrenSize != -1 else { throw SwiftyH3Error.returnedInvalidValue }

        return childrenSize
    }

    func centerChild(at childRes: H3CellResolution? = nil) throws(SwiftyH3Error) -> H3Cell {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        let resolution = try self.resolution
        guard
            let childRes = childRes ?? resolution.finer()
        else { throw SwiftyH3Error.invalidInput }

        var childId: UInt64 = 0
        let h3error = Ch3.cellToCenterChild(self.id, childRes.rawValue, &childId)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return H3Cell(childId)
    }

    var centerChild: H3Cell? {
        return try? self.centerChild()
    }

    func child(at childRes: H3CellResolution? = nil, position childPos: Int64) throws(SwiftyH3Error) -> H3Cell {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        let resolution = try self.resolution
        guard
            let childRes = childRes ?? resolution.finer()
        else { throw SwiftyH3Error.invalidInput }

        var childId: UInt64 = 0
        let h3error = Ch3.childPosToCell(childPos, self.id, childRes.rawValue, &childId)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return H3Cell(childId)
    }
}