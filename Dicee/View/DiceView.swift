//
//  ViewController.swift
//  Dicee
//
//  Created by Мявкo on 1.08.23.
//

import UIKit
import SnapKit

protocol DiceViewDelegate: AnyObject {
    func getDiceValue(from randomElement: UIImage?) -> Int?
    func rollButtonIsTapped(firstValue: Int, secondValue: Int)
}

class DiceView: UIView {
    
    weak var delegate: DiceViewDelegate?
    
    // MARK: - Views
    
    private lazy var logoView: UIView = _logoView
    private lazy var dicesView: UIView = _dicesView
    private lazy var buttonView: UIView = _buttonView
    
    private lazy var viewsStackView: UIStackView = _viewsStackView
    private lazy var dicesStackView: UIStackView = _dicesStackView
    
    private lazy var logoImageView: UIImageView = _logoImageView
    private lazy var firstDiceImageView: UIImageView = _firstDiceImageView
    private lazy var secondDiceImageView: UIImageView = _secondDiceImageView
    
    private lazy var scoreLabel: UILabel = _scoreLabel
    private lazy var rollButton: UIButton = _rollButton
    
    // MARK: - Property
    
    private var dices = [UIImage]()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "LightToDark")
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup array of dices images

    func setupDices(with image: UIImage) {
        dices.append(image)
    }
    
    // MARK: - Setup a Score in the label
    
    func setupScore(with score: NSMutableAttributedString) {
        scoreLabel.attributedText = score
    }
    
    // MARK: - Animate Dices roll and set random value
    
    private func animateDiceRoll(_ diceImageView: UIImageView) -> Int? {
        diceImageView.animationImages = dices.shuffled()
        diceImageView.animationDuration = 1
        diceImageView.animationRepeatCount = 1
        diceImageView.startAnimating()
    
        guard let randomElement = dices.randomElement(),
                let value = delegate?.getDiceValue(from: randomElement) else { return nil }
        
        diceImageView.image = randomElement
        return value
    }
    
    // MARK: - Method tapping on Roll button
    
    @objc private func rollButtonTapped(_ sender: UIButton) {
        if let firstValue = animateDiceRoll(firstDiceImageView), let secondValue = animateDiceRoll(secondDiceImageView) {
            delegate?.rollButtonIsTapped(firstValue: firstValue, secondValue: secondValue)
        }
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        addSubview(viewsStackView)
        
        logoView.addSubview(logoImageView)
        viewsStackView.addArrangedSubview(logoView)
        
        dicesStackView.addArrangedSubview(firstDiceImageView)
        dicesStackView.addArrangedSubview(secondDiceImageView)
        dicesView.addSubview(dicesStackView)
        viewsStackView.addArrangedSubview(dicesView)
        
        buttonView.addSubview(scoreLabel)
        buttonView.addSubview(rollButton)
        viewsStackView.addArrangedSubview(buttonView)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        viewsStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(180)
        }
        
        firstDiceImageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
        }
        
        secondDiceImageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
        }
        
        dicesStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
        rollButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.greaterThanOrEqualTo(200)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

// MARK: - Setup Elements

private extension DiceView {
    
    var _viewsStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }
    
    var _logoView: UIView {
        let view = UIView()
        return view
    }
    
    var _logoImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DiceeLogo")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "DarkToLight")
        return imageView
    }
    
    var _dicesView: UIView {
        let view = UIView()
        return view
    }
    
    var _dicesStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.distribution = .fillEqually
        return stackView
    }
    
    var _firstDiceImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DiceOne")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "DarkToLight")
        return imageView
    }
    
    var _secondDiceImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DiceOne")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "DarkToLight")
        return imageView
    }
    
    var _buttonView: UIView {
        let view = UIView()
        return view
    }
    
    var _scoreLabel: UILabel {
        let label = UILabel()
        label.textColor = UIColor(named: "DarkToLight")
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        return label
    }
    
    var _rollButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Roll", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        button.tintColor = UIColor(named: "LightToDark")
        button.backgroundColor = UIColor(named: "DarkToLight")
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(rollButtonTapped), for: .touchUpInside)
        return button
    }
}
