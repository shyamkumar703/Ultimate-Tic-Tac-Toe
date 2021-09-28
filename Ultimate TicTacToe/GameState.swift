//
//  GameState.swift
//  Ultimate TicTacToe
//
//  Created by Shyam Kumar on 9/23/21.
//

import Foundation

class GameState {
    public static var turn: Player = .x
    
    static func changeTurn() {
        if GameState.turn == .x {
            GameState.turn = .o
        } else {
            GameState.turn = .x
        }
    }
}
