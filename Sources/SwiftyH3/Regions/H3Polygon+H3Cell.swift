
import Ch3

extension H3Polygon {
    internal func maxCellsSize(at resolution: H3CellResolution) throws -> Int64 {
        try self.withGeoPolygon { geoPolygon in
            try withUnsafePointer(to: geoPolygon) { geoPolygonPointer in
                var size: Int64 = 0
                let h3error = Ch3.maxPolygonToCellsSize(geoPolygonPointer, resolution.rawValue, UInt32(0), &size)

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
                guard size != 0 else { throw SwiftyH3Error.returnedInvalidValue }

                return size
            }
        }
    }

    internal func maxCellsSizeExperimental(at resolution: H3CellResolution, for containmentType: H3CellContainmentType) throws -> Int64 {
        try self.withGeoPolygon { geoPolygon in
            try withUnsafePointer(to: geoPolygon) { geoPolygonPointer in
                var size: Int64 = 0
                let h3error = Ch3.maxPolygonToCellsSizeExperimental(
                    geoPolygonPointer,
                    resolution.rawValue,
                    containmentType.rawValue,
                    &size
                )

                guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
                guard size != 0 else { throw SwiftyH3Error.returnedInvalidValue }

                return size
            }
        }
    }

    /// Produce a collection of cells that are contained within the polygon.
    /// 
    /// Containment is determined by centroids of the cells, so any
    /// polygon partitioning will map to a partitioning of H3 cells
    /// (without overlaps).
    /// 
    /// - Parameter resolution: The target cell resolution.
    /// 
    /// - Returns: An array with generated cells at given resolution.
    public func cells(at resolution: H3CellResolution) throws -> [H3Cell] {
        let maxSize = try self.maxCellsSize(at: resolution)

        var indexArray = Array<UInt64>(repeating: 0, count: Int(maxSize))
        try indexArray.withUnsafeMutableBufferPointer { indexArrayBuffer in
            try self.withGeoPolygon { geoPolygon in
                try withUnsafePointer(to: geoPolygon) { geoPolygonPointer in
                    let h3error = Ch3.polygonToCells(
                        geoPolygonPointer,
                        resolution.rawValue,
                        UInt32(0),
                        indexArrayBuffer.baseAddress
                    )

                    guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
                }
            }
        }

        return indexArray.filter { h3index in h3index != 0 }.map { h3index in H3Cell(h3index) }
    }

    /// Produce a collection of cells that are contained within the polygon
    /// using an experimental algorithm.
    /// 
    /// Containment is determined by chosen containment mode.
    /// 
    /// - Parameter resolution: The target cell resolution.
    /// - Parameter containmentType: The containment mode to be used by the algorithm.
    /// 
    /// - Returns: An array with generated cells at given resolution.
    public func cellsExperimental(at resolution: H3CellResolution, containmentType: H3CellContainmentType = .center) throws -> [H3Cell] {
        let maxSize = try self.maxCellsSizeExperimental(at: resolution, for: containmentType)

        var indexArray = Array<UInt64>(repeating: 0, count: Int(maxSize))
        try indexArray.withUnsafeMutableBufferPointer { indexArrayBuffer in
            try self.withGeoPolygon { geoPolygon in
                try withUnsafePointer(to: geoPolygon) { geoPolygonPointer in
                    let h3error = Ch3.polygonToCellsExperimental(
                        geoPolygonPointer,
                        resolution.rawValue,
                        containmentType.rawValue,
                        Int64(indexArrayBuffer.count),
                        indexArrayBuffer.baseAddress
                    )

                    guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
                }
            }
        }

        return indexArray.filter { h3index in h3index != 0 }.map { h3index in H3Cell(h3index) }
    }
}