
import Ch3

extension H3Loop {
    static func extract(from linkedLatLng: UnsafeMutablePointer<Ch3.LinkedLatLng>) -> H3Loop {
        var coordinates: [H3LatLng] = []
        var currentCoord: Ch3.LinkedLatLng? = linkedLatLng.pointee
        
        // Iterate through each coordinate in the loop
        while let coord = currentCoord {
            let vertex = coord.vertex
            coordinates.append(H3LatLng(from: vertex))
            currentCoord = coord.next != nil ? coord.next.pointee : nil
        }
        
        return coordinates
    }
}