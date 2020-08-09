//
//  FinalDetailViewModel.swift
//  Trivia
//
//  Created by Rashmi on 09/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

class FinalDetailViewModel {
    var userData = UserData()
    var questionList: [QuestionList] = []
    var answer = BehaviorRelay<String>(value: "")
    var answer2List = BehaviorRelay<[String]>(value: [String]())
    var userRepository: UserRepository!
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func fetchData() {
        self.userData = userRepository.fetchFirstData()
    }
}

