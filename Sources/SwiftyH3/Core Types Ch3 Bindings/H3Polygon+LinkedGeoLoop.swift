
import Ch3

extension H3Polygon {
    static func extract(from linkedLoop: UnsafeMutablePointer<Ch3.LinkedGeoLoop>) -> H3Polygon {
        var loops: [H3Loop] = []
        var currentLoop: Ch3.LinkedGeoLoop? = linkedLoop.pointee

        while let loop = currentLoop {
            let h3loop = H3Loop.extract(from: loop.first)
            loops.append(h3loop)
            currentLoop = loop.next != nil ? loop.next.pointee : nil
        }

        let boundary = loops.removeFirst()
        return H3Polygon(boundary, holes: loops)
    }
}