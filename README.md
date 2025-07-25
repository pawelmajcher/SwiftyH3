
# SwiftyH3

**The Swifty way to use [Uber's H3 geospatial indexing system](https://h3geo.org/).**

Use bindings to the [reference implementation of the library](https://github.com/uber/h3.git) effortlessly through Swift-native structs, properties and functions.

## Quick Start

```swift

import SwiftyH3

// Find the containing cell for a given location
let latlng = H3LatLng(latitudeDegs: 37.7955, longitudeDegs: -122.3937)
let cell = try! latlng.cell(at: .res10)
print(cell) // 8a283082a677fff

// Retrieve the center of the cell (as H3LatLng or CLLocationCoordinate2D)
let coordinate: CLLocationCoordinate2D = try! cell.center.coordinates

// Find the bounds of this cell
let bounds: [H3LatLng] = try! cell.boundary
```

## Installation

### Swift Package Manager

Add the following line to your package's `Package.swift` file:

```swift
.package(url: "https://github.com/pawelmajcher/SwiftyH3.git", from: "0.1.0")
```

### Xcode

Go to *File* > *Add Package Dependencies...* and enter `https://github.com/pawelmajcher/SwiftyH3.git` in the upper-right corner.

## License

- SwiftyH3 (this repository) is licensed under the [Apache 2.0 license](LICENSE).
- Ch3 (with raw bindings and additional maintenance code) is licensed under the [MIT License](https://github.com/pawelmajcher/Ch3/blob/master/LICENSE).
- Uber's H3 library is licensed under the [Apache 2.0 license](https://github.com/uber/h3/blob/master/LICENSE).