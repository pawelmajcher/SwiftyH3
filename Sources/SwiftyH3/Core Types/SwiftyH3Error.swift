
enum SwiftyH3Error: Error, Equatable {
    case H3Error(UInt32)
    case returnedInvalidValue
    case invalidInput
}