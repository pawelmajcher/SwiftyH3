
public enum SwiftyH3Error: Error, Equatable {
    /// An error returned from the H3 library with associated error code.
    /// 
    /// Use the ``errorDescription`` property of the error or refer to the
    /// [table of error codes](https://h3geo.org/docs/library/errors#table-of-error-codes)
    /// in the library documentation.
    case H3Error(UInt32)

    /// The H3 library returned an unexpected value after finishing with no error code.
    case returnedInvalidValue

    /// SwiftyH3 recognized that a function/property cannot be executed/accessed for
    /// a given input.
    /// 
    /// This should usually normally occur only if an H3 index is invalid for the struct
    /// type (i.e., a vertex index initialized as H3Cell) it's in or when another value
    /// is invalid (e.g., the latitude is more than 90 degrees).
    case invalidInput
}