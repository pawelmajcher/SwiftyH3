
extension H3CellResolution {
    public func finer(plus levels: Int32 = 1) -> H3CellResolution? {
        H3CellResolution(rawValue: self.rawValue + levels)
    }

    public func coarser(minus levels: Int32 = 1) -> H3CellResolution? {
        H3CellResolution(rawValue: self.rawValue - levels)
    }
}