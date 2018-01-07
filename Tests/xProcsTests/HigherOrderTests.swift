//
//  HigherOrderTests.swift
//  xProcsTests
//
//  Created by Stefan Boether on 07.01.18.
//

import XCTest

import xProcs

/*
  some notes about this tests
 
 what I would normally expect :
    - fibstack()  very slow
    - fibrecursive() some more performance
    - fibmemoization() very super performance
 
 what happens
    - testStack outperforms ???
    - testMemo slower than testRecursive ??
 
 any idea where I'm wrong with the underlying code ?
 */

func fibs() -> (Int) -> Int {
    return recursive { recur in
        { n in
            if n == 0 {
                return 0
            } else if n == 1{
                return 1
            }
            
            return recur(n - 1) + recur(n - 2)
        }
    }
}

func fibstack(_ n : Int) -> Int {
    if n == 0 {
        return 0
    } else if n == 1{
        return 1
    }
    
    return fibstack(n - 1) + fibstack(n - 2)
}


class HigherOrderTests: XCTestCase {

    
    func testStack() {
        XCTAssertEqual(fibstack(7), 13)
        
        //self.measure {
        XCTAssertEqual(fibstack(32), 2178309)          // 7sec on my machine !
        //}
    }
    
    func testRecursive() {
        
        let fibonacci = fibs()
        
        XCTAssertEqual(fibonacci(7), 13)
        
        //self.measure {
            XCTAssertEqual(fibonacci(32), 2178309)          // 7sec on my machine !
        //}
    }
    
    func testMemoization() {
        
        let fibonacci = memoize(fibs())
        
        XCTAssertEqual(fibonacci(7), 13)
        
        //self.measure {
        XCTAssertEqual(fibonacci(32), 2178309)
        //}
    }
}
