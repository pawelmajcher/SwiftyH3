
import Ch3

public extension [H3Cell] {
    /// An array of cells with a parent cell recursively replacing the children cells
    /// if all children cells are included in the original (uncompacted) array.
    /// 
    /// This property throws(SwiftyH3Error) if the input cells do not share the same resolution.
    var compacted: [H3Cell] {
        get throws(SwiftyH3Error) {
            guard self.allSatisfy({ $0.isValid }) else { throw SwiftyH3Error.invalidInput }

            var inputIndexArray = self.map { cell in cell.id }
            var indexOutputArray = Array<UInt64>(repeating: 0, count: self.count)

            let h3error = indexOutputArray.withUnsafeMutableBufferPointer { outputBuffer in
                inputIndexArray.withUnsafeMutableBufferPointer { inputBuffer in
                    Ch3.compactCells(inputBuffer.baseAddress, outputBuffer.baseAddress, Int64(self.count))
                }
            }

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

            return indexOutputArray.filter { index in index != 0 }.map { index in H3Cell(index) }
        }
    }
}

extension [H3Cell] {
    private func uncompactedArraySize(at resolution: H3CellResolution) throws(SwiftyH3Error) -> Int64 {
        guard self.allSatisfy({ $0.isValid }) else { throw SwiftyH3Error.invalidInput }

        var uncompactedArraySize: Int64 = 0
        let h3error = self.map { cell in cell.id }.withUnsafeBufferPointer { buffer in
            Ch3.uncompactCellsSize(buffer.baseAddress, Int64(self.count), resolution.rawValue, &uncompactedArraySize)
        }

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return uncompactedArraySize
    }

    /// Returns the array uncompacting the sequence of indexes to the given resolution.
    public func uncompacted(at resolution: H3CellResolution) throws(SwiftyH3Error) -> [H3Cell] {
        guard self.allSatisfy({ $0.isValid }) else { throw SwiftyH3Error.invalidInput }

        let maxSize = try self.uncompactedArraySize(at: resolution)
        var inputIndexArray = self.map { cell in cell.id }
        var indexOutputArray = Array<UInt64>(repeating: 0, count: Int(maxSize))

        let h3error = indexOutputArray.withUnsafeMutableBufferPointer { outputBuffer in
            inputIndexArray.withUnsafeMutableBufferPointer { inputBuffer in
                Ch3.uncompactCells(
                    inputBuffer.baseAddress,
                    Int64(self.count),
                    outputBuffer.baseAddress,
                    maxSize,
                    resolution.rawValue)
            }
        }

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return indexOutputArray.filter { index in index != 0}.map { index in H3Cell(index) }
    }
}