import Foundation

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

/*
 old: 72 new: 90 k: 41708
 old: 101 new: 199 k: 5622
 old: 108 new: 121 k: 14338
 old: 108 new: 84 k: 35165
 old: 111 new: 230 k: 8518
 old: 32 new: 1 k: 42490
 old: 87 new: 242 k: 21307
 old: 111 new: 60 k: 42090
 old: 114 new: 214 k: 13567
 old: 108 new: 88 k: 4298
 old: 100 new: 116 k: 37925
 */

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
