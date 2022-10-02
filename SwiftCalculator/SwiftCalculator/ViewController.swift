//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Bartu Gençcan on 30.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorOperations: UILabel!
    @IBOutlet weak var calculatorResults: UILabel!
    
    var operations: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
        // Do any additional setup after loading the view.
    }

    func clearAll(){
        operations = ""
        calculatorOperations.text = ""
        calculatorResults.text = ""
    }
    
    func addToWorkings(value: String){
        operations = operations + value
        calculatorOperations.text = operations
    }
    
    @IBAction func clearAllTapped(_ sender: UIButton) {
       clearAll()
    }
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        
        if validInput(){
            let expression = NSExpression(format: operations)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResults.text = resultString
        }else {
            let alert = UIAlertController(title: "Invalid Input", message: "Calculator unable to do math with that input.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validInput() -> Bool {
        
        var count = 0
        var funcCharIndex = [Int]()
        
        for char in operations {
            if specialCharacter(char: char) {
                funcCharIndex.append(count)
            }
            
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndex {
            if index == 0 {
                return false
            }
            
            if index == operations.count - 1 {
                return false
            }
            
            if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            
            previous = index
        }
        
        return true
    }
    
    func specialCharacter (char: Character) -> Bool {
        switch char {
        case "*":
            return true
        case "-":
            return true
        case "+":
            return true
        case "/":
            return true
        default:
            return false
        }
    }
        
    func formatResult(result: Double) -> String{
        
        if (result.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", result)
        }else {
            return String(format: "%.2f", result)
        }
        
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        if !operations.isEmpty{
            operations.removeLast()
            calculatorOperations.text = operations
        }
    }
    
    @IBAction func percentTapped(_ sender: UIButton) {
        addToWorkings(value: "%")
    }
    
    @IBAction func divideTapped(_ sender: UIButton) {
        addToWorkings(value: "/")
    }
    
    @IBAction func timesTapped(_ sender: UIButton) {
        addToWorkings(value: "*")
    }
    
    @IBAction func minusTapped(_ sender: UIButton) {
        addToWorkings(value: "-")
    }
    
    @IBAction func plusTapped(_ sender: UIButton) {
        addToWorkings(value: "+")
    }
    
    @IBAction func decimalTapped(_ sender: UIButton) {
        addToWorkings(value: ".")
    }
    
    @IBAction func squareRootTapped(_ sender: UIButton) {
        addToWorkings(value: "√")
    }
    
    @IBAction func numberTapped(_ sender: UIButton) {
        
        if calculatorResults.text == "" {
            addToWorkings(value: (sender.titleLabel?.text)!)
        }else {
            clearAll()
            addToWorkings(value: (sender.titleLabel?.text)!)
        }
    }
    
}

