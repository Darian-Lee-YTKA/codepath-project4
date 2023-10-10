//
//  CategorySelectorVC.swift
//  Trivia
//
//  Created by Darian Lee on 10/7/23.
//

import UIKit

class CategorySelectorVC: UIViewController {
    
    @IBOutlet weak var cat1: UIButton!
    @IBOutlet weak var cat2: UIButton!
    @IBOutlet weak var cat3: UIButton!
    
    @IBOutlet weak var cat4: UIButton!
    @IBOutlet weak var selectcat: UILabel!
    
    @IBOutlet weak var hard: UIButton!
    @IBOutlet weak var medium: UIButton!
    @IBOutlet weak var easy: UIButton!
    
    var selectedDifficulty: String?
    var selectedCategory: Int?
    var correct_counter: Int?
    var questionIndex: Int?
    var restartNum: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if questionIndex == nil {
            questionIndex = 0
        }
        else{
            print(questionIndex!)
            
            
        }
        if correct_counter == nil {
            correct_counter = 0
        }
        else{
            print(correct_counter!)
            
            
        }
        if restartNum == nil {
            restartNum = 0
        }
        else{
            print(restartNum)
            
            
        }
        
        print("SELECCCCCTTT CAT")
        print(questionIndex!)
        
        selectcat.text = "Select Category for q\(questionIndex! + 1)"
        
        cat1.setTitle("General Knowledge", for: .normal)
        cat1.layer.borderWidth = 3.0
        cat1.layer.borderColor = UIColor.white.cgColor
        cat1.layer.cornerRadius = 8.0
        
        cat2.setTitle("Science", for: .normal)
        cat2.layer.borderWidth = 3.0
        cat2.layer.borderColor = UIColor.white.cgColor
        cat2.layer.cornerRadius = 8.0
        
        cat3.setTitle("History & Politics", for: .normal)
        cat3.layer.borderWidth = 3.0
        cat3.layer.borderColor = UIColor.white.cgColor
        cat3.layer.cornerRadius = 8.0
        
        cat4.setTitle("TV & Movies", for: .normal)
        cat4.layer.borderWidth = 3.0
        cat4.layer.borderColor = UIColor.white.cgColor
        cat4.layer.cornerRadius = 8.0
        
        easy.layer.borderWidth = 3.0
        easy.layer.borderColor = UIColor.black.cgColor
        easy.layer.cornerRadius = 8.0
        
        medium.layer.borderWidth = 3.0
        medium.layer.borderColor = UIColor.black.cgColor
        medium.layer.cornerRadius = 8.0
        
        hard.layer.borderWidth = 3.0
        hard.layer.borderColor = UIColor.black.cgColor
        hard.layer.cornerRadius = 8.0
    }

    
    @IBAction func didPressSports(_ sender: UIButton) {
        selectedCategory = 9
        if let unwrappedQuestionIndex = questionIndex {
            questionIndex = unwrappedQuestionIndex + 1
        }
        if let category = selectedCategory, let difficulty = selectedDifficulty {
            performSegue(withIdentifier: "DifficultySelectionSegue", sender: self)
        }
    }
    
    @IBAction func didPressScience(_ sender: UIButton) {
        let temp = randomChoice(17, 18, 19)
        selectedCategory = temp
        if let unwrappedQuestionIndex = questionIndex {
            questionIndex = unwrappedQuestionIndex + 1
        }
        if let category = selectedCategory, let difficulty = selectedDifficulty {
            performSegue(withIdentifier: "DifficultySelectionSegue", sender: self)
        }
    }
    func randomChoice(_ values: Int...) -> Int {
        let randomIndex = Int.random(in: 0..<values.count)
        return values[randomIndex]
    }
    
    @IBAction func didPressHistory(_ sender: UIButton) {
        let temp = randomChoice(23, 24)
        selectedCategory = temp
        if let unwrappedQuestionIndex = questionIndex {
            questionIndex = unwrappedQuestionIndex + 1
        }
        if let category = selectedCategory, let difficulty = selectedDifficulty {
            performSegue(withIdentifier: "DifficultySelectionSegue", sender: self)
        }
    }
    
    @IBAction func didPressEntertainment(_ sender: UIButton) {
        let temp = randomChoice(11,14)
        selectedCategory = temp
        if let unwrappedQuestionIndex = questionIndex {
            questionIndex = unwrappedQuestionIndex + 1
            
        }
        if let category = selectedCategory, let difficulty = selectedDifficulty {
            performSegue(withIdentifier: "DifficultySelectionSegue", sender: self)
        }
       
    }
    
    @IBAction func didPressEasy(_ sender: UIButton) {
        selectedDifficulty = "easy"
        if let category = selectedCategory, let difficulty = selectedDifficulty {
            performSegue(withIdentifier: "DifficultySelectionSegue", sender: self)
        }
        
        
    }
    
    @IBAction func didPressMedium(_ sender: UIButton) {
        selectedDifficulty = "medium"
        if let category = selectedCategory, let difficulty = selectedDifficulty {
            performSegue(withIdentifier: "DifficultySelectionSegue", sender: self)
        }
    }
    
    @IBAction func didPressHard(_ sender: UIButton) {
        selectedDifficulty = "hard"
        if let category = selectedCategory, let difficulty = selectedDifficulty {
            performSegue(withIdentifier: "DifficultySelectionSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DifficultySelectionSegue" {
            if let destinationVC = segue.destination as? TriviaViewController {
                destinationVC.receivedDifficulty = selectedDifficulty
                destinationVC.receivedCategory = selectedCategory
                destinationVC.questionIndex = questionIndex!
                destinationVC.correct_counter = correct_counter!
                destinationVC.restartNum = restartNum!
            }
        }

    }
}
