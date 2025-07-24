
import Foundation
import Ch3

extension SwiftyH3Error {
    private static func describeH3Error(errorCode: Ch3.H3Error) -> String? {
        guard
            let cDescription: UnsafePointer<CChar> = Ch3.describeH3Error(errorCode)
        else { return nil }

        return String(cString: cDescription)
    }
}

extension SwiftyH3Error: LocalizedError {
    var errorDescription: String? {
        switch self {
            case let .H3Error(errorCode): 
                return SwiftyH3Error.describeH3Error(errorCode: errorCode)
            default:
                return (self as Error).localizedDescription
        }
    }
}