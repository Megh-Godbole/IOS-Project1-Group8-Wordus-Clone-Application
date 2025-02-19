//
//  ViewController.swift
//  Project1
//
//  Created by Megh Godbole on 2025-02-18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSumit: UIButton!
    @IBOutlet weak var rootUIStackView: UIStackView!
    // Track current position for letter placement
    var currentRow = 0
    var currentColumn = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInputBox()
        btnSumit.isEnabled = false
    }
    
    @IBAction func keyBoardPress(_ sender: UIButton) {
        guard let letter = sender.titleLabel?.text else { return }
        
        if letter == "<" {
            // Handle backspace
            if currentColumn > 0 {
                // Move back within the same row
                currentColumn -= 1
            } else if currentRow > 0 {
                // Move back to the previous row
                currentRow -= 1
                if let prevRow = rootUIStackView.arrangedSubviews[currentRow] as? UIStackView {
                    currentColumn = prevRow.arrangedSubviews.count - 1
                }
            }
            
            if let rowStack = rootUIStackView.arrangedSubviews[currentRow] as? UIStackView,
               let label = rowStack.arrangedSubviews[currentColumn] as? UILabel {
                label.text = " * "  // Clear the letter
            }
        } else {
            // Handle letter input
            if currentRow < rootUIStackView.arrangedSubviews.count,
               let rowStack = rootUIStackView.arrangedSubviews[currentRow] as? UIStackView,
               currentColumn < rowStack.arrangedSubviews.count,
               let label = rowStack.arrangedSubviews[currentColumn] as? UILabel {
                
                label.text = " " + letter + " "
                currentColumn += 1  // Move to the next column
                
                // If the row is full, move to the next row
                if currentColumn >= rowStack.arrangedSubviews.count {
                    currentRow += 1
                    currentColumn = 0
                }
            }
        }
    }

    func setInputBox(){
        for stackView in rootUIStackView.arrangedSubviews {
            if let horizontalStack = stackView as? UIStackView {
                for label in horizontalStack.arrangedSubviews {
                    if let letterLabel = label as? UILabel {
                        letterLabel.layer.borderWidth = 2
                        letterLabel.layer.borderColor = UIColor.black.cgColor
                        letterLabel.layer.backgroundColor = UIColor.lightGray.cgColor
                        letterLabel.textAlignment = .justified
                        letterLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                        letterLabel.text! = " * "
                    }
                }
            }
        }
    }

}
