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

    static var allTests = [
        ("testIntPow", testIntPow),
        ("testIntPow10", testIntPow10),
        ("testIntPow2", testIntPow2),
    ]
}