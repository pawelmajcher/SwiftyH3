
# SwiftyH3 ⬡

**The Swifty way to use [Uber's H3 geospatial indexing system](https://h3geo.org/).**

[![Documentation](https://img.shields.io/badge/Documentation-blue)](https://swiftpackageindex.com/pawelmajcher/SwiftyH3/0.4.1/documentation/swiftyh3) [![Swift versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpawelmajcher%2FSwiftyH3%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/pawelmajcher/SwiftyH3) [![Swift platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpawelmajcher%2FSwiftyH3%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/pawelmajcher/SwiftyH3)


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
.package(url: "https://github.com/pawelmajcher/SwiftyH3.git", from: "0.4.1")
```

### Xcode

Go to *File* > *Add Package Dependencies...* and enter `https://github.com/pawelmajcher/SwiftyH3.git` in the upper-right corner.

## H3 API support

### Indexing functions

| H3 C function | Example SwiftyH3 code | Docs |
| :---: | :--- | :---: |
| [`latLngToCell`](https://h3geo.org/docs/api/indexing#latlngtocell) | `try H3LatLng(latitudeDegs: 37.7955, longitudeDegs: -122.3937).cell(at: .res8)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3latlng/cell(at:)) |
| [`cellToLatLng`](https://h3geo.org/docs/api/indexing#celltolatlng) | `try H3Cell("8a283082a677fff")!.center` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/center) |
| [`cellToBoundary`](https://h3geo.org/docs/api/indexing#celltoboundary) | `try H3Cell("8a283082a677fff")!.boundary` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/boundary) |

### Index inspection functions

| H3 C function | Example SwiftyH3 code | Docs |
| :---: | :--- | :---: |
| [`getResolution`](https://h3geo.org/docs/api/inspection#getresolution) | `try H3DirectedEdge("115283473fffffff")!.resolution` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3indexable/resolution) |
| [`getBaseCellNumber`](https://h3geo.org/docs/api/inspection#getbasecellnumber) | `try H3Vertex("22528340bfffffff")!.baseCellNumber` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3indexable/basecellnumber) |
| [`getIndexDigit`](https://h3geo.org/docs/api/inspection#getindexdigit) | ⚠️ Not yet available | |
| [`constructCell`](https://h3geo.org/docs/api/inspection/#constructcell) | ⚠️ Not yet available | |
| [`stringToH3`](https://h3geo.org/docs/api/inspection#stringtoh3) | `H3Cell("8a283082a677fff")!` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3indexable/init(_:)-8n6gi) |
| [`h3ToString`](https://h3geo.org/docs/api/inspection#h3tostring) | `try H3Cell(599686042433355775).description` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3indexable/description) |
| [`isValidCell`](https://h3geo.org/docs/api/inspection#isvalidcell) | `cell.isValid` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/isvalid) |
| [`isValidIndex`](https://h3geo.org/docs/api/inspection/#isvalidindex) | ⚠️ Not yet available | |
| [`isResClassIII`](https://h3geo.org/docs/api/inspection#isresclassiii) | `cell.isResClassIII` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/isresclassiii) |
| [`isPentagon`](https://h3geo.org/docs/api/inspection#ispentagon) | `cell.isPentagon` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/ispentagon) |
| [`getIcosahedronFaces`](https://h3geo.org/docs/api/inspection#geticosahedronfaces) | ⚠️ Not yet available |
| [`maxFaceCount`](https://h3geo.org/docs/api/inspection#maxfacecount) | *This function exists for memory management and is not exposed.* |

### Grid traversal functions

| H3 C function | Example SwiftyH3 code | Docs |
| :---: | :--- | :---: |
| [`gridDistance`](https://h3geo.org/docs/api/traversal#griddistance) | `try originCell.gridDistance(to: destinationCell)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/griddistance(to:)) |
| [`gridRing`](https://h3geo.org/docs/api/traversal#gridring) | `try cell.gridRing(distance: 1)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/gridring(distance:)) |
| [`gridRingUnsafe`](https://h3geo.org/docs/api/traversal#gridringunsafe) | Not exposed. Use `gridRing`. |
| [`maxGridRingSize`](https://h3geo.org/docs/api/traversal#maxgridringsize) | *This function exists for memory management and is not exposed.* |
| [`gridDisk`](https://h3geo.org/docs/api/traversal#griddisk) | `try cell.gridDisk(distance: 2)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/griddisk(distance:)) |
| [`maxGridDiskSize`](https://h3geo.org/docs/api/traversal#maxgriddisksize) | *This function exists for memory management and is not exposed.* |
| [`gridDiskDistances`](https://h3geo.org/docs/api/traversal#griddiskdistances) | Not exposed. Use `try 1...3.map { cell.gridRing(distance: $0) }`. |
| [`gridDiskUnsafe`](https://h3geo.org/docs/api/traversal#griddiskunsafe) | Not exposed. Use `gridDisk`. |
| [`gridDiskDistancesUnsafe`](https://h3geo.org/docs/api/traversal#griddiskdistancesunsafe) | Not exposed. Use `try 1...3.map { cell.gridRing(distance: $0) }`. |
| [`gridDiskDistancesSafe`](https://h3geo.org/docs/api/traversal#griddiskdistancessafe) | Not exposed. Use `try 1...3.map { cell.gridRing(distance: $0) }`. |
| [`gridDisksUnsafe`](https://h3geo.org/docs/api/traversal#griddisksunsafe) | Not exposed. Use `try cells.flatMap { cell in 1...3.flatMap { cell.gridRing(distance: $0) } }`. |
| [`gridPathCells`](https://h3geo.org/docs/api/traversal#gridpathcells) | `try cell1.path(to: ...)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/path(to:)) |
| [`gridPathCellsSize`](https://h3geo.org/docs/api/traversal#gridpathcellssize) | *This function exists for memory management and is not exposed.* |
| [`cellToLocalIj`](https://h3geo.org/docs/api/traversal#celltolocalij) | ⚠️ Not yet available |
| [`localIjToCell`](https://h3geo.org/docs/api/traversal#localijtocell) | ⚠️ Not yet available |

### Hierarchical grid functions

| H3 C function | Example SwiftyH3 code | Docs |
| :---: | :--- | :---: |
| [`cellToParent`](https://h3geo.org/docs/api/hierarchy#celltoparent) | `try cell.parent(at: .res1)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/parent(at:)) |
| [`cellToChildren`](https://h3geo.org/docs/api/hierarchy#celltochildren) | `try cell.children(at: .res12)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/children(at:)) |
| [`cellToChildrenSize`](https://h3geo.org/docs/api/hierarchy#celltochildrensize) | `try cell.children(at: .res12).count` |
| [`cellToCenterChild`](https://h3geo.org/docs/api/hierarchy#celltocenterchild) | `try cell.children(at: .res12).center` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/childrencollection/center) |
| [`cellToChildPos`](https://h3geo.org/docs/api/hierarchy#celltochildpos) | `try parentCell.children(at: .res12).index(of: childCell)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/childrencollection/index(of:)) |
| [`childPosToCell`](https://h3geo.org/docs/api/hierarchy#childpostocell) | `try cell.children(at: .res12)[23]` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/childrencollection/subscript(_:)) |
| [`compactCells`](https://h3geo.org/docs/api/hierarchy#compactcells) | `try [cell1, ..., cell50].compacted` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/swift/sequence/compacted) |
| [`uncompactCells`](https://h3geo.org/docs/api/hierarchy#uncompactcells) | `try [cell1, cell2, cell3].uncompacted(at: .res8)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/swift/sequence/uncompacted(at:)) |
| [`uncompactCellsSize`](https://h3geo.org/docs/api/hierarchy#uncompactcellssize) | *This function exists for memory management and is not exposed.* |

### Region functions

| H3 C function | Example SwiftyH3 code | Docs |
| :---: | :--- | :---: |
| [`polygonToCells`](https://h3geo.org/docs/api/regions#polygontocells) | `try H3Polygon([...]).cells(at: .res7)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3polygon/cells(at:)) |
| [`maxPolygonToCellsSize`](https://h3geo.org/docs/api/regions#maxpolygontocellssize) | *This function exists for memory management and is not exposed.* |
| [`polygonToCellsExperimental`](https://h3geo.org/docs/api/regions#polygontocellsexperimental) | `try H3Polygon([...]).cellsExperimental(at: .res7, containmentType: .overlapping)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3polygon/cellsexperimental(at:containmenttype:)) |
| [`maxPolygonToCellsSizeExperimental`](https://h3geo.org/docs/api/regions#maxpolygontocellssizeexperimental) | *This function exists for memory management and is not exposed.* |
| [`cellsToLinkedMultiPolygon`](https://h3geo.org/docs/api/regions/#cellstolinkedmultipolygon--cellstomultipolygon) | `try [cell1, cell2, cell3].multiPolygon` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/swift/sequence/multipolygon) |
| [`destroyLinkedMultiPolygon`](https://h3geo.org/docs/api/regions#destroylinkedmultipolygon) | *This function exists for memory management and is not exposed.* |

### Directed edge functions

| H3 C function | Example SwiftyH3 code | Docs |
| :---: | :--- | :---: |
| [`areNeighborCells`](https://h3geo.org/docs/api/uniedge#areneighborcells) | `try cell1.isNeighbor(of: cell2)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/isneighbor(of:)) |
| [`cellsToDirectedEdge`](https://h3geo.org/docs/api/uniedge#cellstodirectededge) | `try originCell.directedEdge(to: destinationCell)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/directededge(to:)) |
| [`isValidDirectedEdge`](https://h3geo.org/docs/api/uniedge#isvaliddirectededge) | `directedEdge.isValid` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3directededge/isvalid) |
| [`getDirectedEdgeOrigin`](https://h3geo.org/docs/api/uniedge#getdirectededgeorigin) | `try directedEdge.origin` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3directededge/origin) |
| [`getDirectedEdgeDestination`](https://h3geo.org/docs/api/uniedge#getdirectededgedestination) | `try directedEdge.destination` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3directededge/destination) |
| [`directedEdgeToCells`](https://h3geo.org/docs/api/uniedge#directededgetocells) | Not exposed. Use `try (directedEdge.origin, directedEdge.destination)`. |
| [`originToDirectedEdges`](https://h3geo.org/docs/api/uniedge#origintodirectededges) | `try originCell.directedEdges` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/directededges) |
| [`directedEdgeToBoundary`](https://h3geo.org/docs/api/uniedge#directededgetoboundary) | `try directedEdge.boundary` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3directededge/boundary) |

### Vertex functions

| H3 C function | Example SwiftyH3 code | Docs |
| :---: | :--- | :---: |
| [`cellToVertex`](https://h3geo.org/docs/api/vertex#celltovertex) | `try cell.vertex(3)` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/vertex(_:)) |
| [`cellToVertexes`](https://h3geo.org/docs/api/vertex#celltovertexes) | `try cell.vertices` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/vertices) |
| [`vertexToLatLng`](https://h3geo.org/docs/api/vertex#vertextolatlng) | `try vertex.latLng` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3vertex/latlng) |
| [`isValidVertex`](https://h3geo.org/docs/api/vertex#isvalidvertex) | `vertex.isValid` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3vertex/isvalid) |

### Miscellaneous H3 functions

| H3 C function | Example SwiftyH3 code | Docs |
| :---: | :--- | :---: |
| [`degsToRads`](https://h3geo.org/docs/api/misc#degstorads) | Not exposed. Use `Measurement<UnitAngle>(value: 23, unit: .degrees).converted(to: .radians).value`. |
| [`radsToDegs`](https://h3geo.org/docs/api/misc#radstodegs) | Not exposed. Use `Measurement<UnitAngle>(value: 1.2, unit: .radians).converted(to: .degrees).value`. |
| [`getHexagonAreaAvgKm2`](https://h3geo.org/docs/api/misc#gethexagonareaavgkm2) | `H3Cell.Resolution.res8.averageHexagonArea.converted(to: .squareKilometers).value` |
| [`getHexagonAreaAvgM2`](https://h3geo.org/docs/api/misc#gethexagonareaavgm2) | `H3Cell.Resolution.res8.averageHexagonArea.value` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/resolution/averagehexagonarea) |
| [`cellAreaRads2`](https://h3geo.org/docs/api/misc#cellarearads2) | `try cell.areaRads2` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/arearads2) |
| [`cellAreaKm2`](https://h3geo.org/docs/api/misc#cellareakm2) | `try cell.area.converted(to: .squareKilometers).value` |
| [`cellAreaM2`](https://h3geo.org/docs/api/misc#cellaream2) | `try cell.area.converted(to: .squareMeters).value` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/area) |
| [`getHexagonEdgeLengthAvgKm`](https://h3geo.org/docs/api/misc#gethexagonedgelengthavgkm) | `H3Cell.Resolution.res8.averageHexagonEdgeLength.converted(to: .kilometers).value` |
| [`getHexagonEdgeLengthAvgM`](https://h3geo.org/docs/api/misc#gethexagonedgelengthavgm) | `H3Cell.Resolution.res8.averageHexagonEdgeLength.value` | [📖]() |
| [`edgeLengthKm`](https://h3geo.org/docs/api/misc#edgelengthkm) | `try directedEdge.length.converted(to: .kilometers).value` |
| [`edgeLengthM`](https://h3geo.org/docs/api/misc#edgelengthm) | `try directedEdge.length.value` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3directededge/length) |
| [`edgeLengthRads`](https://h3geo.org/docs/api/misc#edgelengthrads) | `try directedEdge.lengthRads.value` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3directededge/lengthrads) |
| [`getNumCells`](https://h3geo.org/docs/api/misc#getnumcells) | `H3Cell.Resolution.res3.numberOfCells` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/resolution/numberofcells) |
| [`getRes0Cells`](https://h3geo.org/docs/api/misc#getres0cells) | `H3Cell.res0Cells` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/res0cells) |
| [`res0CellCount`](https://h3geo.org/docs/api/misc#res0cellcount) | *This function exists for memory management and is not exposed.* |
| [`getPentagons`](https://h3geo.org/docs/api/misc#getpentagons) | `H3Cell.Resolution.res3.pentagons` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3cell/resolution/pentagons) |
| [`pentagonCount`](https://h3geo.org/docs/api/misc#pentagoncount) | *This function exists for memory management and is not exposed.* |
| [`greatCircleDistanceKm`](https://h3geo.org/docs/api/misc#greatcircledistancekm) | `h3LatLng1.distance(to: h3LatLng2).converted(to: .kilometers).value` |
| [`greatCircleDistanceM`](https://h3geo.org/docs/api/misc#greatcircledistancem) | `h3LatLng1.distance(to: h3LatLng2).value` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3latlng/distance(to:)) |
| [`greatCircleDistanceRads`](https://h3geo.org/docs/api/misc#greatcircledistancerads) | `h3LatLng1.distanceRads(to: h3LatLng2).value` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3latlng/distancerads(to:)) |
| [`describeH3Error`](https://h3geo.org/docs/api/misc#describeh3error) | `do {...} catch { print(error.errorDescription) }` | [📖](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/swiftyh3error/errordescription) |

> [!NOTE]
> The `Measurement<UnitType>` types and `LocalizedError` protocol, including related
> methods and properties, are part of `Foundation`. Include `import Foundation` to use them.

## Core Location and MapKit support

### CLLocationCoordinate2D

You can convert an [`H3LatLng`](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3latlng) value to [`CLLocationCoordinate2D`](https://developer.apple.com/documentation/corelocation/cllocationcoordinate2d) and vice versa using initializers or computed properties.

```swift
// H3LatLng ➡️ CLLocationCoordinate2D
let coordinateFromProperty: CLLocationCoordinate2D = H3LatLng(latitudeDegs: 37.7955, longitudeDegs: -122.3937).coordinates
let coordinateFromInitializer = CLLocationCoordinate2D(H3LatLng(latitudeDegs: 37.7955, longitudeDegs: -122.3937))

// CLLocationCoordinate2D ➡️ H3LatLng
let h3LatLngFromProperty: H3LatLng = CLLocationCoordinate2D(latitude: 37.7955, longitude: -122.3937).h3LatLng
let h3LatLngFromInitializer = H3LatLng(CLLocationCoordinate2D(latitude: 37.7955, longitude: -122.3937))
```

### MKPolygon and MKMultiPolygon

You can create an [`MKPolygon`](https://developer.apple.com/documentation/mapkit/mkpolygon) with an initializer taking [`[H3LatLng]`](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3loop) or [`H3Polygon`](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3polygon) values. Analogically, you can initialize [`MKMultiPolygon`](https://developer.apple.com/documentation/mapkit/mkmultipolygon) with [`[H3Polygon]`](https://swiftpackageindex.com/pawelmajcher/swiftyh3/0.4.1/documentation/swiftyh3/h3multipolygon) array.

```swift
// H3 with MapKit for SwiftUI example

import SwiftUI
import MapKit
import SwiftyH3

struct H3CellMapExampleView: View {
    let cellBoundary = try! H3LatLng(latitudeDegs: 37.7955, longitudeDegs: -122.3937).cell(at: .res4).boundary
    
    var body: some View {
        Map {
            MapPolygon(MKPolygon(cellBoundary))
        }
    }
}
```

## License

- SwiftyH3 (this repository) is licensed under the [Apache 2.0 license](LICENSE).
- Uber's H3 library is licensed under the [Apache 2.0 license](https://github.com/uber/h3/blob/master/LICENSE).