//
//  ViewController.swift
//  Project1
//
//  Created by Megh Godbole on 2025-02-18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rootUIStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInputBox()
    }
    @IBAction func clikedKeyboard(_ sender: UIButton) {
        
        
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

