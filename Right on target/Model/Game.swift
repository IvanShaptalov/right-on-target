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
    
    var gameRound: GameRound {get}

    func restartGame()
    
    func startNewRound()
}

protocol GameRoundProtocol{
    
    var score: Int {get}
    
    var currentSecretValue: Int {get}
    
    func calculateScore(with value: Int)
    
}

protocol RandomValueGeneratorProtocol {
    func getRandomValue() -> Int
}


class Game : GameProtocol {
       
    private var lastRound: Int
    private var currentRound: Int = 0
    
    var randomValueGenerator: RandomValueGenerator
    var gameRound: GameRound
    
    
    
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
    
    
    init(startValue: Int, endValue: Int, rounds: Int){
        lastRound = rounds
        self.randomValueGenerator = RandomValueGenerator(min: startValue, max: endValue)!
        self.gameRound = GameRound(score: 0, currentSecretValue: randomValueGenerator.getRandomValue())
    }
}


struct RandomValueGenerator : RandomValueGeneratorProtocol{
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

class GameRound : GameRoundProtocol{
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


