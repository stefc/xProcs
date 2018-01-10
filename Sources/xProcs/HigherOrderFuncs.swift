//
//  HigherOrderFuncs.swift
//  xProcs
//
//  Created by Stefan Boether on 07.01.18.
//

import Foundation

public typealias Nullary<U> = () -> U
public typealias Unary<T,U> = (T) -> U
public typealias Binary<L,R,U> = (L,R) -> U
public typealias Ternary<F,S,T,U> = (F,S,T) -> U

// https://stackoverflow.com/a/30523286/1259996

public typealias TwiceUnary<T,U> = Unary<Unary<T,U>,Unary<T,U>>

public indirect enum Result<V,A> : Hashable where V : Hashable, A : Hashable {
    case Done(A)
    case Call(V, A)
    case Future(id: Int, lhs:Result<V,A>, rhs:Result<V,A>, op: (Result<V,A>,Result<V,A>) -> A)
    
    public var hashValue: Int {
        switch self {
        case .Done(let accu):
            return accu.hashValue << 17 ^ 7
        case .Call(let (value,_)):
            return value.hashValue << 19 ^ 5
        case .Future(let (id, _, _, _)):
            return id.hashValue << 23 ^ 11
        }
    }
}

public func == <V,A>(lhs: Result<V,A>, rhs: Result<V,A>) -> Bool {
    return true
}

public func recursive<T, U>(_ f: @escaping TwiceUnary<T,U>) -> Unary<T,U>
{
    return { x in return f(recursive(f))(x) }
}

/*
func withTrampoline<V,A>(_ f:@escaping Binary<V,A,Result<V,A>>) -> (Binary<V,A,A>) {
    return { (current:V,accumulator:A)->A in
        var res = f(current,accumulator)
        while true {
            switch res {
            case let .Done(accu):
                return accu
            case let .Call(num, accu):
                res = f(num,accu)
            }
            case let .Future(lhs,rhs,op):
                res = lhs
        }
    }
}
*/

// Memoization https://en.wikipedia.org/wiki/Memoization

public func memoize<T:Hashable, U>(_ fn : @escaping Unary<T,U>) -> Unary<T,U> {
    var cache = [T:U]()
    return { key in
        if let value = cache[key] { return value }
        let newValue = fn(key)
        cache[key] = newValue
        return newValue
    }
}

public protocol HeadTailSeparation {
    associatedtype Element
    associatedtype SubSequence
    
    var first : Element? { get }
    func rest() -> SubSequence
}

public func iif<T,U>( _ optional: T?, _ lhs: Unary<T,U>, _ rhs: Nullary<U>) -> U {
    if let x = optional {
        return lhs(x)
    }
    return rhs()
}

public func iif<C:HeadTailSeparation,U>( _ collection: C, _ lhs: (C.Element, C.SubSequence) -> U, _ rhs: () -> U) -> U
{
    if let x = collection.first {
        return(lhs(x, collection.rest()))
    }
    return rhs()
}

// http://natecook.com/blog/2014/10/ternary-operators-in-swift/

