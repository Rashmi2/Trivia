//
//  HisoryDetailViewModel.swift
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

class HisoryDetailViewModel {
    
    var userRepository: UserRepository!
    var user = BehaviorRelay<[UserData]>(value: [UserData]())
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func fetchHistory(){
        let data = userRepository.fetchAllData()
        self.user.accept(data)
    }
    
}
