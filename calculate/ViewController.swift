//
//  ViewController.swift
//  calculate
//
//  Created by Akerke on 16.07.2023.
//

import UIKit
import SnapKit
import Foundation

enum Operations: Int {
    case pluse = 99
    case minus = 100
    case divede = 101
    case multiply = 102
}

class ViewController: UIViewController {
    
    var currentNumber: String = "" {
        didSet { resultLabel.text = String(Int(currentNumber) ?? 0) }
    }
    var firstOperand: Double = 0
    var operatorSelected: String = ""
    var isTypingNumber: Bool = false
    var tempNumber: String = ""
    var currentOperation: Operations? = nil
    var tempOperation: Operations? = nil
    
    let resultView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        return view
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 90)
        return label
    }()
    
    let zeroButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("0", for: .normal)
        button.tag = 0
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("1", for: .normal)
        button.titleLabel?.textColor = .red
        button.tag = 1
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("2", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.tag = 2
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    
    let thirdButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("3", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.tag = 3
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    
    let fourthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("4", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.tag = 4
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let fifthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("5", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.tag = 5
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let sixthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("6", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.tag = 6
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        //        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.layer.cornerRadius = 40
        return button
    }()
    
    let seventhButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("7", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.tag = 7
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let eighthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("8", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.tag = 8
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let ninthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemIndigo
        button.setTitle("9", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(digitButtonPressed), for: .touchUpInside)
        button.tag = 9
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let ceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("CE", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let equalsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("=", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(36)
        button.addTarget(self, action: #selector(equalsButtonPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    let pluseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("+", for: .normal)
        button.clipsToBounds = true
        button.tag = Operations.pluse.rawValue
        button.titleLabel?.font = button.titleLabel?.font.withSize(24)
        button.addTarget(self, action: #selector(operationPressed), for: .touchUpInside)
        button.layer.cornerRadius = 40
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(48)
        button.addTarget(self, action: #selector(operationPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.tag = Operations.minus.rawValue
        button.layer.cornerRadius = 40
        return button
    }()
    
    let divideButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("/", for: .normal)
        button.clipsToBounds = true
        button.tag = Operations.divede.rawValue
        button.titleLabel?.font = button.titleLabel?.font.withSize(36)
        button.addTarget(self, action: #selector(operationPressed), for: .touchUpInside)
        button.layer.cornerRadius = 40
        return button
    }()
    
    let multiplyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("*", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(48)
        button.tag = Operations.multiply.rawValue
        button.addTarget(self, action: #selector(operationPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        makeConstraints()
        view.backgroundColor = .systemBackground
        
    }
}

private extension ViewController {
    func setupScene() {
        view.addSubview(resultView)
        resultView.addSubview(resultLabel)
        view.addSubview(zeroButton)
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        view.addSubview(fourthButton)
        view.addSubview(fifthButton)
        view.addSubview(sixthButton)
        view.addSubview(seventhButton)
        view.addSubview(eighthButton)
        view.addSubview(ninthButton)
        view.addSubview(ceButton)
        view.addSubview(equalsButton)
        view.addSubview(pluseButton)
        view.addSubview(minusButton)
        view.addSubview(divideButton)
        view.addSubview(multiplyButton)
        
    }
    
    func makeConstraints() {
        resultView.snp.makeConstraints{
            $0.height.equalTo(350)
            $0.width.equalTo(400)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-200)
        }
        resultLabel.snp.makeConstraints{
            $0.height.equalTo(100)
            $0.left.right.equalToSuperview().inset(25)
            $0.centerY.equalTo(resultView).offset(100)
        }
        firstButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(-150)
            $0.centerY.equalToSuperview().offset(250)
        }
        secondButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(-60)
            $0.centerY.equalToSuperview().offset(250)
        }
        thirdButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview().offset(250)
        }
        zeroButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(-60)
            $0.centerY.equalToSuperview().offset(350)
            
        }
        fourthButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(-150)
            $0.centerY.equalToSuperview().offset(150)
        }
        fifthButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(-60)
            $0.centerY.equalToSuperview().offset(150)
        }
        sixthButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview().offset(150)
        }
        seventhButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(-150)
            $0.centerY.equalToSuperview().offset(50)
        }
        eighthButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(-60)
            $0.centerY.equalToSuperview().offset(50)
        }
        ninthButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview().offset(50)
        }
        ceButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(-150)
            $0.centerY.equalToSuperview().offset(350)
            
        }
        equalsButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview().offset(350)
        }
        pluseButton.snp.makeConstraints{
            $0.width.equalTo(100)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(130)
            $0.centerY.equalToSuperview().offset(350)
        }
        minusButton.snp.makeConstraints{
            $0.width.equalTo(100)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(130)
            $0.centerY.equalToSuperview().offset(250)
        }
        divideButton.snp.makeConstraints{
            $0.width.equalTo(100)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(130)
            $0.centerY.equalToSuperview().offset(150)
        }
        multiplyButton.snp.makeConstraints{
            $0.width.equalTo(100)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().offset(130)
            $0.centerY.equalToSuperview().offset(50)
        }
    }
    
    @objc func zeroTapped() {
        if resultLabel.text != "0" {
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    @objc func digitButtonPressed(sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        if currentOperation != nil {
            tempNumber = currentNumber
            currentNumber = ""
            currentNumber += String(button.tag)
            tempOperation = currentOperation
            currentOperation = nil
        } else {
            currentNumber += String(button.tag)
        }
    }
    
    @objc func clearButtonPressed() {
        currentNumber = "0"
        
    }
    @objc func equalsButtonPressed() {
        guard let tempOperation = tempOperation,
              let left = Int(tempNumber),
              let right = Int(currentNumber) else {return}
        let resultNumber: Int
        
        switch tempOperation {
        case .pluse:
            resultNumber = left + right
        case .minus:
            resultNumber = left - right
        case .divede:
            resultNumber = left / right
        case .multiply:
            resultNumber = left * right
        }
        
        currentNumber = "\(resultNumber)"
        
        tempNumber = ""
        self.tempOperation = nil
        self.currentOperation = nil
    }
    
    @objc func operationPressed(sender: Any) {
        guard let button = sender as? UIButton else {return} 
        let operation = Operations(rawValue: button.tag)
        currentOperation = operation
        tempNumber = currentNumber
        
    }
}

