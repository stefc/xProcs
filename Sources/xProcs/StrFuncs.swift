import Foundation

// string padding on the left and right side  padL() & padR() 

public func padL(_ string : String, count: Int, char: Character = " ") -> String {
    guard string.count < count else {
        return string
    }
    return String(repeating: char, count: count - string.count) + string
}

public func padR(_ string : String, count: Int, char: Character = " ") -> String {
     guard string.count < count else {
        return string
    }
    return string + String(repeating: char, count: count - string.count) 
}

// simple string encryption with encrypt() and decrypt() 

let C1 : UInt16 = 52845;
let C2 : UInt16 = 22719;

public func encrypt(_ cleartext: String, key: Int) -> String
{
    var data = cleartext.data(using: .utf8)!
    var k = UInt16(key)
    for index in 0..<data.count {
        let oldByte = data[index]
        let newByte = oldByte ^ UInt8(k >> 8)
        k = (UInt16(newByte)
            .addingReportingOverflow(k).partialValue)
            .multipliedReportingOverflow(by: C1).partialValue
            .addingReportingOverflow(C2).partialValue
        data[index] = newByte
    }
    return data.base64EncodedString()
}

public func decrypt(_ chiper: String, key: Int) -> String {
    var data = Data(base64Encoded: chiper)!
    var k = UInt16(key)
    for index in 0..<data.count {
        let oldByte = data[index]
        let newByte = oldByte ^ UInt8(k >> 8)
        k = (UInt16(oldByte)
            .addingReportingOverflow(k).partialValue)
            .multipliedReportingOverflow(by: C1).partialValue
            .addingReportingOverflow(C2).partialValue
        data[index] = newByte
    }
    return String(data: data, encoding: .utf8)!
}