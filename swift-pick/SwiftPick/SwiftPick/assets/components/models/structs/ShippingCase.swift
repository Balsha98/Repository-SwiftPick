public struct ShippingCase {
    public let label: String
    public let additionalInfo: String
    public let cost: Double
}//ShippingCase

public struct ShippingCases {
    public let cases: [ShippingMethods: ShippingCase] = [
        .free: ShippingCase(label: "Free Shipping", additionalInfo: "", cost: 0),
        .insuredStandard: ShippingCase(label: "Insured Standard Shipping", additionalInfo: "Avg. 3-5 Business Days", cost: 12),
        .insuredTwoDay: ShippingCase(label: "Insured Two-Day Shipping", additionalInfo: "Avg. 2 Transit Day", cost: 18)
    ]//cases
}//ShippingCases
