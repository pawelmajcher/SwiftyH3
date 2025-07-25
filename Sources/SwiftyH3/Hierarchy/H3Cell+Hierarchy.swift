
import Ch3

public extension H3Cell {
    /// Returns the unique ancestor cell.
    /// 
    /// - Parameter parentRes: The optional resolution of the ancestor.
    /// If the cell has resolution 7, then `.res6` would give the
    /// immediate parent, `.res5` would give the grandparent and so on.
    /// 
    /// Call to the function without this parameter or with `nil` value
    /// returns the immediate parent.
    func parent(at parentRes: H3CellResolution? = nil) throws -> H3Cell {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        
        let resolution = try self.resolution
        guard
            let parentRes = parentRes ?? H3CellResolution(rawValue: resolution.rawValue - 1)
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
    var parent: H3Cell? {
        return try? self.parent()
    }
}

internal extension H3Cell {
    func childrenSize(at childRes: H3CellResolution) throws -> Int64 {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        var childrenSize: Int64 = 0
        let h3error = Ch3.cellToChildrenSize(self.id, childRes.rawValue, &childrenSize)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard childrenSize != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return childrenSize
    }
}

public extension H3Cell {
    /// Returns the array of children cells.
    /// 
    /// - Parameter childRes: The optional resolution of the children.
    /// If the cell has resolution 7, then `.res8` would return
    /// an array with seven immediate children, `.res9` would give 
    /// the grandchildren cells and so on.
    /// 
    /// Call to the function without this parameter or with `nil` value
    /// returns the array of seven immediate children.
    func children(at childRes: H3CellResolution? = nil) throws -> [H3Cell] {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        let resolution = try self.resolution
        guard
            let childRes = childRes ?? H3CellResolution(rawValue: resolution.rawValue + 1)
        else { throw SwiftyH3Error.invalidInput }

        let childrenSize = try self.childrenSize(at: childRes)

        let indexArray = try Array<UInt64>(unsafeUninitializedCapacity: Int(childrenSize)) { buffer, initializedCount in
            let h3error = Ch3.cellToChildren(self.id, childRes.rawValue, buffer.baseAddress)
            initializedCount = Int(childrenSize)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        }

        return indexArray.map { h3index in H3Cell(h3index) }
    }

    /// The immediate children of the cell.
    /// 
    /// Returns an empty array for resolution 15 cells (no children),
    /// an otherwise invalid input or any other error. For a throwing
    /// implementation, call `children()`.
    var children: [H3Cell] {
        return (try? self.children()) ?? []
    }

    /// Returns the center child of the cell.
    /// 
    /// - Parameter childRes: The optional resolution of the child cell.
    /// If the cell has resolution 7, then `.res8` would return
    /// the immediate center child cell, `.res9` would give 
    /// the center grandchild and so on.
    /// 
    /// Call to the function without this parameter or with `nil` value
    /// returns the immediate center child.
    func centerChild(at childRes: H3CellResolution? = nil) throws -> H3Cell {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        let resolution = try self.resolution
        guard
            let childRes = childRes ?? H3CellResolution(rawValue: resolution.rawValue + 1)
        else { throw SwiftyH3Error.invalidInput }

        var childId: UInt64 = 0
        let h3error = Ch3.cellToCenterChild(self.id, childRes.rawValue, &childId)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return H3Cell(childId)
    }

    /// The immediate center child of the cell.
    /// 
    /// Returns `nil` for resolution 15 cells (no children),
    /// an otherwise invalid input or any other error. For a throwing
    /// implementation, call `centerChild()`.
    var centerChild: H3Cell? {
        return try? self.centerChild()
    }
}