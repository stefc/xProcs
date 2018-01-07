//
//  StateTests.swift
//  xProcsTests
//
//  Created by Stefan Boether on 06.01.18.
//

import XCTest
import Foundation

import xProcs

precedencegroup BindPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator >>- : BindPrecedence



class StateTests: XCTestCase {

    // https://wiki.haskell.org/State_Monad
    
    func testPlayGame() {
        // Example use of state monad
        // Passes a string of dictionary {a,b,c}
        // Game is to produce a number from the string.
        // By default the game is off, a C toggles the game on and off.
        // A 'a' gives +1 and a b gives -1.
        // E.g:
        // 'ab'    = 0
        // 'ca'    = 1
        // 'cabca' = 0
        // state = game is on or off & current score
        //       = (Bool, Int)
      
        typealias GameValue = Int
        typealias GameState = (on:Bool, score:Int)
        
    
        func increase(_ state: GameState) -> GameState {
            return (state.on, state.score + 1)
        }
        
        func decrease(_ state: GameState) -> GameState {
            return (state.on, state.score - 1)
        }
        
        func toggle(_ state: GameState) -> GameState {
            return (!state.on, state.score)
        }
        
        func identity(_ state: GameState) -> GameState {
            return state
        }
        
        // https://stackoverflow.com/a/39677331/1259996   String vs SubString
        
        func playGame(x:Character, xs:Substring) -> StateMonad<GameState, GameValue> {
            return get()
                >>- { (state:GameState) -> (StateMonad<GameState, GameValue>) in
                    switch(x) {
                        case "a" where state.on: return put(increase(state), 0)
                        case "b" where state.on: return put(decrease(state), 0)
                        case "c": return put(toggle(state), 0)
                        default: return put(identity(state), 0)
                    }
                }
                >>- { GameValue -> StateMonad<GameState, GameValue> in playGame(xs) }
        }
        
        func playGame() -> StateMonad<GameState, GameValue> {
            return get()
                >>- { (state:GameState) -> (StateMonad<GameState, GameValue>) in unit(state.score) }
        }
        
        func playGame(_ s: Substring) -> StateMonad<GameState, GameValue> {
            
            if let x = s.first {
                return playGame(x:x, xs: s.dropFirst())
            }
            else
            {
                return playGame()
            }
        }
        
        let score = evalState((false, 0 ), computation: playGame("abcaaacbbcabbab"))
        
        XCTAssertEqual(score, 2)
    }
}
