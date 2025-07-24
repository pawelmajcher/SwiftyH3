
import Ch3

public extension H3Cell {
    func parent(times parentRes: Int32 = 1) throws -> H3Cell {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        var parentId: UInt64 = 0
        let h3error = Ch3.cellToParent(self.id, parentRes, &parentId)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard parentId != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return H3Cell(parentId)
    }

    var parent: H3Cell? {
        try? self.parent()
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
    func children(at childRes: H3CellResolution) throws -> [H3Cell] {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        let childrenSize = try self.childrenSize(at: childRes)

        let indexArray = try Array<UInt64>(unsafeUninitializedCapacity: Int(childrenSize)) { buffer, initializedCount in
            let h3error = Ch3.cellToChildren(self.id, childRes.rawValue, buffer.baseAddress)
            initializedCount = Int(childrenSize)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        }

        return indexArray.map { h3index in H3Cell(h3index) }
    }

    var children: [H3Cell] {
        guard 
            let resolution = try? self.resolution,
            let resolutionOneDown = H3CellResolution(rawValue: resolution.rawValue + 1)
        else { return [] }
        
        return (try? self.children(at: resolutionOneDown)) ?? []
    }

    func centerChild(at childRes: H3CellResolution) throws -> H3Cell {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        var childId: UInt64 = 0
        let h3error = Ch3.cellToCenterChild(self.id, childRes.rawValue, &childId)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return H3Cell(childId)
    }

    var centerChild: H3Cell? {
        get throws {
            guard
                let resolutionOneDown = try H3CellResolution(rawValue: self.resolution.rawValue + 1)
            else { return nil }

            return try self.centerChild(at: resolutionOneDown)
        }
    }
}