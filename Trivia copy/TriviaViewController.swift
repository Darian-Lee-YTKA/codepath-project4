
import UIKit

struct Question {
    let category: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let done: Bool
}

class TriviaViewController: UIViewController {
    var receivedDifficulty: String?
    var receivedCategory: Int?
    var questionIndex: Int?
    var correct_counter: Int?
    var currentQuestion: Question?
    var restartNum: Int?
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(receivedCategory!)
        print(receivedDifficulty!)
        print("QUESSSSSSTION INDEXXXXXXXXX")
        print(questionIndex!)
        if let receivedCategory = receivedCategory, let receivedDifficulty = receivedDifficulty {
            fetchQuestion(receivedCategory: receivedCategory, receivedDifficulty: receivedDifficulty) { [weak self] question in
                if let question = question {
                    self?.currentQuestion = question
                    self?.configureUI()
                } else {
                    print("No question fetched.")
                }
            }
        } else {
            print("Category or difficulty is nil.")
        }
    }
    
    func fetchQuestion(receivedCategory: Int, receivedDifficulty: String, completion: @escaping (Question?) -> Void) {
        let apiURL = "https://opentdb.com/api.php?amount=1&category=\(receivedCategory)&difficulty=\(receivedDifficulty)"
        print(apiURL)
        print("DARIAN! WE DID US")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        if let url = URL(string: apiURL) {
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching data: \(error)")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let results = json["results"] as? [[String: Any]] {
                        if let firstResult = results.first,
                           let category = firstResult["category"] as? String,
                           let difficulty = firstResult["difficulty"] as? String,
                           let questionText = firstResult["question"] as? String,
                           let correctAnswer = firstResult["correct_answer"] as? String,
                           let incorrectAnswers = firstResult["incorrect_answers"] as? [String] {
                            print("Category: \(category)")
                            print("Difficulty: \(difficulty)")
                            print("Question: \(questionText)")
                            print("Correct Answer: \(correctAnswer)")
                            print("Incorrect Answers: \(incorrectAnswers)")
                            
                            let question = Question(category: category,
                                                    difficulty: difficulty,
                                                    question: questionText,
                                                    correctAnswer: correctAnswer,
                                                    incorrectAnswers: incorrectAnswers,
                                                    done: self.questionIndex! > 5)
                            completion(question)
                        } else {
                            print("No questions found in the results array.")
                            completion(nil)
                        }
                    } else {
                        print("No matching question found")
                        completion(nil)
                    }
                } catch {
                    // Handle JSON serialization error here
                    print("JSON Serialization Error: \(error)")
                    completion(nil)
                }
            }
            task.resume()
        }
    }


    
    
    
    
    
    @IBOutlet weak var questionNumber: UILabel!
    
    @IBOutlet weak var choiceFour: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var restart: UIButton!
    

    @IBOutlet weak var contest: UIButton!
    

    
    @IBOutlet weak var easterEggButton: UIButton!
    
    
    
    func performSegueAndDismiss(withIdentifier identifier: String) {
        print("Function called at least")
        performSegue(withIdentifier: identifier, sender: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true) {
                if self.questionIndex! < 5{
                    self.performSegue(withIdentifier: "SelectCategorySegue", sender: self)
                }
                else{
                    self.questionText.text = "\(self.correct_counter!)/5"
                    
                    
                    self.topic.text = "Great Work!"
                    self.choiceOne.setTitle("", for: .normal)
                    self.choiceTwo.setTitle("", for: .normal)
                    self.choiceThree.setTitle("", for: .normal)
                    self.choiceFour.setTitle("", for: .normal)
                    self.restart.setTitle("Restart", for: .normal)
                    self.contest.setTitle("Contest Score", for: .normal)
                    self.questionNumber.text = "GAME OVER"
                    
                }
            }
        }
    }
    
    
    
    private func configureUI() {
        guard let currentQuestion = currentQuestion else {
            return
        }
        if currentQuestion.done == false{
            
            var allChoices = [currentQuestion.correctAnswer] + currentQuestion.incorrectAnswers
            allChoices.shuffle()
            
            
            DispatchQueue.main.async {
                
                self.questionText.text = self.deleteFoolishness(currentQuestion.question)
                
                
                self.topic.text = "\(String(describing: self.getTopic(self.receivedCategory!))): \(currentQuestion.difficulty)"
                if allChoices.count == 2 {
                    self.choiceOne.setTitle(self.deleteFoolishness(allChoices[0]), for: .normal)
                    self.choiceTwo.setTitle(self.deleteFoolishness(allChoices[1]), for: .normal)
                    self.choiceThree.isHidden = true
                    self.choiceFour.isHidden = true }
                else {
                    self.choiceOne.setTitle(self.deleteFoolishness(allChoices[0]), for: .normal)
                    self.choiceTwo.setTitle(self.deleteFoolishness(allChoices[1]), for: .normal)
                    self.choiceThree.setTitle(self.deleteFoolishness(allChoices[2]), for: .normal)
                    self.choiceFour.setTitle(self.deleteFoolishness(allChoices[3]), for: .normal) }
                
                self.restart.setTitle(currentQuestion.done ? "Restart" : "", for: .normal)
                self.contest.setTitle(currentQuestion.done ? "Contest Score" : "", for: .normal)
                self.questionNumber.text = "Question \(self.questionIndex!)/5"
            }
        }
        else {
            
            
            
        DispatchQueue.main.async {
            
            self.questionText.text = "\(self.correct_counter!)/5"
            
            
            self.topic.text = "Great Work!"
            self.choiceOne.setTitle("", for: .normal)
            self.choiceTwo.setTitle("", for: .normal)
            self.choiceThree.setTitle("", for: .normal)
            self.choiceFour.setTitle("", for: .normal)
            self.restart.setTitle(currentQuestion.done ? "Restart" : "", for: .normal)
            self.contest.setTitle(currentQuestion.done ? "Contest Score" : "", for: .normal)
            self.questionNumber.text = "GAME OVER"
            }
            
        }
    }
    
    func getTopic(_ code: Int) -> String {
        if code == 23 || code == 24 {
            return "History & Politics"
        }
        if code >= 17 && code <= 19{
            return "Science"
        }
        if code == 11 || code == 14{
            return "TV & Movies"
        }
        if code == 9{
            return "General"
        }
        return "unknown"
    }
    func deleteFoolishness(_ code: String) -> String {
        var modifiedCode = code
        
        modifiedCode = modifiedCode
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&apos;", with: "'")
            .replacingOccurrences(of: "&ndash;", with: "–")
            .replacingOccurrences(of: "&mdash;", with: "—")
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "&#039;", with: "'")
            .replacingOccurrences(of: "&ograve;", with: "ò")
            .replacingOccurrences(of: "&eacute;", with: "é")
            .replacingOccurrences(of: "&auml;", with: "ä")
            .replacingOccurrences(of: "&agrave;", with: "à")
            .replacingOccurrences(of: "&acirc;", with: "â")
            .replacingOccurrences(of: "&euml;", with: "ë")
            .replacingOccurrences(of: "&egrave;", with: "è")
            .replacingOccurrences(of: "&ecirc;", with: "ê")
            .replacingOccurrences(of: "&ocirc;", with: "ô")
            .replacingOccurrences(of: "&icirc;", with: "î")
            .replacingOccurrences(of: "&iuml;", with: "ï")
            .replacingOccurrences(of: "&ugrave;", with: "ù")
            .replacingOccurrences(of: "&ucirc;", with: "û")
            .replacingOccurrences(of: "&uuml;", with: "ü")
            .replacingOccurrences(of: "&ntilde;", with: "ñ")
            .replacingOccurrences(of: "&ccedil;", with: "ç")
            .replacingOccurrences(of: "&yuml;", with: "ÿ")
            .replacingOccurrences(of: "&OElig;", with: "Œ")
            .replacingOccurrences(of: "&oelig;", with: "œ")
            .replacingOccurrences(of: "&szlig;", with: "ß")
            .replacingOccurrences(of: "&Aring;", with: "Å")
            .replacingOccurrences(of: "&aring;", with: "å")
            .replacingOccurrences(of: "&AElig;", with: "Æ")
            .replacingOccurrences(of: "&aelig;", with: "æ")

        
        return modifiedCode
    }
    
    
    

    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        if restartNum == 1{
            performSegue(withIdentifier: "UpgradeSegue", sender: self)
        }
        else {
            questionIndex = 0
            correct_counter = 0
            restartNum! += 1
            performSegue(withIdentifier: "SelectCategorySegue", sender: self)
        }
    }
    @IBAction func easterEggTapped(_ sender: UIButton) {
        
            performSegue(withIdentifier: "showEasterEggSegue", sender: self)
        }
       
    
    
    
    @IBAction func contestButtonTapped(_ sender: UIButton) {
        let tappedChoice = sender.currentTitle
        if tappedChoice != ""{
            performSegue(withIdentifier: "ShowContestScoreSegue", sender: self)
        }
    }
    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectCategorySegue" {
            if questionIndex == 5 {
                questionIndex! += 1
                // no segue needed
            }
            else{
                print("WE SEGUED TOGETHER!")
                if let destinationVC = segue.destination as? CategorySelectorVC {
                    destinationVC.questionIndex = questionIndex!
                    destinationVC.correct_counter = correct_counter!
                    destinationVC.restartNum = restartNum!
                }
            }
        }
        
        
        if segue.identifier == "ShowIneractiveIncorrectSegue" {
            if let destination2VC = segue.destination as? IneractiveIncorrectVC{
                destination2VC.questionIndex = questionIndex!
                print(currentQuestion!.correctAnswer)
                destination2VC.correctAns = deleteFoolishness(currentQuestion!.correctAnswer)
                destination2VC.correct_counter = correct_counter!
                destination2VC.restartNum = restartNum!
            }
        }
        if segue.identifier == "showEasterEggSegue" {
            if let destination3VC = segue.destination as? EasterEggVC{
                destination3VC.questionIndex = questionIndex!
                
                destination3VC.correct_counter = correct_counter!
                destination3VC.restartNum = restartNum!
                destination3VC.receivedDifficulty = receivedDifficulty!
                destination3VC.receivedCategory = receivedCategory!
            }
            
        }
    }
            
            
    
    
        
        
        @IBAction func choiceButtonTapped(_ sender: UIButton) {
            guard let tappedChoice = sender.currentTitle, let currentQuestion = currentQuestion else {
                return
            }
            
            if tappedChoice != "" {
                if tappedChoice == currentQuestion.correctAnswer {
                    correct_counter! += 1
                    performSegueAndDismiss(withIdentifier: "ShowCorrectSegue")
                } else {
                    performSegue(withIdentifier: "ShowIneractiveIncorrectSegue", sender: self)
                }
            }
            
            
        }
    }
    
    

