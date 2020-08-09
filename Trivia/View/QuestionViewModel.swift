//
//  QuestionViewModel.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

class QuestionViewModel{
    
    var choice1Selected =  BehaviorRelay<Bool>(value: false)
    var choice2Selected =  BehaviorRelay<Bool>(value: false)
    var choice3Selected =  BehaviorRelay<Bool>(value: false)
    var choice4Selected =  BehaviorRelay<Bool>(value: false)
    var questionList: [QuestionList] = []
    var answer = BehaviorRelay<String>(value: "")
    var answer2List = BehaviorRelay<[String]>(value: [String]())
    var userRepository: UserRepository!
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func addData(name:String, time: Int) {
        userRepository.AddUser(name: name, time: time, lists: self.questionList)
    }
}
