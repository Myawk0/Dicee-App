//
//  DiceController.swift
//  Dicee
//
//  Created by Мявкo on 27.10.23.
//

import UIKit

class DiceController: UIViewController {
    
    // MARK: - Properties
    
    private let diceView: DiceView
    private let dices = Dice.dices
    
    private var score = 0
    
    // MARK: - Init
    
    init() {
        self.diceView = DiceView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appoint diceView as view
    
    override func loadView() {
        super.loadView()
        self.view = diceView
        diceView.delegate = self
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "LightToDark")

        setupScore(0)
        setupDiceNames()
    }
    
    // MARK: - Catch shaking of phone

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            diceView.setupDicesValues()
        }
    }
    
    // MARK: - Create an array of dices images in view
    
    func setupDiceNames() {
        for dice in dices {
            diceView.setupDices(with: dice.image!)
        }
    }
    
    // MARK: - Change size of score value and setup it in view
    
    func setupScore(_ score: Int) {
        let scoreString = "Score:  \(score)"
        let attributedScore = NSMutableAttributedString(string: scoreString)

        if let range = scoreString.range(of: "\(score)") {
            attributedScore.addAttributes([.font: UIFont.systemFont(ofSize: 30, weight: .semibold)], range: NSRange(range, in: scoreString))
        }
        diceView.setupScore(with: attributedScore)
    }
    
    // MARK: - Sum of dices values
    
    func calculateDiceScore(firstDice: Int, secondDice: Int) -> Int  {
        return firstDice + secondDice
    }
}

// MARK: - DiceViewDelegate

extension DiceController: DiceViewDelegate {
    
    func rollButtonIsTapped(firstValue: Int, secondValue: Int) {
        let score = calculateDiceScore(firstDice: firstValue, secondDice: secondValue)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setupScore(score)
        }
    }
    
    func getDiceValue(from randomElement: UIImage?) -> Int? {
        return dices.first { $0.image == randomElement }?.value
    }
}
