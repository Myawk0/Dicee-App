//
//  Dice.swift
//  Dicee
//
//  Created by Мявкo on 27.10.23.
//

import UIKit

struct Dice {
    var image: UIImage?
    var value: Int
    
    static let dices = [
        Dice(image: UIImage(named: "DiceOne"), value: 1),
        Dice(image: UIImage(named: "DiceTwo"), value: 2),
        Dice(image: UIImage(named: "DiceThree"), value: 3),
        Dice(image: UIImage(named: "DiceFour"), value: 4),
        Dice(image: UIImage(named: "DiceFive"), value: 5),
        Dice(image: UIImage(named: "DiceSix"), value: 6)
    ]
}
