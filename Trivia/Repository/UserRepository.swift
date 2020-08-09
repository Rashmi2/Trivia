//
//  UserRepository.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import ObjectMapper

class UserRepository {
    
    func AddUser(name: String, time: Int, lists: [QuestionList]) { // to add new user data into database
        let user = UserData()
        let realm = try! Realm()
        try! realm.write {
            user.name = name
            user.gameTime.value = time
            for list in lists{
                if list.createJsonOject() != nil {
                    user.questions.append(list)
                }
            }
            realm.add(user, update: .all)
        }
    }
    
    func fetchFirstData() -> UserData{ // retrieving last inserted data
        var userData = UserData()
        let realm = try! Realm()
        try! realm.write {
            if let data = realm.objects(UserData.self).last {
                userData = data
            }
        }
        return userData
    }
    
    func fetchAllData() -> [UserData] { //Retrieving  all the data from Database
        var list: [UserData] = []
        let realm = try! Realm()
        let saveItemDefinition = realm.objects(UserData.self)
        for user in 0...saveItemDefinition.count - 1{
            list.append(saveItemDefinition[user])
        }
        return list
    }
}

