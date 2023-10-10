//
//  FinalScoreCode.swift
//  Trivia
//
//  Created by Darian Lee on 10/2/23.
//

import Foundation
struct FinalScoreCode {
    let score: ScoreCode
}

enum ScoreCode {
    case zero
    case one
    case two
    case three


    var scoring_string: String {
            switch self {
            case .zero:
                return "0/3"
            case .one:
                return "1/3"
            case .two:
                return "2/3"
            case .three:
                return "3/3"
            }
        }
    
  var description: String {
    switch self {
    case .zero:
      return "At least you weren't playing for money"
    case .one:
      return "At least you got one right :)"
    case .two:
      return "Not bad!"
    case .three:
      return "TRIVIA GOD!"

    }
  }



}
