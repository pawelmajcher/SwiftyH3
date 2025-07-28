import Testing

@testable import SwiftyH3

extension Double {
    func isApproximatelyEqual(to other: Double, tolerance: Double = 1e-6) -> Bool {
        return abs(self - other) <= tolerance
    }
}

struct CellTests {
    let cell = H3Cell("85283473fffffff")!

    @Test func areNeighborCells() throws(SwiftyH3Error) {
        #expect(try cell.isNeighbor(of: H3Cell("85283477fffffff")!))
    }

    @Test func areNotNeighborCells() throws(SwiftyH3Error) {
        #expect(try !cell.isNeighbor(of: H3Cell("8528342bfffffff")!))
    }

    @Test func areNeighborNotCells() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try cell.isNeighbor(of: H3Cell("852834727fffffff")!)
        }
    }

    @Test func cellAreaKM2() throws(SwiftyH3Error) {
        #expect(
            try cell.area.converted(to: .squareKilometers).value.isApproximatelyEqual(
                to: 265.0925581283))
    }

    @Test func cellAreaM2() throws(SwiftyH3Error) {
        #expect(try cell.area.value.isApproximatelyEqual(to: 265092558.128, tolerance: 1e-3))
    }

    @Test func cellAreaRads2() throws(SwiftyH3Error) {
        #expect(try cell.areaRads2.isApproximatelyEqual(to: 0.0000065310))
    }

    @Test func cellToCenterChild() throws(SwiftyH3Error) {
        let cellCenterChild = H3Cell("872834700ffffff")!
        #expect(try cell.centerChild(at: .res7) == cellCenterChild)
    }

    @Test func cellToChildren() throws(SwiftyH3Error) {
        let cellChildren = [
            H3Cell("862834707ffffff")!,
            H3Cell("86283470fffffff")!,
            H3Cell("862834717ffffff")!,
            H3Cell("86283471fffffff")!,
            H3Cell("862834727ffffff")!,
            H3Cell("86283472fffffff")!,
            H3Cell("862834737ffffff")!,
        ]

        #expect(try Array(cell.children()) == cellChildren)
    }

    @Test func cellToChildrenSize() throws(SwiftyH3Error) {
        #expect(try cell.children(at: .res6).count == 7)
    }

    @Test func cellToVertex() throws(SwiftyH3Error) {
        let vertex = H3Vertex("22528340bfffffff")!
        #expect(try cell.vertex(0) == vertex)
    }

    @Test func cellToVertexes() throws(SwiftyH3Error) {
        let vertices = [
            H3Vertex("22528340bfffffff")!,
            H3Vertex("235283447fffffff")!,
            H3Vertex("205283463fffffff")!,
            H3Vertex("255283463fffffff")!,
            H3Vertex("22528340ffffffff")!,
            H3Vertex("23528340bfffffff")!,
        ]

        #expect(try cell.vertices == vertices)
    }

    @Test func cellsToDirectedEdge() throws(SwiftyH3Error) {
        let directededge = H3DirectedEdge("115283473fffffff")!

        #expect(try cell.directedEdge(to: H3Cell("85283477fffffff")!) == directededge)
    }

    @Test func cellsNotToDirectedEdge() throws(SwiftyH3Error) {
        // Cell arguments are not neighbors
        #expect(throws: SwiftyH3Error.H3Error(11)) {
            try cell.directedEdge(to: H3Cell("8528342bfffffff")!)
        }
    }

    @Test func getBaseCellNumber() {
        #expect(cell.baseCellNumber == 20)
    }

    @Test func getResolution() throws(SwiftyH3Error) {
        #expect(try cell.resolution == .res5)
    }

    @Test func gridDisk() throws(SwiftyH3Error) {
        let disk = [
            "85283473fffffff", "85283447fffffff", "8528347bfffffff", "85283463fffffff", "85283477fffffff", "8528340ffffffff", "8528340bfffffff"
        ].map { cellString in H3Cell(cellString)! }

        #expect(try cell.gridDisk(distance: 1) == disk)
    }

    @Test func gridDistance() throws(SwiftyH3Error) {
        #expect(try cell.gridDistance(to: H3Cell("8528342bfffffff")!) == 2)
    }
    
    @Test func gridPathCells() throws(SwiftyH3Error) {
        let path = [
            H3Cell("85283473fffffff")!,
            H3Cell("85283477fffffff")!,
            H3Cell("8528342bfffffff")!,
        ]

        #expect(try cell.path(to: H3Cell("8528342bfffffff")!) == path)
    }

    @Test func gridRing() throws(SwiftyH3Error) {
        let ring = [
            "8528340bfffffff", "85283447fffffff", "8528347bfffffff", "85283463fffffff", "85283477fffffff", "8528340ffffffff"
        ].map { cellString in H3Cell(cellString)! }

        #expect(try cell.gridRing(distance: 1) == ring)
    }

    @Test func intToString() throws(SwiftyH3Error) {
        #expect(try H3Cell(599686042433355775).h3String == "85283473fffffff")
    }

    @Test func isPentagon() throws(SwiftyH3Error) {
        #expect(!cell.isPentagon)
    }

    @Test func isResClassIII() throws(SwiftyH3Error) {
        #expect(cell.isResClassIII)
    }

    @Test func isValidCell() throws(SwiftyH3Error) {
        #expect(cell.isValid)
        #expect(H3Cell("85283473ffff") == nil)
    }

    @Test func originToDirectedEdges() throws(SwiftyH3Error) {
        let edges = [
            H3DirectedEdge("115283473fffffff")!,
            H3DirectedEdge("125283473fffffff")!,
            H3DirectedEdge("135283473fffffff")!,
            H3DirectedEdge("145283473fffffff")!,
            H3DirectedEdge("155283473fffffff")!,
            H3DirectedEdge("165283473fffffff")!,
        ]

        #expect(try cell.directedEdges == edges)
    }

    @Test func stringToInt() throws(SwiftyH3Error) {
        #expect(try "85283473fffffff".asH3Index == 599686042433355775)
    }
}

struct CellMoreTests {
    let cell = H3Cell("8928342e20fffff")!

    @Test func cellToLatLng() throws(SwiftyH3Error) {
        let center = try cell.center

        #expect(
            center.longitude.converted(to: .degrees).value.isApproximatelyEqual(to: -122.5003039349)
        )
        #expect(
            center.latitude.converted(to: .degrees).value.isApproximatelyEqual(to: 37.5012466151))
    }

    @Test func cellToBoundary() throws(SwiftyH3Error) {
        let boundary = try cell.boundary

        #expect(
            boundary[0].longitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: -122.4990471431))
        #expect(
            boundary[0].latitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: 37.4997389893))

        #expect(
            boundary[1].longitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: -122.4979805011))
        #expect(
            boundary[1].latitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: 37.5014245698))

        #expect(
            boundary[2].longitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: -122.4992373065))
        #expect(
            boundary[2].latitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: 37.5029321860))

        #expect(
            boundary[3].longitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: -122.5015607527))
        #expect(
            boundary[3].latitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: 37.5027541980))

        #expect(
            boundary[4].longitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: -122.5026273256))
        #expect(
            boundary[4].latitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: 37.5010686174))

        #expect(
            boundary[5].longitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: -122.5013705214))
        #expect(
            boundary[5].latitude.converted(to: .degrees).value.isApproximatelyEqual(
                to: 37.4995610248))
    }

    @Test func cellToParent() throws(SwiftyH3Error) {
        let parent = H3Cell("832834fffffffff")!

        #expect(try cell.parent(at: .res3) == parent)
    }
}

struct InvalidCellTests {
    // SwiftyH3 returns .invalidInput instead of .H3Error(5), because input is validated before execution
    let invalidCell = H3Cell("115283473fffffff")!

    @Test func notCellArea() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try invalidCell.area
        }
    }

    @Test func notCellAreaRads2() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try invalidCell.areaRads2
        }
    }

    @Test func invalidCellToLatLng() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try invalidCell.center
        }
    }

    @Test func notCellToVertex() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try invalidCell.vertex(0)
        }
    }

    @Test func notCellToVertexes() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try invalidCell.vertices
        }
    }
}

struct MultiPolygonTests {
    static let cellsStrings: [[String]] = [
        "872830828ffffff,87283082effffff".split(separator: ",").map(String.init),
        "872830828ffffff,87283082effffff,872831828ffffff".split(separator: ",").map(String.init),
        [
            "8528340bfffffff", "85283447fffffff", "8528347bfffffff", "85283463fffffff",
            "85283477fffffff", "8528340ffffffff",
        ],
        [
            "8528340bfffffff", "85283447fffffff", "8528347bfffffff", "85283463fffffff",
            "85283477fffffff", "8528340ffffffff", "8528840ffffffff",
        ],
        [
            "8528340bfffffff",
            "85283447fffffff",
            "8528347bfffffff",
            "85283463fffffff",
            "85283477fffffff",
            "8528340ffffffff",
            "8528840ffffffff",
        ],
    ]

    static let multiPolygonArrays: [[[[[Double]]]]] = [
        [
            [
                [
                    [37.784046, -122.427089], [37.772267, -122.434586], [37.761736, -122.425769],
                    [37.762982, -122.409455], [37.752446, -122.400640], [37.753689, -122.384324],
                    [37.765468, -122.376819], [37.776004, -122.385635], [37.774761, -122.401954],
                    [37.785293, -122.410771],
                ]
            ]
        ],
        [
            [
                [
                    [37.784046, -122.427089], [37.772267, -122.434586], [37.761736, -122.425769],
                    [37.762982, -122.409455], [37.752446, -122.400640], [37.753689, -122.384324],
                    [37.765468, -122.376819], [37.776004, -122.385635], [37.774761, -122.401954],
                    [37.785293, -122.410771],
                ]
            ],
            [
                [
                    [38.231228, -123.642760], [38.229797, -123.658996], [38.218020, -123.666324],
                    [38.207675, -123.657418], [38.209105, -123.641184], [38.220882, -123.633853],
                ]
            ],
        ],
        [
            [
                [
                    [37.106073, -122.020493], [37.114176, -121.906636], [37.196816, -121.853848],
                    [37.204791, -121.739761], [37.287359, -121.686742], [37.361955, -121.747972],
                    [37.444452, -121.694882], [37.518923, -121.756207], [37.510841, -121.870623],
                    [37.585130, -121.932045], [37.576863, -122.046394], [37.494361, -122.099157],
                    [37.485965, -122.213273], [37.403391, -122.265803], [37.329215, -122.204381],
                    [37.246571, -122.256843], [37.172270, -122.195515], [37.180556, -122.081726],
                ],
                [
                    [37.428341, -121.923550], [37.353926, -121.862223], [37.271356, -121.915080],
                    [37.263198, -122.029101], [37.337556, -122.090429], [37.420129, -122.037735],
                ],
            ]
        ],
        [
            [
                [
                    [37.114176, -121.906636], [37.196816, -121.853848], [37.204791, -121.739761],
                    [37.287359, -121.686742], [37.361955, -121.747972], [37.444452, -121.694882],
                    [37.518923, -121.756207], [37.510841, -121.870623], [37.585130, -121.932045],
                    [37.576863, -122.046394], [37.494361, -122.099157], [37.485965, -122.213273],
                    [37.403391, -122.265803], [37.329215, -122.204381], [37.246571, -122.256843],
                    [37.172270, -122.195515], [37.180556, -122.081726], [37.106073, -122.020493],
                ],
                [
                    [37.337556, -122.090429], [37.420129, -122.037735], [37.428341, -121.923550],
                    [37.353926, -121.862223], [37.271356, -121.915080], [37.263198, -122.029101],
                ],
            ],
            [
                [
                    [43.431278, -115.975237], [43.508096, -115.912429], [43.581386, -115.974912],
                    [43.577810, -116.100258], [43.500970, -116.162919], [43.427727, -116.100382],
                ]
            ],
        ],
    ]

    @Test(arguments: zip(cellsStrings, multiPolygonArrays))
    func cellsToMultiPolygon(cellStrings: [String], multiPolygon: [[[[Double]]]]) throws(SwiftyH3Error) {
        let h3cells = cellStrings.map { cellStr in H3Cell(cellStr)! }

        let h3multipolygon = try h3cells.multiPolygon

        for (polygonIndex, polygon) in h3multipolygon.enumerated() {
            for (boundaryPairIndex, boundaryPair) in polygon.boundary.enumerated() {
                #expect(
                    boundaryPair.latitudeDegs.isApproximatelyEqual(
                        to: multiPolygon[polygonIndex][0][boundaryPairIndex][0]))
                #expect(
                    boundaryPair.longitudeDegs.isApproximatelyEqual(
                        to: multiPolygon[polygonIndex][0][boundaryPairIndex][1]))
            }

            for (holeIndex, hole) in polygon.holes.enumerated() {
                for (holePairIndex, holePair) in hole.enumerated() {
                    #expect(
                        holePair.latitudeDegs.isApproximatelyEqual(
                            to: multiPolygon[polygonIndex][holeIndex + 1][holePairIndex][0]))
                    #expect(
                        holePair.longitudeDegs.isApproximatelyEqual(
                            to: multiPolygon[polygonIndex][holeIndex + 1][holePairIndex][1]))
                }
            }
        }
    }
}

struct CompactCellsTests {
    static let uncompactedStrings = [
        "85283473fffffff",
        "85283447fffffff",
        "8528347bfffffff",
        "85283463fffffff",
        "85283477fffffff",
        "8528340ffffffff",
        "8528340bfffffff",
        "85283457fffffff",
        "85283443fffffff",
        "8528344ffffffff",
        "852836b7fffffff",
        "8528346bfffffff",
        "8528346ffffffff",
        "85283467fffffff",
        "8528342bfffffff",
        "8528343bfffffff",
        "85283407fffffff",
        "85283403fffffff",
        "8528341bfffffff",
    ]

    static let compactedStrings =
        "85283447fffffff,8528340ffffffff,8528340bfffffff,85283457fffffff,85283443fffffff,8528344ffffffff,852836b7fffffff,8528342bfffffff,8528343bfffffff,85283407fffffff,85283403fffffff,8528341bfffffff,8428347ffffffff"
        .split(separator: ",").map(String.init)

    static let uncompactedCells = uncompactedStrings.map { cellString in H3Cell(cellString)! }
    static let compactedCells = compactedStrings.map { cellString in H3Cell(cellString)! }

    @Test func compactCells() throws(SwiftyH3Error) {
        #expect(try Self.uncompactedCells.compacted == Self.compactedCells)
    }

    @Test func uncompactCells() throws(SwiftyH3Error) {
        #expect(try Set(Self.compactedCells.uncompacted(at: .res5)) == Set(Self.uncompactedCells))
    }
}

struct DirectedEdgeTests {
    let directedEdge = H3DirectedEdge("115283473fffffff")!
    let invalidEdge = H3DirectedEdge("85283473fffffff")!

    @Test func directedEdgeToBoundary() throws(SwiftyH3Error) {
        let boundary = try directedEdge.boundary

        #expect(boundary[0].longitudeDegs.isApproximatelyEqual(to: -122.0377349643))
        #expect(boundary[0].latitudeDegs.isApproximatelyEqual(to: 37.4201286777))

        #expect(boundary[1].longitudeDegs.isApproximatelyEqual(to: -122.0904289290))
        #expect(boundary[1].latitudeDegs.isApproximatelyEqual(to: 37.3375560844))
    }

    @Test func notDirectedEdgeToBoundary() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) { try invalidEdge.boundary }
    }

    @Test func directedEdgeToCells() throws(SwiftyH3Error) {
        #expect(try directedEdge.origin == H3Cell("85283473fffffff")!)
        #expect(try directedEdge.destination == H3Cell("85283477fffffff")!)
    }

    @Test func notDirectedEdgeOrigin() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try invalidEdge.origin
        }
    }

    @Test func notDirectedEdgeDestination() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try invalidEdge.destination
        }
    }

    @Test func edgeLengthKm() throws(SwiftyH3Error) {
        #expect(
            try directedEdge.length.converted(to: .kilometers).value.isApproximatelyEqual(
                to: 10.2947360862))
    }

    @Test func notEdgeLength() throws(SwiftyH3Error) {
        #expect(throws: SwiftyH3Error.invalidInput) {
            try invalidEdge.length
        }
    }

    @Test func edgeLengthM() throws(SwiftyH3Error) {
        #expect(try directedEdge.length.value.isApproximatelyEqual(to: 10294.7360861995))
    }

    @Test func edgeLengthRads() throws(SwiftyH3Error) {
        #expect(try directedEdge.lengthRads.value.isApproximatelyEqual(to: 0.0016158726))
    }

    @Test func isValidDirectedEdge() {
        #expect(directedEdge.isValid)
        #expect(!invalidEdge.isValid)
    }
}

struct GlobalConstantTests {
    @Test func getHexagonAreaAvgKm2() throws(SwiftyH3Error) {
        #expect(
            H3Cell.Resolution
                .res0
                .averageHexagonArea
                .converted(to: .squareKilometers)
                .value
                .isApproximatelyEqual(to: 4357449.4160783831)
        )
    }

    @Test func getHexagonAreaAvgM2() throws(SwiftyH3Error) {
        #expect(
            H3Cell.Resolution
                .res0
                .averageHexagonArea
                .value
                .isApproximatelyEqual(to: 4357449416078.3901367188)
        )
    }

    @Test func getHexagonEdgeLengthAvgKm() throws(SwiftyH3Error) {
        #expect(
            H3Cell.Resolution
                .res0
                .averageHexagonEdgeLength
                .converted(to: .kilometers)
                .value
                .isApproximatelyEqual(to: 1281.2560110000)
        )
    }

    @Test func getHexagonEdgeLengthAvgM() throws(SwiftyH3Error) {
        #expect(
            H3Cell.Resolution
                .res0
                .averageHexagonEdgeLength
                .value
                .isApproximatelyEqual(to: 1281256.0109999999)
        )
    }

    @Test func getNumCells() throws(SwiftyH3Error) {
        #expect(
            H3Cell.Resolution.res0.numberOfCells == 122
        )
    }

    @Test func getPentagons() throws(SwiftyH3Error) {
        let pentagons0 = [
            "8009fffffffffff", "801dfffffffffff", "8031fffffffffff", "804dfffffffffff",
            "8063fffffffffff", "8075fffffffffff", "807ffffffffffff", "8091fffffffffff",
            "80a7fffffffffff", "80c3fffffffffff", "80d7fffffffffff", "80ebfffffffffff",
        ].map { cellString in H3Cell(cellString)! }

        #expect(H3Cell.Resolution.res0.pentagons == pentagons0)
    }

    @Test func getRes0Cells() throws(SwiftyH3Error) {
        let res0cells = [
            "8001fffffffffff", "8003fffffffffff", "8005fffffffffff", "8007fffffffffff",
            "8009fffffffffff", "800bfffffffffff", "800dfffffffffff", "800ffffffffffff",
            "8011fffffffffff", "8013fffffffffff", "8015fffffffffff", "8017fffffffffff",
            "8019fffffffffff", "801bfffffffffff", "801dfffffffffff", "801ffffffffffff",
            "8021fffffffffff", "8023fffffffffff", "8025fffffffffff", "8027fffffffffff",
            "8029fffffffffff", "802bfffffffffff", "802dfffffffffff", "802ffffffffffff",
            "8031fffffffffff", "8033fffffffffff", "8035fffffffffff", "8037fffffffffff",
            "8039fffffffffff", "803bfffffffffff", "803dfffffffffff", "803ffffffffffff",
            "8041fffffffffff", "8043fffffffffff", "8045fffffffffff", "8047fffffffffff",
            "8049fffffffffff", "804bfffffffffff", "804dfffffffffff", "804ffffffffffff",
            "8051fffffffffff", "8053fffffffffff", "8055fffffffffff", "8057fffffffffff",
            "8059fffffffffff", "805bfffffffffff", "805dfffffffffff", "805ffffffffffff",
            "8061fffffffffff", "8063fffffffffff", "8065fffffffffff", "8067fffffffffff",
            "8069fffffffffff", "806bfffffffffff", "806dfffffffffff", "806ffffffffffff",
            "8071fffffffffff", "8073fffffffffff", "8075fffffffffff", "8077fffffffffff",
            "8079fffffffffff", "807bfffffffffff", "807dfffffffffff", "807ffffffffffff",
            "8081fffffffffff", "8083fffffffffff", "8085fffffffffff", "8087fffffffffff",
            "8089fffffffffff", "808bfffffffffff", "808dfffffffffff", "808ffffffffffff",
            "8091fffffffffff", "8093fffffffffff", "8095fffffffffff", "8097fffffffffff",
            "8099fffffffffff", "809bfffffffffff", "809dfffffffffff", "809ffffffffffff",
            "80a1fffffffffff", "80a3fffffffffff", "80a5fffffffffff", "80a7fffffffffff",
            "80a9fffffffffff", "80abfffffffffff", "80adfffffffffff", "80affffffffffff",
            "80b1fffffffffff", "80b3fffffffffff", "80b5fffffffffff", "80b7fffffffffff",
            "80b9fffffffffff", "80bbfffffffffff", "80bdfffffffffff", "80bffffffffffff",
            "80c1fffffffffff", "80c3fffffffffff", "80c5fffffffffff", "80c7fffffffffff",
            "80c9fffffffffff", "80cbfffffffffff", "80cdfffffffffff", "80cffffffffffff",
            "80d1fffffffffff", "80d3fffffffffff", "80d5fffffffffff", "80d7fffffffffff",
            "80d9fffffffffff", "80dbfffffffffff", "80ddfffffffffff", "80dffffffffffff",
            "80e1fffffffffff", "80e3fffffffffff", "80e5fffffffffff", "80e7fffffffffff",
            "80e9fffffffffff", "80ebfffffffffff", "80edfffffffffff", "80effffffffffff",
            "80f1fffffffffff", "80f3fffffffffff",
        ].map { cellString in H3Cell(cellString)! }

        #expect(H3Cell.res0Cells == res0cells)
    }
}

struct LatLngTests {
    let point1 = H3LatLng(latitudeDegs: 0, longitudeDegs: 1)
    let point2 = H3LatLng(latitudeDegs: 1, longitudeDegs: 2)

    @Test func greatCircleDistanceKm() {
        #expect(
            point1
            .distance(to: point2)
            .converted(to: .kilometers)
            .value
            .isApproximatelyEqual(to: 157.2495585118)
        )
    }

    @Test func greatCircleDistanceM() {
        #expect(
            point1
            .distance(to: point2)
            .value
            .isApproximatelyEqual(to: 157249.5585117787)
        )
    }

    @Test func greatCircleDistanceRads() {
        #expect(
            point1
            .distanceRads(to: point2)
            .value
            .isApproximatelyEqual(to: 0.0246820564)
        )
    }

    @Test func latLngToCell() throws(SwiftyH3Error) {
        #expect(try H3LatLng(latitudeDegs: 20, longitudeDegs: 123).cell(at: .res2) == H3Cell("824b9ffffffffff")!)
    }
}

struct VertexTests {
    let vertex = H3Vertex("22528340bfffffff")!
    let invalidVertex = H3Vertex("85283473fffffff")!

    @Test func isValidVertex() {
        #expect(vertex.isValid)
        #expect(!invalidVertex.isValid)
    }

    @Test func vertexToLatLng() throws(SwiftyH3Error) {
        #expect(try vertex.latLng.latitudeDegs.isApproximatelyEqual(to: 37.2713558667))
        #expect(try vertex.latLng.longitudeDegs.isApproximatelyEqual(to: -121.9150803271))
    }
}

struct PolygonTests {
    let polygon1 = H3Polygon(
        [
            H3LatLng(latitudeDegs: 37.813318999983238, longitudeDegs: -122.4089866999972145),
            H3LatLng(latitudeDegs: 37.7198061999978478, longitudeDegs: -122.3544736999993603),
            H3LatLng(latitudeDegs: 37.8151571999998453, longitudeDegs: -122.4798767000009008),
        ],
        holes: []
    )

    let cells1 = [
        H3Cell("87283082bffffff")!,
        H3Cell("872830870ffffff")!,
        H3Cell("872830820ffffff")!,
        H3Cell("87283082effffff")!,
        H3Cell("872830828ffffff")!,
        H3Cell("87283082affffff")!,
        H3Cell("872830876ffffff")!,
    ]

    let polygon2 = H3Polygon(
        [
            H3LatLng(latitudeDegs: 37.784046, longitudeDegs: -122.427089),
            H3LatLng(latitudeDegs: 37.772267, longitudeDegs: -122.434586),
            H3LatLng(latitudeDegs: 37.761736, longitudeDegs: -122.425769),
            H3LatLng(latitudeDegs: 37.762982, longitudeDegs: -122.409455),
            H3LatLng(latitudeDegs: 37.752446, longitudeDegs: -122.400640),
            H3LatLng(latitudeDegs: 37.753689, longitudeDegs: -122.384324),
            H3LatLng(latitudeDegs: 37.765468, longitudeDegs: -122.376819),
            H3LatLng(latitudeDegs: 37.776004, longitudeDegs: -122.385635),
            H3LatLng(latitudeDegs: 37.774761, longitudeDegs: -122.401954),
            H3LatLng(latitudeDegs: 37.785293, longitudeDegs: -122.410771),
        ],
        holes: []
    )

    let cells2 = [
        H3Cell("872830828ffffff")!,
        H3Cell("87283082effffff")!,
    ]

    @Test func polygonToCells() throws(SwiftyH3Error) {
        #expect(try polygon1.cells(at: .res7) == cells1)
        #expect(try polygon2.cells(at: .res7) == cells2)
    }
}