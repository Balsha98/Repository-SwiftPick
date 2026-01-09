public struct GenderCase {
    public let label: String
    public let type: GenderTypes
}//GenderCase

public struct GenderCases {
    public let cases: [GenderCase] = [
        GenderCase(label: "Male", type: .male),
        GenderCase(label: "Female", type: .female)
    ]//cases
}//GenderCases
