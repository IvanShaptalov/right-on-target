//
//  ViewController.swift
//  Right on target
//
//  Created by van on 07.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var number : Int = 0
    var round: Int = 0
    var points: Int = 0
    var guessedNum: Int = 0
    
    let roundCount: Int = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addScore(guessedNum: Int){
        if guessedNum == number {
            points += 50
        } else if guessedNum > number{
            
            points += 50 - guessedNum + number
            
        }
        
        else if guessedNum < number {
            points += 50 - number + guessedNum
        }
    }
    
    func restartGame() -> Void{
        points = 0
        round = 0
        
    }
    
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var sliderScore: UISlider!
    
    @IBAction func onSliderScoreValueChanged(_ sender: UISlider) {
        guessedNum = Int(sender.value)
        
    }
    
    @IBAction func onButtonTap(_ sender: UIButton) {
        if (round == 0){
            sender.titleLabel?.text = "Start Game"
        } else {
            sender.titleLabel?.text = "Check"
        }
        if (roundCount < round){
            let alertController = UIAlertController(title: "Finish", message: "Your score is :\(points)", preferredStyle:.alert )
            
            
            let actionOk = UIAlertAction(title: "OK, restart game", style: .default, handler:  {(alert: UIAlertAction!) in self.restartGame()
            })
            
          
            alertController.addAction(actionOk)
            self.present(alertController,animated:true, completion: nil)        }
        else {
            round += 1
            addScore(guessedNum: guessedNum)
            number = Int.random(in: 1...50)
            labelScore.text = String(number)
        }
        
    }
}

