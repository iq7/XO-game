//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Андрей Тихонов on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? GameViewController else { return }
        if segue.identifier == "startHumanGameSegue" {
            destinationVC.gameMode = GameMode.withHuman

        } else if segue.identifier == "startComputerGameSegue" {
            destinationVC.gameMode = GameMode.withComputer
        }
    }

}
