
import Ch3

extension H3Cell {
    /// Returns the unique ancestor cell.
    /// 
    /// - Parameter parentRes: The optional resolution of the ancestor.
    /// If the cell has resolution 7, then `.res6` would give the
    /// immediate parent, `.res5` would give the grandparent and so on.
    /// 
    /// Call to the function without this parameter or with `nil` value
    /// returns the immediate parent.
    public func parent(at parentRes: H3CellResolution? = nil) throws(SwiftyH3Error) -> H3Cell {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        
        let resolution = try self.resolution
        guard
            let parentRes = parentRes ?? resolution.coarser()
        else { throw SwiftyH3Error.invalidInput }

        var parentId: UInt64 = 0
        let h3error = Ch3.cellToParent(self.id, parentRes.rawValue, &parentId)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard parentId != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return H3Cell(parentId)
    }

    /// The immediate ancestor (parent) of the cell.
    /// 
    /// Returns `nil` for resolution 0 cells and other invalid inputs.
    /// For a throwing implementation, call `parent()`.
    public var parent: H3Cell? {
        return try? self.parent()
    }
}

extension H3Cell {
    /// Provides access to children cells.
    /// 
    /// - Parameter childRes: The optional resolution of the children.
    /// If the cell has resolution 7, then `.res8` would return
    /// an array with seven immediate children, `.res9` would give 
    /// the grandchildren cells and so on.
    /// 
    /// Call to the function without this parameter or with `nil` value
    /// returns the array of seven immediate children.
    public func children(at childRes: H3CellResolution? = nil) throws(SwiftyH3Error) -> H3CellChildrenCollection {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        let resolution = try self.resolution
        guard
            let childRes = childRes ?? resolution.finer()
        else { throw SwiftyH3Error.invalidInput }

        return try H3CellChildrenCollection(parent: self, resolution: childRes)
    }

    /// The immediate children of the cell.
    /// 
    /// Returns nil for resolution 15 cells (no children),
    /// an otherwise invalid input or any other error. 
    /// For a throwing implementation, call `children()`.
    public var children: H3CellChildrenCollection? {
        return try? self.children()
    }
}