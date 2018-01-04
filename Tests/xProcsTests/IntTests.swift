import XCTest
import xProcs

class IntTests: XCTestCase {

    func testIntPow() {
        XCTAssertEqual(IntPow(5, exp: 2), 25)
        XCTAssertEqual(IntPow(5, exp: 1), 5)
        XCTAssertEqual(IntPow(5, exp: 0), 1)
    }

    func testIntPow10() {
        XCTAssertEqual(IntPow10(exp: 2), 100)
        XCTAssertEqual(IntPow10(exp: 1), 10)
        XCTAssertEqual(IntPow10(exp: 0), 1)
    }

    func testIntPow2() {
        XCTAssertEqual(IntPow2(exp: 8), 256)
        XCTAssertEqual(IntPow2(exp: 1), 2)
        XCTAssertEqual(IntPow2(exp: 0), 1)
    }

    func testIntPowOperator() {
        XCTAssertEqual(5 ** 2, 25)
        XCTAssertEqual(5 ** 1, 5)
        XCTAssertEqual(5 ** 0, 1)
    }

    func testIntPercent() {

        // Die monatlichen Heizkosten betragen 6.000€, die Grundgebühren. Wieviel Prozent sind das?
        let percent = IntPercent(b:6_000, v:1_800)
        XCTAssertEqual(percent, 30, "must be 30%")

        // Auf dem Sparbuch werden 2% Zinsen gezahlt. Dies entspricht 250€. Wie hoch ist das Vermögen? 
        let base = IntBase(p: 2, v: 250)
        XCTAssertEqual(base, 12_500, "must be 12.500€")

        // Das Gehalt beträgt 1.600€. Es soll um 4% erhöht werden
        let value = IntValue(p: 4, b: 1_600)
        XCTAssertEqual(value, 64, "must be 1.600€ + 64€ = 1.664")
    }

    static var allTests = [
        ("testIntPow", testIntPow),
        ("testIntPow10", testIntPow10),
        ("testIntPow2", testIntPow2),
        ("testIntOperator", testIntPowOperator),
        ("testIntPercent", testIntPercent),
    ]
}