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
    var winningShellIndex = 0
    var numberOfWins = 0
    var numberOfGames = 0
    var dollarsInWallet = 100
    var pickedBet = 1
    let betsArray = [1, 2, 5, 10, 25, 50, 100]
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        betPickerView.dataSource = self
        betPickerView.delegate = self
        
        restartWholeGame()
    }

    
    //MARK: Actions
    @IBAction func shellPicked(_ sender: UIButton) {
        winningShellIndex = Int(arc4random_uniform(3))
        print(winningShellIndex)
        numberOfGames += 1
        
        if sender.tag == winningShellIndex + 1 {
            sender.setImage(UIImage(named: "shellUpWin"), for: .normal)
            
            dollarsInWallet += pickedBet
            numberOfWins += 1
            
            walletLabel.text = "Wallet: $\(dollarsInWallet)"
            scoreLabel.text = "Score: \(numberOfWins) / \(numberOfGames)"
            
            gameResultsAlert(title: "Victory!", message: "You earned $\(pickedBet).")
            
        } else {
            let shellButtonsArray = [firstShellButton, secondShellButton, thirdShellButton]
            shellButtonsArray[winningShellIndex]?.setImage(UIImage(named: "shellUpLose"), for: .normal)
            
            dollarsInWallet -= pickedBet
            
            walletLabel.text = "Wallet: $\(dollarsInWallet)"
            scoreLabel.text = "Score: \(numberOfWins) / \(numberOfGames)"
            
            gameResultsAlert(title: "Loser!", message: "You lost $\(pickedBet).")
        }
        
    }
    
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        restartAlert()
    }
    
    
    //MARK: Methods
    func restartWholeGame() {
        restartOneGame()
        numberOfWins = 0
        numberOfGames = 0
        dollarsInWallet = 100
        
        walletLabel.text = "Wallet: $\(dollarsInWallet)"
        scoreLabel.text = "Score: \(numberOfWins) / \(numberOfGames)"
    }
    
    
    func restartOneGame() {
        firstShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        secondShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        thirdShellButton.setImage(UIImage(named: "shellDown"), for: .normal)
        
    }
    
    
    func doubleButtonAlertPresentation(title: String, message: String, firstButtonAlertAction: UIAlertAction, secondButtonAlertAction: UIAlertAction) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(firstButtonAlertAction)
        alertController.addAction(secondButtonAlertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func gameResultsAlert(title: String, message: String) {
        let continueAlertAction = UIAlertAction(title: "Continue", style: .default, handler: { (alertAction) in
            self.restartOneGame()
        })
        let restartAlertAction = UIAlertAction(title: "Restart", style: .default, handler: { (alertAction) in
            self.restartAlert()
        })
        
        doubleButtonAlertPresentation(title: title,
                                      message: message,
                                      firstButtonAlertAction: continueAlertAction,
                                      secondButtonAlertAction: restartAlertAction)
    }
    
    
    func restartAlert() {
        let restartAlertAction = UIAlertAction(title: "Restart", style: .default, handler: { (alertAction) in
            self.restartWholeGame()
        })
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: { (alertAction) in
            self.restartOneGame()
        })
        
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
        return betsArray.count
    }
    
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(betsArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedBet = betsArray[row]
    }
    
}
