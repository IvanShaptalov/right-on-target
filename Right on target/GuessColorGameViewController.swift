//
//  GuessColorGameViewController.swift
//  Right on target
//
//  Created by van on 13.10.2023.
//

import UIKit

class GuessColorGameViewController: UIViewController {
    
    private var gameObj: Game<String>?

    private let roundCount: Int = 5
    
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
            updateButtonColor(button: button, hexColor: self.gameObj!.randomValueGenerator.getRandomValue())
                
            
        }
        
        let randomButton: UIButton = [colorButton1, colorButton2, colorButton3, colorButton4].randomElement()!
        updateButtonColor(button: randomButton, hexColor: gameObj!.gameRound.currentSecretValue)
        
    }
    
    
    @IBAction func onButtonTap(_ sender: UIButton) {
        if gameObj!.isGameEnded {
            showAlertMessage(message: "Your score is :\(gameObj!.gameRound.score)")
        } else {
            gameObj!.gameRound.calculateScore(with: sender.backgroundColor?.toHex() ?? "")
            gameObj!.startNewRound()
            updateHEXLabel()
            bulkUpdateButtonColor()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameObj = Game<String>(rounds: roundCount)
        gameObj?.startNewRound()
        updateHEXLabel()
        bulkUpdateButtonColor()
        // Do any additional setup after loading the view.
    }
    
    private func updateHEXLabel(){
        targetHEXLabel.text = String(gameObj!.gameRound.currentSecretValue)
        
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
