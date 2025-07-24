
import Ch3

extension H3Indexable {
    var h3String: String {
        get throws {
            let h3StringBufferSize = 17
            var cString = Array<CChar>(repeating: 0, count: h3StringBufferSize)
            let h3error = Ch3.h3ToString(self.id, &cString, h3StringBufferSize)

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard let h3String = String(cString: cString, encoding: .utf8) else { throw SwiftyH3Error.returnedInvalidValue }
            
            return h3String
        }
    }
}

extension String {
    var asH3Index: UInt64 {
        get throws {
            guard self.count == 15 || self.count == 16 else { throw SwiftyH3Error.invalidInput }

            var h3index: UInt64 = 0
            let h3error = self.utf8CString.withUnsafeBufferPointer { stringBuffer in
                Ch3.stringToH3(stringBuffer.baseAddress, &h3index)
            }

            guard h3error == 0 else { throw SwiftyH3Error.H3Error(h3error) }
            guard h3index != 0 else { throw SwiftyH3Error.returnedInvalidValue }

            return h3index
        }
    }
}

extension H3Cell: LosslessStringConvertible {
    var description: String { try! self.h3String }

    init?(_ h3String: String) {
        try? self.init(h3String.asH3Index)
    }
}

extension H3DirectedEdge: LosslessStringConvertible {
    var description: String { try! self.h3String }

    init?(_ h3String: String) {
        try? self.init(h3String.asH3Index)
    }
}

extension H3Vertex: LosslessStringConvertible {
    var description: String { try! self.h3String }

    init?(_ h3String: String) {
        try? self.init(h3String.asH3Index)
    }
}