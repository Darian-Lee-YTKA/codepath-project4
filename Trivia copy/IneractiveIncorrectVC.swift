//
//  IneractiveIncorrectVC.swift
//  Trivia
//
//  Created by Darian Lee on 10/9/23.
//


        import UIKit

class IneractiveIncorrectVC: UIViewController {
    
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var correctAns: String?
    var questionIndex: Int?
    var correct_counter: Int?
    var restartNum: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.setTitle("Next", for: .normal)
        if let unwrappedCorrectAnswer = correctAns{
            correctLabel.text = "\(unwrappedCorrectAnswer)"
            
        }
        else {
            
            correctLabel.text = "yo mama"
        }
    }
    @IBAction func nextQTapped(_ sender: UIButton) {
        if questionIndex == 5{
            questionIndex! += 1
            performSegue(withIdentifier: "EndScreenSegue", sender: self)
        }
        else{
            performSegue(withIdentifier: "ShowCategorySelector", sender: self)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EndScreenSegue"{
            
            if let destinationVC = segue.destination as? TriviaViewController{
                //setting random values so it has something to forcefully unwrap
                destinationVC.receivedCategory = 9
                destinationVC.receivedDifficulty = "hard"
                destinationVC.questionIndex = 6
                destinationVC.correct_counter = correct_counter!
                destinationVC.restartNum = restartNum!
            }
        }
        else {
            if segue.identifier == "ShowCategorySelector" {
                if let destinationVC = segue.destination as? CategorySelectorVC, let index = questionIndex {
                    destinationVC.questionIndex = index
                    destinationVC.correct_counter = correct_counter
                    destinationVC.restartNum = restartNum!
                    }
                
                
            }
            
        }
    }
}

