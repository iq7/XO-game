//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!

    var gameMode: GameMode?

    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    private lazy var referee = Referee(gameboard: self.gameboard)
    var currentPlayer: Player = .first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    private func goToFirstState() {
        self.currentPlayer = .first
        self.currentState = PlayerInputState(gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
    }
    
    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        } else if !gameboard.containsEmptyPosition() {
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        }
        currentPlayer = currentPlayer.next
        switch currentPlayer {
        case .first:
            switchToPlayerInputState()
        case .second:
            guard let gameMode = gameMode else { return }
            switch gameMode {
            case .withHuman:
                switchToPlayerInputState()
            case .withComputer:
                switchToComputerInputState()
            }
        }
    }
    
    private func switchToPlayerInputState() {
        self.currentState = PlayerInputState(gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
    }
    
    private func switchToComputerInputState() {
        self.currentState = ComputerInputState(gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
    }

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        gameboard.clear()
        gameboardView.clear()
    }
}

