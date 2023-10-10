//
//  ContestViewController.swift
//  Trivia
//
//  Created by Darian Lee on 10/2/23.
//

import UIKit

class ContestViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var contestTextField: UITextField!
    @IBOutlet weak var thanksMessageLabel: UILabel!
    @IBOutlet weak var returnToGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        thanksMessageLabel.text = ""
        
    
        contestTextField.delegate = self
        

        contestTextField.returnKeyType = .done
        
        contestTextField.keyboardType = .default
    }
    
    @IBAction func returnToGameButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowSelectionSegue", sender: self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            thanksMessageLabel.text = "Thank you for your input. Your request will be processed within 50 business days"
        } else {
            thanksMessageLabel.text = ""
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSelectionSegue" {
                if let destinationVC = segue.destination as? CategorySelectorVC {
                    destinationVC.questionIndex = 0
                    destinationVC.correct_counter = 0

                }
            }
        }

}


