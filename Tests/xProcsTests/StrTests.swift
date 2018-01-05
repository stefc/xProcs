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

    func testEncryptDecrypt() {
        let key = 4711
        let cleartext = "Hello World"
        let encrypted = encrypt(cleartext, key: key)
        XCTAssertEqual("Wsd5VOYB8jzWWHQ=", encrypted)
        XCTAssertNotEqual(cleartext, encrypted)
        let decrypted = decrypt(encrypted, key: key)
        XCTAssertEqual(cleartext, decrypted)
    }

    static var allTests = [
        ("testPadR", testPadR),
        ("testPadL", testPadL),
        ("testEncryptDecrypt", testEncryptDecrypt),
    ]
}
