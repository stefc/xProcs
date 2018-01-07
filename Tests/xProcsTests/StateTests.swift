//
//  StateTests.swift
//  xProcsTests
//
//  Created by Stefan Boether on 06.01.18.
//

import XCTest
import Foundation

import xProcs

class StateTests: XCTestCase {

    // https://wiki.haskell.org/State_Monad
    
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
    
    func testPlayGame() {
        
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
            return
                // (on, score) <- get
                get()
                // case x of ...
                >>- { (state) -> (StateMonad<GameState, ()>) in
                    switch(x) {
                        case "a" where state.on: return put(increase(state))
                        case "b" where state.on: return put(decrease(state))
                        case "c": return put(toggle(state))
                        default: return put(identity(state))
                    }
                }
                //  playGame xs
                >>- { GameValue -> StateMonad<GameState, GameValue> in playGame(xs) }
        }
        
        func playGame() -> StateMonad<GameState, GameValue> {
            return get()
                >>- { (state) -> (StateMonad<GameState, GameValue>) in unit(state.score) }
        }
        
        // playGame :: String -> State GameState GameValue
        func playGame(_ s: Substring) -> StateMonad<GameState, GameValue> {
            
            return iif(s.first, { x in playGame(x:x, xs:s.dropFirst())}, { playGame()})
            
            //
            // return iif(s, { (x,xs) in playGame(x:x, xs:xs)}, { playGame()})
            //
        }
        
        let score = evalState((false, 0 ), computation: playGame("abcaaacbbcabbab"))
        
        XCTAssertEqual(score, 2)
    }
}
