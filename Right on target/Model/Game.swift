//
//  Game.swift
//  Right on target
//
//  Created by van on 11.10.2023.
//

import Foundation

protocol GameProtocol {

    var isGameEnded: Bool{get}
    
    var randomValueGenerator: RandomValueGenerator {get}
    
    var gameROTRound: ROTGameRound {get}
    
    var gameGCRound: GCGameRound {get}

    func restartGame() -> Void
    
    func startNewRound() -> Void
}



protocol GameRoundProtocol{
    var score: Int {get}
}

protocol ROTGameRoundProtocol: GameRoundProtocol{
    
    var currentSecretValue: Int {get}
    
    func calculateScore(with value: Int)
    
}

protocol GCGameRoundProtocol: GameRoundProtocol{
    var currentSecretValue: String {get}
    
    func calculateScore(with value: String)
}

protocol RandomValueGeneratorProtocol {
    func getRandomValue() -> Int
    func getRandomHEX() -> String
}

class Game : GameProtocol {
    
    
       
    private var lastRound: Int
    private var currentRound: Int = 0
    
    var randomValueGenerator: RandomValueGenerator
    var gameROTRound: ROTGameRound
    var gameGCRound: GCGameRound
    
    
    var isGameEnded: Bool {
        if currentRound > lastRound {
            return true
        } else {
            return false
        }
    }
    
    func restartGame() {
        currentRound = 0
        self.gameROTRound.score = 0
        
        self.gameGCRound.score = 0
        
        startNewRound()
        
    }
    
    func startNewRound() {
        self.gameROTRound.currentSecretValue = self.randomValueGenerator.getRandomValue()
        
        self.gameGCRound.currentSecretValue = self.randomValueGenerator.getRandomHEX()
        currentRound += 1
    }
    
    
    init(startValue: Int, endValue: Int, rounds: Int){
        lastRound = rounds
        
        self.randomValueGenerator = RandomValueGenerator(min: startValue, max: endValue)!
        
        self.gameGCRound = GCGameRound(score: 0, currentSecretValue: randomValueGenerator.getRandomHEX())
        
        self.gameROTRound = ROTGameRound(score: 0, currentSecretValue: randomValueGenerator.getRandomValue())
    }
}


struct RandomValueGenerator : RandomValueGeneratorProtocol{
    func getRandomHEX() -> String {
        var resultColorHEX : String = "#"
  
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
            
        } while resultColorHEX.count != 9
        
        assert(resultColorHEX.count == 9)
        
        print(resultColorHEX)
        
        return resultColorHEX
        
    }
        
    func getRandomValue() -> Int {
        return (minValue...maxValue).randomElement()!
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


class ROTGameRound : ROTGameRoundProtocol{
    
    var score: Int
    
    var currentSecretValue: Int
    
    init(score : Int = 0, currentSecretValue: Int){
        self.score = score
        self.currentSecretValue = currentSecretValue
    }
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue{
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
        
    }
    
    
}

class GCGameRound : GCGameRoundProtocol{
    var currentSecretValue: String
    
    init(score: Int = 0, currentSecretValue: String){
        self.score = score
        self.currentSecretValue = currentSecretValue
    }
    
    func calculateScore(with value: String) {
        if (value == currentSecretValue){
            score += 50
        }
    }
    
    var score: Int
    
    
}




