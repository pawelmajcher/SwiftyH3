
extension H3Cell.Resolution {
    /// More detailed resolution by provided number of levels.
    public func finer(plus levels: Int32 = 1) -> H3Cell.Resolution? {
        H3Cell.Resolution(rawValue: self.rawValue + levels)
    }

    /// Less detailed resolution by provided number of levels.
    public func coarser(minus levels: Int32 = 1) -> H3Cell.Resolution? {
        H3Cell.Resolution(rawValue: self.rawValue - levels)
    }
}