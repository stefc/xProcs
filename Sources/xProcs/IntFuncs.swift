import Foundation

public func IntPow(_ base: Int, exp: Int) -> Int {
    guard exp >= 0 else {
        return 0
    }
    guard exp > 0 else {
        return 1
    }
    return (1..<exp).reduce(base) { (accu, _) in accu * abs(base) }
}

public func IntPow10(exp: Int) -> Int {
    return IntPow(10, exp: exp) 
}

public func IntPow2(exp: Int) -> Int {
    return 1 << exp
}

