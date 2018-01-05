import XCTest
import xProcs

class DecimalTests: XCTestCase {

    func testRoundPlain() {
        XCTAssertEqual(round(13.3649, scale: 2), 13.36)
        XCTAssertEqual(round(13.3650, scale: 2), 13.37)
        XCTAssertEqual(round(13.3660, scale: 2), 13.37)
        XCTAssertEqual(round(-13.3749, scale: 2), -13.37)
        XCTAssertEqual(round(-13.3750, scale: 2), -13.38)
        XCTAssertEqual(round(-13.3761, scale: 2), -13.38)
    }

    func testRoundBankers() {
        XCTAssertEqual(round(13.3649, scale: 2, .bankers), 13.36)
        XCTAssertEqual(round(13.3650, scale: 2, .bankers), 13.36)
        XCTAssertEqual(round(13.3660, scale: 2, .bankers), 13.37)
        XCTAssertEqual(round(-13.3749, scale: 2, .bankers), -13.37)
        XCTAssertEqual(round(-13.3750, scale: 2, .bankers), -13.38)
        XCTAssertEqual(round(-13.3761, scale: 2, .bankers), -13.38)
    }
    
    static var allTests = [
        ("testRoundPlain", testRoundPlain),
        ("testRoundBankers", testRoundBankers),
    ]
}