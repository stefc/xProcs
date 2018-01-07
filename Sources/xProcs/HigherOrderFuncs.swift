//
//  HigherOrderFuncs.swift
//  xProcs
//
//  Created by Stefan Boether on 07.01.18.
//

import Foundation

public func iif<T,U>( _ optional: T?, _ lhs: (T) -> U, _ rhs: () -> U) -> U {
    if let x = optional {
        return lhs(x)
    }
    return rhs()
}

/*
 public func iif<S:Sequence,U>( _ sequence: S, _ lhs: (S.Element, S.SubSequence) -> U, _ rhs: () -> U) where S.Element : Optional
{
    if let x = sequence.first {
        return(lhs(x, sequence.dropFirst()))
    }
    return rhs()
}
 */
