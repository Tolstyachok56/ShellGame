//
//  Model.swift
//  ShellGame
//
//  Created by Виктория Бадисова on 11.11.2017.
//  Copyright © 2017 Виктория Бадисова. All rights reserved.
//

import Foundation

class ShellGame {
    
    var winningShellIndex = 0
    var numberOfWins = 0
    var numberOfGames = 0
    var dollarsInWallet = 100
    var pickedBet = 1
    let betsArray = [1, 2, 5, 10, 25, 50, 100]
    
    func restartGameData() {
        numberOfWins = 0
        numberOfGames = 0
        dollarsInWallet = 100
    }
    
}
