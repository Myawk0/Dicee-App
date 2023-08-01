//
//  ViewController.swift
//  Dicee
//
//  Created by Мявкo on 1.08.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var logoView: UIView = _logoView
    private lazy var dicesView: UIView = _dicesView
    private lazy var buttonView: UIView = _buttonView
    
    private lazy var viewsStackView: UIStackView = _viewsStackView
    private lazy var dicesStackView: UIStackView = _dicesStackView
    
    private lazy var backgroundImageView: UIImageView = _backgroundImageView
    private lazy var logoImageView: UIImageView = _logoImageView
    private lazy var firstDiceImageView: UIImageView = _firstDiceImageView
    private lazy var secondDiceImageView: UIImageView = _secondDiceImageView
    
    private lazy var rollButton: UIButton = _rollButton
    
    let dices = [UIImage(named: "DiceOne")!,
                 UIImage(named: "DiceTwo")!,
                 UIImage(named: "DiceThree")!,
                 UIImage(named: "DiceFour")!,
                 UIImage(named: "DiceFive")!,
                 UIImage(named: "DiceSix")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        layout()
    }
    
    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(viewsStackView)
        
        logoView.addSubview(logoImageView)
        viewsStackView.addArrangedSubview(logoView)
        
        dicesStackView.addArrangedSubview(firstDiceImageView)
        dicesStackView.addArrangedSubview(secondDiceImageView)
        dicesView.addSubview(dicesStackView)
        viewsStackView.addArrangedSubview(dicesView)
        
        buttonView.addSubview(rollButton)
        viewsStackView.addArrangedSubview(buttonView)
    }
    
    func layout() {
        backgroundImageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        viewsStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
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
        
        rollButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.width.greaterThanOrEqualTo(120)
        }
    }
    
    func animateDiceRoll(diceImageView: UIImageView) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            diceImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }) { _ in
            diceImageView.image = self.dices.randomElement()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                diceImageView.transform = .identity
            }, completion: nil)
        }
    }
    
    @objc func rollButtonTapped(_ sender: UIButton) {
        animateDiceRoll(diceImageView: firstDiceImageView)
        animateDiceRoll(diceImageView: secondDiceImageView)
    }
}

extension ViewController {
    
    var _backgroundImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GreenBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
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
        imageView.image = UIImage(named: "DiceeLogo")
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
        imageView.image = UIImage(named: "DiceOne")
        return imageView
    }
    
    var _secondDiceImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DiceOne")
        return imageView
    }
    
    var _buttonView: UIView {
        let view = UIView()
        return view
    }
    
    var _rollButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Roll", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DarkRedColor")
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(rollButtonTapped), for: .touchUpInside)
        return button
    }
}
