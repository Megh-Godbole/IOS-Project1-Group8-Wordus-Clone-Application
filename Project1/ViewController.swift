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
    
    var currentRow = 0
        var currentColumn = 0
        let maxColumns = 5  // Each guess is a 5-letter word
        let maxRows = 6     // Maximum attempts
    let wordList = ["PLANT", "STONE", "BREAD", "APPLE", "GAMER"] // Static words
        var targetWord: String = "" // The word to be guessed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        targetWord = wordList.randomElement() ?? "PLANT" // Pick a random word
                print("Target Word: \(targetWord)") // Debugging
        setInputBox()
        btnSumit.isEnabled = false
    }
    
    @IBAction func keyBoardPress(_ sender: UIButton) {
        guard let letter = sender.titleLabel?.text else { return }
                
                if letter == "<" { // Handle backspace
                    handleBackspace()
                } else { // Handle letter input
                    handleLetterInput(letter)
                }
    }

    func handleLetterInput(_ letter: String) {
        if currentRow < maxRows,
           let rowStack = rootUIStackView.arrangedSubviews[currentRow] as? UIStackView,
           currentColumn < maxColumns,
           let label = rowStack.arrangedSubviews[currentColumn] as? UILabel {
            
            label.text = letter
            currentColumn += 1  // Move to the next column
            
            // Enable submit button when 5 letters are entered
            btnSumit.isEnabled = (currentColumn == maxColumns)
        }
    }
    
    func handleBackspace() {
            if currentColumn > 0 {
                currentColumn -= 1
            }
            
            if let rowStack = rootUIStackView.arrangedSubviews[currentRow] as? UIStackView,
               let label = rowStack.arrangedSubviews[currentColumn] as? UILabel {
                label.text = ""  // Clear the letter
            }
            
            btnSumit.isEnabled = false // Disable submit if not fully filled
        }
    
    @IBAction func clickSubmit(_ sender: UIButton) {
        if currentColumn == maxColumns { // Ensure the row is fully filled
            let guess = getCurrentGuess()
            print("Submitted Word: \(guess)") // Debugging
            
            applyColorLogic(for: guess)
            
            if guess == targetWord {
                showGameOverMessage(isWinner: true)
            } else if currentRow < maxRows - 1 {
                currentRow += 1
                currentColumn = 0
                btnSumit.isEnabled = false
            } else {
                showGameOverMessage(isWinner: false)
            }
        }
        }
    
    func getCurrentGuess() -> String {
            guard let rowStack = rootUIStackView.arrangedSubviews[currentRow] as? UIStackView else { return "" }
            var guess = ""
            
            for label in rowStack.arrangedSubviews {
                if let letterLabel = label as? UILabel, let text = letterLabel.text {
                    guess.append(text)
                }
            }
            return guess
        }
    func applyColorLogic(for guess: String) {
            guard let rowStack = rootUIStackView.arrangedSubviews[currentRow] as? UIStackView else { return }
            let targetArray = Array(targetWord)
            var guessArray = Array(guess)
            
            for (index, label) in rowStack.arrangedSubviews.enumerated() {
                if let letterLabel = label as? UILabel {
                    let guessedChar = guessArray[index]
                    if guessedChar == targetArray[index] {
                        letterLabel.backgroundColor = .systemBlue // Correct position
                    } else if targetWord.contains(guessedChar) {
                        letterLabel.backgroundColor = .systemOrange // Wrong position
                    } else {
                        letterLabel.backgroundColor = .darkGray // Letter not in word
                    }
                }
            }
        }
    func showGameOverMessage(isWinner: Bool) {
            let message = isWinner ? "You Won!" : "Game Over! The word was \(targetWord)"
            let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in self.resetGame() }))
            present(alert, animated: true)
        }

        func resetGame() {
            targetWord = wordList.randomElement() ?? "PLANT"
            print("New Target Word: \(targetWord)") // Debugging
            currentRow = 0
            currentColumn = 0
            btnSumit.isEnabled = false

            for stackView in rootUIStackView.arrangedSubviews {
                if let rowStack = stackView as? UIStackView {
                    for label in rowStack.arrangedSubviews {
                        if let letterLabel = label as? UILabel {
                            letterLabel.text = ""
                            letterLabel.backgroundColor = .white
                        }
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
                        letterLabel.textAlignment = .center
                        letterLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                        letterLabel.text = ""
                        letterLabel.backgroundColor = UIColor.white
                                            letterLabel.translatesAutoresizingMaskIntoConstraints = false
                                            letterLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
                                            letterLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
                                        
                    }
                }
            }
        }
    }

}
