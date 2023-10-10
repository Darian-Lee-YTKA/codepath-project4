//
//  EasterEggVC.swift
//  Trivia
//
//  Created by Darian Lee on 10/9/23.
//

import UIKit

class EasterEggVC: UIViewController {
    // this isnt nessecary any more but I'll leave it in
    var questionIndex: Int?
    var receivedDifficulty: String?
    var receivedCategory: Int?
    var correct_counter: Int?
    var restartNum: Int?
    
    

    
    @IBOutlet weak var swipeText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeText.isHidden = true
        //backEggbut.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.swipeText.isHidden = false
           // self.backEggbut.isHidden = false
            
            
            
       }
    }
    //@IBAction func didPressbackEgg(_ sender: UIButton) {
      //  performSegue(withIdentifier: "EggBack", sender: self)
        
   // }

    

   

}
