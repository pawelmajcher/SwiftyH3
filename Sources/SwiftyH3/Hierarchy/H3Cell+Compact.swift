
import Ch3

extension [H3Cell] {
    var compacted: [H3Cell] {
        get throws {
            guard self.allSatisfy({ $0.isValid }) else { throw SwiftyH3Error.invalidInput }

            var inputIndexArray = self.map { cell in cell.id }
            var indexOutputArray = Array<UInt64>(repeating: 0, count: self.count)

            let h3error = indexOutputArray.withUnsafeMutableBufferPointer { outputBuffer in
                inputIndexArray.withUnsafeMutableBufferPointer { inputBuffer in
                    Ch3.compactCells(inputBuffer.baseAddress, outputBuffer.baseAddress, Int64(self.count))
                }
            }

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

            return indexOutputArray.filter { index in index != 0}.map { index in H3Cell(index) }
        }
    }
}

extension [H3Cell] {
    private func uncompactedArraySize(at resolution: H3CellResolution) throws -> Int64 {
        guard self.allSatisfy({ $0.isValid }) else { throw SwiftyH3Error.invalidInput }

        var uncompactedArraySize: Int64 = 0
        let h3error = self.map { cell in cell.id }.withUnsafeBufferPointer { buffer in
            Ch3.uncompactCellsSize(buffer.baseAddress, Int64(self.count), resolution.rawValue, &uncompactedArraySize)
        }

        guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }

        return uncompactedArraySize
    }

    func uncompacted(at resolution: H3CellResolution) throws -> [H3Cell] {
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