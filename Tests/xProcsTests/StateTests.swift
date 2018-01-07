//
//  StateTests.swift
//  xProcsTests
//
//  Created by Stefan Boether on 06.01.18.
//

import XCTest
import Foundation

import xProcs

extension Substring : HeadTailSeparation {
    public func rest() -> SubSequence {
        return self.dropFirst()
    }
}

extension String : HeadTailSeparation {
    public func rest() -> SubSequence {
        return self.dropFirst()
    }
}

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
        typealias GameStateMonad = StateMonad<GameState, GameValue>
    
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
        
        func playGame() -> GameStateMonad {
            return get() >>- { (state) -> GameStateMonad in unit(state.score) }
        }
        
        func playGame(_ x:Character, _ xs:Substring) -> GameStateMonad {
            // (on, score) <- get >>= case x of ... >>= playGame xs
            return
                get()
                >>- { (state) -> StateMonad<GameState, ()> in
                    switch(x) {
                        case "a" where state.on: return put(increase(state))
                        case "b" where state.on: return put(decrease(state))
                        case "c": return put(toggle(state))
                        default: return put(identity(state))
                    }
                }
                >>- { GameValue -> GameStateMonad in playGame(xs) }
        }
        
        
        // playGame :: String -> State GameState GameValue
        func playGame(_ s: Substring) -> GameStateMonad {
            return iif(s, { (x,xs) in playGame(x, xs)}, { playGame()})
        }
        
        let score = evalState((false, 0 ), computation: playGame("abcaaacbbcabbab"))
        XCTAssertEqual(score, 2)
    }
}
