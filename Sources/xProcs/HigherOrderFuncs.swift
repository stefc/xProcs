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

public func recursive<T, U>(_ f: @escaping TwiceUnary<T,U>) -> Unary<T,U>
{
    return { x in return f(recursive(f))(x) }
}

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

/*
 
 Over Engineering at the moment  'x §§ then-clause § else-clause' !
 
precedencegroup HeadTailPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

precedencegroup ThenElsePrecedence {
    associativity: left
    higherThan: HeadTailPrecedence
}

infix operator § : ThenElsePrecedence

public func § <Element,SubSeq,U> (
    thenBranch: @escaping (Element, SubSeq) -> U,
    elseBranch: @escaping  () -> U) -> (left:  (Element, SubSeq) -> U, right: () -> U)
{
    return (left:thenBranch, right: elseBranch)
}

infix operator §§ : HeadTailPrecedence

public func §§ <C:HeadTailSeparation,U>( lhs: C,
                                           rhs: (left:(C.Element, C.SubSequence) -> U,right:() -> U)) -> U
{
    return iif( lhs, rhs.left, rhs.right)
}

*/
