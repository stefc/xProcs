import Foundation

let ZERO = Decimal(0.000000001)

private func equalZero(_ x: Decimal) -> Bool {
    return (x >= -ZERO) && (x <= ZERO)
}

public func round(_ x: Decimal, scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
    var number = x
    var result = Decimal(0)
    NSDecimalRound(&result, &number, scale, roundingMode)
    return result
}