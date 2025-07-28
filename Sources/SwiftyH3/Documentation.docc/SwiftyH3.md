# ``SwiftyH3``

The Swifty way to use Uber's H3 geospatial indexing system.

SwiftyH3 contains bindings to the [reference library in C](https://github.com/uber/h3.git) that allow you to inspect, decode, and traverse through geospatial data stored as H3 indexes. The library contains ``H3Cell``, ``H3DirectedEdge``, and ``H3Vertex`` structures for all currently supported types of indexes with relevant properties and methods.

H3 indexes and sequences of them can represent specific areas and coordinates. SwiftyH3 includes native support types to represent those concepts. ``H3LatLng`` (point), ``H3Loop`` (linear ring), ``H3Polygon``, and ``H3MultiPolygon`` have meanings equivalent to those in the GeoJSON standard specification.

## Topics

### H3 Indexes

- ``H3Indexable``
- ``H3Cell``
- ``H3DirectedEdge``
- ``H3Vertex``

### Geospatial Primitives

- ``H3LatLng``
- ``H3Loop``
- ``H3Polygon``
- ``H3MultiPolygon``