//
//  ViewController.swift
//  Right on target
//
//  Created by van on 07.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var gameObj: Game<Int>?
    
    private let minRandomValue: Int = 0
    private let maxRandomValue: Int = 50
    private let roundCount: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        gameObj = Game(startValue: minRandomValue, endValue: maxRandomValue, rounds: roundCount)
        gameObj?.startNewRound()
        updateRandomLabel()
    }
    
    lazy var secondViewController: SecondViewController = getSecondViewController()
    
    private func getSecondViewController() -> SecondViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondViewController")
        return viewController as! SecondViewController
    }
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }


    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    @IBAction func showAboutScreen(){
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var labelRandomValue: UILabel!
    
    @IBOutlet weak var sliderScore: UISlider!
       
    @IBAction func checkNumber(_ sender: UIButton) {
        gameObj!.gameRound.calculateScore(with: Int(sliderScore.value))
        if gameObj!.isGameEnded {
            showAlertMessage(message: "Your score is :\(gameObj!.gameRound.score)")
                    } else {
            gameObj!.startNewRound()
            updateRandomLabel()
        
        }
       
        
    }
    
    private func updateRandomLabel(){
        labelRandomValue.text = String(gameObj!.gameRound.currentSecretValue)    }
    
    private func showAlertMessage(message: String){
        let alertController = UIAlertController(title: "Finish", message: message, preferredStyle:.alert )
        
        
        let actionOk = UIAlertAction(title: "OK, restart game", style: .default, handler:  { [self](alert: UIAlertAction!) in gameObj!.restartGame()
        })
        
      
        alertController.addAction(actionOk)
        self.present(alertController,animated:true, completion: nil)
    }
    
}

