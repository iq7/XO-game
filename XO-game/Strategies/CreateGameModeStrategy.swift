//
//  CreateGameModeStrategy.swift
//  XO-game
//
//  Created by Андрей Тихонов on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum GameMode {
    case withHuman
    case withComputer
}

protocol CreateGameModeStrategy: AnyObject {
    func createGameMode(gameViewController: GameViewController,
                        gameboard: Gameboard,
                        gameboardView: GameboardView) -> GameState
}

final class ComputerGameModeStrategy: CreateGameModeStrategy {
    func createGameMode(gameViewController: GameViewController,
                        gameboard: Gameboard,
                        gameboardView: GameboardView) -> GameState {
        let state = ComputerInputState(gameViewController: gameViewController,
                                       gameboard: gameboard,
                                       gameboardView: gameboardView)
        return state
    }
}

final class HumanGameModeStrategy: CreateGameModeStrategy {
    func createGameMode(gameViewController: GameViewController,
                        gameboard: Gameboard,
                        gameboardView: GameboardView) -> GameState {
        let state = PlayerInputState(gameViewController: gameViewController,
                                     gameboard: gameboard,
                                     gameboardView: gameboardView)
        return state
    }
}
