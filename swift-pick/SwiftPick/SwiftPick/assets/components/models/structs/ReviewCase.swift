public struct ReviewCase {
    public let stars: ReviewStars
    public let value: Int
}//ReviewCase

public struct ReviewCases {
    public let cases: [ReviewCase] = [
        ReviewCase(stars: .all, value: 0),
        ReviewCase(stars: .one, value: 1),
        ReviewCase(stars: .two, value: 2),
        ReviewCase(stars: .three, value: 3),
        ReviewCase(stars: .four, value: 4),
        ReviewCase(stars: .five, value: 5),
    ]//cases
}//ReviewCases
