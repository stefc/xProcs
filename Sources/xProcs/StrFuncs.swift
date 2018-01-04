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