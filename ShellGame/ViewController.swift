//
//  ViewController.swift
//  ShellGame
//
//  Created by Виктория Бадисова on 31.10.2017.
//  Copyright © 2017 Виктория Бадисова. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var firstShellButton: UIButton!
    @IBOutlet weak var secondShellButton: UIButton!
    @IBOutlet weak var thirdShellButton: UIButton!
    
    
    //MARK: Properties
    var winningShellIndex = 0
    var numberOfWins = 0
    var numberOfGames = 0
    
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        restartWholeGame()
    }

    
    //MARK: Actions
    @IBAction func shellPicked(_ sender: UIButton) {
        winningShellIndex = Int(arc4random_uniform(3))
        print(winningShellIndex)
        numberOfGames += 1
        
        if sender.tag == winningShellIndex + 1 {
            sender.setImage(UIImage(named: "shellUpWin"), for: .normal)
            numberOfWins += 1
            scoreLabel.text = "\(numberOfWins) / \(numberOfGames)"
            gameResultsAlertPresentation(title: "Victory!", message: "You've bit this device!")
            
        } else {
            let shellButtonsArray = [firstShellButton, secondShellButton, thirdShellButton]
            shellButtonsArray[winningShellIndex]?.setImage(UIImage(named: "shellUpLose"), for: .normal)
            scoreLabel.text = "\(numberOfWins) / \(numberOfGames)"
            gameResultsAlertPresentation(title: "Loser!", message: "Please, try again")
        }
        
    }
    
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        restartAlertPresentation()
    }
    
    
    //MARK: Methods
    func restartWholeGame() {
        restartOneGame()
        numberOfWins = 0
        numberOfGames = 0
        scoreLabel.text = "\(numberOfWins) / \(numberOfGames)"
    }
    
    
    func restartOneGame() {
        firstShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        secondShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        thirdShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        
    }
    
    
    func doubleButtonAlertPresentation(title: String, message: String, firstAlertAction: UIAlertAction, secondAlertAction: UIAlertAction) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(firstAlertAction)
        alertController.addAction(secondAlertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func gameResultsAlertPresentation(title: String, message: String) {
        let continueAlertAction = UIAlertAction(title: "Continue", style: .default, handler: { (alertAction) in
            self.restartOneGame()
        })
        let restartAlertAction = UIAlertAction(title: "Restart", style: .default, handler: { (alertAction) in
            self.restartAlertPresentation()
        })
        
        doubleButtonAlertPresentation(title: title, message: message, firstAlertAction: continueAlertAction, secondAlertAction: restartAlertAction)
    }
    
    
    func restartAlertPresentation() {
        let restartAlertAction = UIAlertAction(title: "Restart", style: .default, handler: { (alertAction) in
            self.restartWholeGame()
        })
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: { (alertAction) in
            self.restartOneGame()
        })
        
        doubleButtonAlertPresentation(title: "Alert!", message: "This action will delete current score", firstAlertAction: restartAlertAction, secondAlertAction: cancelAlertAction)
    }
    
}

