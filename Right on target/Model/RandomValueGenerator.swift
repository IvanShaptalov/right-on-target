//
//  RandomValueGenerator.swift
//  Right on target
//
//  Created by van on 15.10.2023.
//

import Foundation

protocol RandomValueGeneratorProtocol {
    associatedtype T
    
    func getRandomValue() -> T
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
