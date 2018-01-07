//
//  StateMonad.swift
//  xProcs

import Foundation

// typealias support with Swift 4 now generics, really cool !
public typealias StateMonad<S,A> = (S) -> (value:A, state:S)
public typealias MonadMaker<S,A,B> = (A) -> StateMonad<S,B>

// Infix monad bind operator

precedencegroup BindPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator >>- : BindPrecedence

// Bind a MonadMaker to a StateMonad and produce a new StateMonad
// (>>=) :: State s a -> (a -> State s b) -> State s b
public func >>- <S, A, B> (f: @escaping StateMonad<S, A>, g: @escaping MonadMaker<S, A, B>) -> StateMonad<S, B> {
    return {
        (state: S) -> (B, S) in
        // Apply the f monad on the given state
        let (fvalue, fstate) = f(state)
        
        // Build the new monad with the intermediate output
        let gmonad = g(fvalue)
        
        // Apply the new monad on the intermediate state
        //let (gvalue, gstate) and return it
        return gmonad(fstate)
    }
}

// Set the content value but let the state unchanged
// aka 'return' in Haskel
// 
public func unit<S, A>(_ result: A) -> StateMonad<S, A> {
    return {
        (state: S) -> (A, S) in (result, state)
    }
}

// get :: m s
// Return the state from the internals of the monad.
// Set the state as content and leave the state unchanged
public func get<S>() -> StateMonad<S, S> {
    return {
        (state: S) -> (S, S) in (state, state)
    }
}

// Set the content to a dummy value and the state to newstate
// ToDo : How we can avoid Type inference on A  ?
public func put<S, A> (_ newstate: S, _ dummy: A) -> StateMonad<S, A> {
    return {
        (state: S) -> (A, S) in (dummy, newstate)
    }
}

// Take a function that converts a state to a content and return it as new content
public func gets<S, A> (transform: @escaping (S)  -> A) -> StateMonad<S, A> {
    return {
        (state: S) -> (A, S) in
        return (transform(state), state)
    }
}

// modify :: MonadState s m => (s -> s) -> m ()
// Monadic state transformer.
// Maps an old state to a new state inside a state monad. The old state is thrown away.
public func modify<S, A> (f: @escaping (S) -> S, null: A) -> StateMonad<S, A> {
    return {
        (state: S) -> (A, S) in
        _ = f(state)
        return (null, state)
    }
}
// unwrap a state monad computation as a function. (The inverse of state.)
// runState :: State s a -> s -> (a, s)
public func runState<S, A> (_ initialState: S, computation: StateMonad<S, A>) -> (A, S) {
    return computation(initialState)
}

// Evaluate a state computation with the given initial state and return the final value, discarding the final state.
// evalState :: State s a -> s -> a
public func evalState<S, A> (_ initialState: S, computation: StateMonad<S, A>) -> A {
    return computation(initialState).value
}

// Evaluate a state computation with the given initial state and return the final state, discarding the final value.
// execState :: State s a -> s -> s
public func execState<S, A> (_ initialState: S, computation: StateMonad<S, A>) -> S {
    return computation(initialState).state
}


