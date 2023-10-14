//
//  Game.swift
//  Right on target
//
//  Created by van on 11.10.2023.
//

import Foundation

protocol GameProtocol {
    associatedtype T

    var isGameEnded: Bool{get}
    
    var randomValueGenerator: RandomValueGenerator<T> {get}
        
    var gameRound: GameRound<T> {get}

    func restartGame() -> Void
    
    func startNewRound() -> Void
}



protocol GameRoundProtocol{
    associatedtype T

    var score: Int {get}
        
    var currentSecretValue: T {get}
    
    func calculateScore(with value: T)
    
}


protocol RandomValueGeneratorProtocol {
    associatedtype T
    
    func getRandomValue() -> T
}

class Game<T> : GameProtocol {
    
    
       
    private var lastRound: Int
    private var currentRound: Int = 0
    
    var randomValueGenerator: RandomValueGenerator<T>
    var gameRound: GameRound<T>
    
    
    var isGameEnded: Bool {
        if currentRound > lastRound {
            return true
        } else {
            return false
        }
    }
    
    func restartGame() {
        currentRound = 0
        self.gameRound.score = 0
        startNewRound()
        
    }
    
    func startNewRound() {
        
        self.gameRound.currentSecretValue = self.randomValueGenerator.getRandomValue()
        currentRound += 1
    }
    
    
    init(startValue: Int? = 0, endValue: Int? = 50, rounds: Int){
        lastRound = rounds
        
       
           
        self.randomValueGenerator = RandomValueGenerator<T>(min: startValue!, max: endValue!)!
            
        
       
        
        self.gameRound = GameRound<T>(score: 0, currentSecretValue: randomValueGenerator.getRandomValue())
        
    }
}


struct RandomValueGenerator<T> : RandomValueGeneratorProtocol{

    private func getRandomHEX() -> String {
        var resultColorHEX : String = ""
  
        let stringElement: String = String.init(describing: ("a"..."z"))
        let numElement = 0...9
        
        
        repeat {
            if Bool.random(){
                resultColorHEX.append(stringElement.randomElement()!)
            } else {
                resultColorHEX.append(String(numElement.randomElement()!))
            }
            
            while resultColorHEX.contains(".") {
                resultColorHEX.remove(at: resultColorHEX.firstIndex(of: ".")!)
            }
            
        } while resultColorHEX.count != 6
        
        assert(resultColorHEX.count == 6)
        
        print(resultColorHEX)
        
        return resultColorHEX
        
    }
        
    func getRandomValue() -> T {
        
        if T.self is String.Type {
            return getRandomHEX() as! T
        } else {
            return (minValue...maxValue).randomElement()! as! T
        }
        
    }
    
    
    
    private let minValue: Int
    private let maxValue: Int
    
    
    init?(min: Int, max: Int){
        
        guard min < max else {
            return nil
        }
                
        self.minValue = min
        self.maxValue = max
    }
}


class GameRound<T> : GameRoundProtocol{
    
    var score: Int
    
    var currentSecretValue: T
    
    init(score: Int = 0, currentSecretValue: T){
        self.score = score
        self.currentSecretValue = currentSecretValue
    }
    
    func calculateScore<T>(with value: T) {
        if T.self is String.Type {
            // Guess color game
            if ((value as! String).lowercased() == (currentSecretValue as! String).lowercased()){
                score += 50
            }
        } else if T.self is Int.Type {
            // Guess number game
                if (value as! Int == currentSecretValue as! Int) {
                    score += 50
                }
                else if (value as! Int > currentSecretValue as! Int){
                    score += 50 - (value as! Int) + (currentSecretValue as! Int)
                } else {
                    score += 50 - (currentSecretValue as! Int) + (value as! Int)
                }
        
       
    }
}
}
