
import Ch3

extension H3Cell {
    func gridDistance(to destination: H3Cell) throws -> Int64 {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        guard destination.isValid else { throw SwiftyH3Error.invalidInput }

        var distance: Int64 = 0
        let h3error = Ch3.gridDistance(self.id, destination.id, &distance)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        return distance
    }
}

extension H3Cell {
    static func maxGridRingSize(distance: Int32) throws -> Int64 {
        var ringSize: Int64 = 0
        let h3error = Ch3.maxGridRingSize(distance, &ringSize)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard ringSize != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return ringSize
    }

    static func maxGridDiskSize(distance: Int32) throws -> Int64 {
        var diskSize: Int64 = 0
        let h3error = Ch3.maxGridDiskSize(distance, &diskSize)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard diskSize != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return diskSize
    }
}

extension H3Cell {
    func gridRing(distance: Int32) throws -> [H3Cell] {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        let maxRingSize = try H3Cell.maxGridRingSize(distance: distance)

        var indexArray = Array<UInt64>(repeating: 0, count: Int(maxRingSize))
        try indexArray.withUnsafeMutableBufferPointer { buffer in
            let h3error = Ch3.gridRing(self.id, distance, buffer.baseAddress)
            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        }

        return indexArray.filter { h3index in h3index != 0 }.map { h3index in H3Cell(h3index) }
    }

    func gridDisk(distance: Int32) throws -> [H3Cell] {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        let maxDiskSize = try H3Cell.maxGridDiskSize(distance: distance)

        var indexArray = Array<UInt64>(repeating: 0, count: Int(maxDiskSize))
        try indexArray.withUnsafeMutableBufferPointer { buffer in
            let h3error = Ch3.gridDisk(self.id, distance, buffer.baseAddress)
            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        }

        return indexArray.filter { h3index in h3index != 0 }.map { h3index in H3Cell(h3index) }
    }
}

extension H3Cell {
    func gridPathCellsSize(to destination: H3Cell) throws -> Int64 {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        var pathSize: Int64 = 0
        let h3error = Ch3.gridPathCellsSize(self.id, destination.id, &pathSize)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return pathSize
    }

    func gridPathCells(to destination: H3Cell) throws -> [H3Cell] {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        let pathSize = try self.gridPathCellsSize(to: destination)

        let indexArray = try Array<UInt64>(unsafeUninitializedCapacity: Int(pathSize)) { buffer, initializedCount in
            let h3error = Ch3.gridPathCells(self.id, destination.id, buffer.baseAddress)
            initializedCount = Int(pathSize)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        }

        return indexArray.map { h3index in H3Cell(h3index) }
    }
}