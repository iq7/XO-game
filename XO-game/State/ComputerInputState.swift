//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Андрей Тихонов on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class ComputerInputState: GameState {
    
    public private(set) var isCompleted = false
    
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    public let markViewPrototype: MarkView
    
    init(markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    public func begin() {
        guard let gameViewController = gameViewController else { return }
        switch gameViewController.currentPlayer {
        case .first:
            gameViewController.firstPlayerTurnLabel.isHidden = false
            gameViewController.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController.firstPlayerTurnLabel.isHidden = true
            gameViewController.secondPlayerTurnLabel.isHidden = false
        }
        gameViewController.winnerLabel.isHidden = true
        print("SecondPlayerState")
        makeMove()
    }
    
    private func makeMove() {
        repeat {
            let position = GameboardPosition(column: Int.random(in: 0..<GameboardSize.columns), row: Int.random(in: 0..<GameboardSize.rows))
            if gameboard?.isEmptyPosition(at: position) == true {
                self.addMark(at: position)
                break
            }
        } while true
    }

    public func addMark(at position: GameboardPosition) {
        guard let gameViewController = gameViewController else { return }
        Log(.playerInput(player: gameViewController.currentPlayer, position: position))
        
        self.gameboard?.setPlayer(gameViewController.currentPlayer, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
        gameViewController.goToNextState()
    }
}