//
//  GuessColorGameViewController.swift
//  Right on target
//
//  Created by van on 13.10.2023.
//

import UIKit

class GuessColorGameViewController: UIViewController {
    
    private var gameObj: Game?

    private let roundCount: Int = 3
    
    @IBOutlet weak var colorButton1: UIButton!
    
    @IBOutlet weak var colorButton2: UIButton!
    
    @IBOutlet weak var colorButton3: UIButton!
    
    @IBOutlet weak var colorButton4: UIButton!
    
    @IBOutlet weak var targetHEXLabel: UILabel!
    
    
    private func updateButtonColor( button: UIButton, hexColor: String){
        button.backgroundColor = UIColor(hex: hexColor)
    }
    
    private func bulkUpdateButtonColor(){
        
        [colorButton1, colorButton2, colorButton3, colorButton4].forEach { (button: UIButton) in
            updateButtonColor(button: button, hexColor: self.gameObj?.randomValueGenerator.getRandomHEX() ?? "#ffffffff")
                
            
        }
        
        let randomButton: UIButton = [colorButton1, colorButton2, colorButton3, colorButton4].randomElement()!
        updateButtonColor(button: randomButton, hexColor: gameObj!.gameGCRound.currentSecretValue)
        
    }
    
    
    @IBAction func onButtonTap(_ sender: UIButton) {
        if gameObj!.isGameEnded {
            showAlertMessage(message: "Your score is :\(gameObj!.gameGCRound.score)")
        } else {
            gameObj!.gameGCRound.calculateScore(with: targetHEXLabel.text!)
            gameObj!.startNewRound()
            updateHEXLabel()
            bulkUpdateButtonColor()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameObj = Game(startValue: 0, endValue: 50, rounds: roundCount)
        gameObj?.startNewRound()
        updateHEXLabel()
        bulkUpdateButtonColor()
        // Do any additional setup after loading the view.
    }
    
    private func updateHEXLabel(){
        targetHEXLabel.text = String(gameObj!.gameGCRound.currentSecretValue)
        
    }
    
    private func showAlertMessage(message: String){
        let alertController = UIAlertController(title: "Finish", message: message, preferredStyle:.alert )
        
        
        let actionOk = UIAlertAction(title: "OK, restart game", style: .default, handler:  { [self](alert: UIAlertAction!) in gameObj!.restartGame()
        })
        
      
        alertController.addAction(actionOk)
        self.present(alertController,animated:true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
