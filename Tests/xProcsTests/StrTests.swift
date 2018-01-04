import XCTest
import xProcs

class StrTests: XCTestCase {

    func testPadR() {
        let paddedString = padR("Hello", count: 10)
        XCTAssertEqual(paddedString.count, 10)
        XCTAssertEqual(paddedString, "Hello     ")

        let paddedXX = padR("Hello", count: 10, char: "X")
        XCTAssertEqual(paddedXX, "HelloXXXXX")
    }

    func testPadL() {
        let paddedString = padL("Hello", count: 10)
        XCTAssertEqual(paddedString.count, 10)
        XCTAssertEqual(paddedString, "     Hello")

        let padded__ = padL("Hello", count: 10, char: "_")
        XCTAssertEqual(padded__, "_____Hello")
    }

    static var allTests = [
        ("testPadR", testPadR),
        ("testPadL", testPadL),
    ]
}