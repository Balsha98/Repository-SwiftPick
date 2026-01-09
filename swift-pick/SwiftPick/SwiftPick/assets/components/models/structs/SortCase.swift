public struct SortCase {
    public let label: String
    public let sortBy: SortParams
}//SortCase

public struct SortCases {
    public let cases: [SortCase] = [
        SortCase(label: "Name - A-Z", sortBy: .nameLow),
        SortCase(label: "Name - Z-A", sortBy: .nameHigh),
        SortCase(label: "Price - Low to High", sortBy: .priceLow),
        SortCase(label: "Price - High to Low", sortBy: .priceHigh)
    ]//cases
}//SortCases
