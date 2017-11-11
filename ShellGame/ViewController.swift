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
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var betPickerView: UIPickerView!
    

    //MARK: Properties
    var shellGame = ShellGame()
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        betPickerView.dataSource = self
        betPickerView.delegate = self
        
        restartWholeGame()
    }

    
    //MARK: Actions
    @IBAction func shellPicked(_ sender: UIButton) {
        shellGame.winningShellIndex = Int(arc4random_uniform(3))
        print(shellGame.winningShellIndex)
        shellGame.numberOfGames += 1
        
        if sender.tag == shellGame.winningShellIndex + 1 {
            sender.setImage(UIImage(named: "shellUpWin"), for: .normal)
            
            shellGame.dollarsInWallet += shellGame.pickedBet
            shellGame.numberOfWins += 1
            
            updateLabels()
            
            gameResultAlert(title: "Victory!", message: "You earned $\(shellGame.pickedBet).")
            
        } else {
            let shellButtonsArray = [firstShellButton, secondShellButton, thirdShellButton]
            shellButtonsArray[shellGame.winningShellIndex]?.setImage(UIImage(named: "shellUpLose"), for: .normal)
            
            shellGame.dollarsInWallet -= shellGame.pickedBet
            
            updateLabels()
            
            gameResultAlert(title: "Loser!", message: "You lost $\(shellGame.pickedBet).")
        }
        
    }
    
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        restartAlert()
    }
    
    
    //MARK: Methods
    func restartWholeGame() {
        restartShellButtonImages()
        shellGame.restartGameData()
        updateLabels()
    }
    
    
    func restartShellButtonImages() {
        firstShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        secondShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        thirdShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        
    }
    
    
    func updateLabels() {
        walletLabel.text = "Wallet: $\(shellGame.dollarsInWallet)"
        scoreLabel.text = "Score: \(shellGame.numberOfWins) / \(shellGame.numberOfGames)"
    }
    
    
    func doubleButtonAlertPresentation(title: String, message: String, firstButtonAlertAction: UIAlertAction, secondButtonAlertAction: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(firstButtonAlertAction)
        alertController.addAction(secondButtonAlertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func gameResultAlert(title: String, message: String) {
        let continueAlertAction = UIAlertAction(title: "Continue", style: .default, handler: { (alertAction) in self.restartShellButtonImages() })
        let restartAlertAction = UIAlertAction(title: "Restart", style: .default, handler: { (alertAction) in self.restartAlert() })
        
        doubleButtonAlertPresentation(title: title,
                                      message: message,
                                      firstButtonAlertAction: continueAlertAction,
                                      secondButtonAlertAction: restartAlertAction)
    }
    
    
    func restartAlert() {
        let restartAlertAction = UIAlertAction(title: "Restart", style: .default, handler: { (alertAction) in self.restartWholeGame() })
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: { (alertAction) in self.restartShellButtonImages() })
        
        doubleButtonAlertPresentation(title: "Alert!",
                                      message: "This action will delete current score",
                                      firstButtonAlertAction: restartAlertAction,
                                      secondButtonAlertAction: cancelAlertAction)
    }
    
}


extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shellGame.betsArray.count
    }
    
}


extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(shellGame.betsArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        shellGame.pickedBet = shellGame.betsArray[row]
    }
    
}
