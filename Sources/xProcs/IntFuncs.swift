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

// percentage -> (value/base) x 100 
public func IntPercent(b: Int, v: Int) -> Int
{
    return Int((Double(v) / Double(b)) * 100.0)
}

// base -> (value x 100) / percentage
public func IntBase(p: Int, v: Int) -> Int 
{
    return Int((Double(v) * 100.0) / Double(p))
}

// value -> (percentage x base) / 100
public func IntValue(p: Int, b: Int) -> Int 
{
    return Int((Double(p) * Double(b)) / 100.0)
}

// Operator Overloading '<base> ** <exp>' 

precedencegroup ExponentiationPrecedence {
  associativity: right
  higherThan: MultiplicationPrecedence
}

infix operator ** : ExponentiationPrecedence

public func ** (_ base: Int, _ exp: Int) -> Int {
    return IntPow(base, exp: exp)
}