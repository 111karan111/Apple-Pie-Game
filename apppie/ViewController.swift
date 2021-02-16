//
//  ViewController.swift
//  apppie
//
//  Created by Karan Gandhi on 2/15/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButton: [UIButton]!
 
    
    var currentGame  : Game!
    
    var listOfWords = ["pizza", "cheese", "tomato"]
    var incorrectMovesAllowed = 7
    
    var totalWins = 0{
        
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    
    
    

    override func viewDidLoad() {
        
        newRound()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func  newRound() {
        
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
            enableLabelButtons(true)
            updateUI()
            
        }
        
        else{
            
            enableLabelButtons(false)
        }
        
        
    }
    
    
    func enableLabelButtons(_ enable : Bool){
        for button in letterButton{
            button.isEnabled = enable
        }
        
    }
    func updateUI(){
        
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins : \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)
        let letter = Character((letterString?.lowercased())!)
    
        currentGame.playerGuessed(letter: letter)
        updateGameState()
        
    }
    
    
    func updateGameState () {
        if incorrectMovesAllowed == 0{
            totalLosses += 1
            
        }
        
        else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
            
            
        }
        
        else {
            updateUI()
        }
    }
    
    

}

