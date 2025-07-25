
public struct H3LatLng: Hashable, Sendable {
    /// Latitude in radians.
    public let latitudeRads: Double

    /// Longitude in radians.
    public let longitudeRads: Double

    public init(latitudeRads: Double, longitudeRads: Double) {
        self.latitudeRads = latitudeRads
        self.longitudeRads = longitudeRads
    }
}