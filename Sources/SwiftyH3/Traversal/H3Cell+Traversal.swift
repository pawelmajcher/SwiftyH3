
import Ch3

extension H3Cell {
    /// Returns the minimum number of "hops" on the grid to get from
    /// the origin to the destination cell.
    public func gridDistance(to destination: H3Cell) throws(SwiftyH3Error) -> Int64 {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }
        guard destination.isValid else { throw SwiftyH3Error.invalidInput }

        var distance: Int64 = 0
        let h3error = Ch3.gridDistance(self.id, destination.id, &distance)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        return distance
    }
}

extension H3Cell {
    internal static func maxGridRingSize(distance: Int32) throws(SwiftyH3Error) -> Int64 {
        var ringSize: Int64 = 0
        let h3error = Ch3.maxGridRingSize(distance, &ringSize)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard ringSize != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return ringSize
    }

    internal static func maxGridDiskSize(distance: Int32) throws(SwiftyH3Error) -> Int64 {
        var diskSize: Int64 = 0
        let h3error = Ch3.maxGridDiskSize(distance, &diskSize)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
        guard diskSize != 0 else { throw SwiftyH3Error.returnedInvalidValue }

        return diskSize
    }
}

extension H3Cell {
    /// Produces the "hollow ring" of cells which are the same grid
    /// distance away from the origin cell.
    /// 
    /// - Parameter distance: The exact grid distance (number of steps)
    /// from the cell (e.g., distance = 1 returns immediate neighbors).
    /// 
    /// - Returns: An array with generated cells at given distance.
    public func gridRing(distance: Int32 = 1) throws(SwiftyH3Error) -> [H3Cell] {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        let maxRingSize = try H3Cell.maxGridRingSize(distance: distance)

        var indexArray = Array<UInt64>(repeating: 0, count: Int(maxRingSize))
        let h3error = indexArray.withUnsafeMutableBufferPointer { buffer in
            Ch3.gridRing(self.id, distance, buffer.baseAddress)
        }

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return indexArray.filter { h3index in h3index != 0 }.map { h3index in H3Cell(h3index) }
    }

    /// Produces the "filled-in disk" of cells which are at maximum
    /// the given distance away from the origin cell.
    /// 
    /// Output order is not guaranteed.
    /// 
    /// - Parameter distance: The maximum grid distance (number of steps)
    /// from the cell (e.g., distance = 2 returns the origin cell,
    /// its immediate neighbors and their neighbors).
    /// 
    /// - Returns: An array with cells making up the disk.
    public func gridDisk(distance: Int32) throws(SwiftyH3Error) -> [H3Cell] {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        let maxDiskSize = try H3Cell.maxGridDiskSize(distance: distance)

        var indexArray = Array<UInt64>(repeating: 0, count: Int(maxDiskSize))
        let h3error = indexArray.withUnsafeMutableBufferPointer { buffer in
            Ch3.gridDisk(self.id, distance, buffer.baseAddress)
        }

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return indexArray.filter { h3index in h3index != 0 }.map { h3index in H3Cell(h3index) }
    }
}

extension H3Cell {
    internal func gridPathCellsSize(to destination: H3Cell) throws(SwiftyH3Error) -> Int64 {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        var pathSize: Int64 = 0
        let h3error = Ch3.gridPathCellsSize(self.id, destination.id, &pathSize)

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return pathSize
    }

    /// Returns a minimal-length contiguous path to the destination cell.
    /// 
    /// Paths exist in the H3 grid of cells, and may not align closely with
    /// either Cartesian lines or great arcs.
    /// 
    /// - Parameter destination: The destination `H3Cell`.
    /// 
    /// - Throws: `SwiftyH3Error.H3Error(Int32)` if the cells are very far apart,
    /// or if the cells are on opposite sides of a pentagon. Refer to the
    /// [table of error codes](https://h3geo.org/docs/library/errors#table-of-error-codes)
    /// for more.
    /// 
    /// - Returns: An array of `self.gridDistance(to: destination) + 1` cells,
    /// where the first cell is the origin cell, each next cell is a neighbor
    /// of the previous cell, and the last cell is the destination cell.
    public func path(to destination: H3Cell) throws(SwiftyH3Error) -> [H3Cell] {
        guard self.isValid else { throw SwiftyH3Error.invalidInput }

        let pathSize = try self.gridPathCellsSize(to: destination)

        var indexArray = Array<UInt64>(repeating: 0, count: Int(pathSize))
        let h3error = indexArray.withUnsafeMutableBufferPointer { buffer in
            Ch3.gridPathCells(self.id, destination.id, buffer.baseAddress)
        }

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return indexArray.map { h3index in H3Cell(h3index) }
    }
}