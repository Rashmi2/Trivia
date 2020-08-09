//
//  UserData.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
class UserData:Object, Mappable {
    
    var gameTime = RealmOptional<Int>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    @objc dynamic var name: String?
    var questions = List<QuestionList>()
    
    override static func primaryKey() -> String? {
        return "gameTime"
    }
    
    func mapping(map: Map) {
        name <- map["Name"]
        gameTime <- map["Date"]
        questions <- (map["Questions"], ArrayTransform<QuestionList>())
        
    }
}

class QuestionList : Object, Mappable {
    @objc dynamic var key : String?
    @objc dynamic var values : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        key <- map["key"]
        values <- map["values"]
    }
    
    func createJsonOject() -> [String: Any]? {
        if let key = key {
            if let _ = values {
                return ["key": key, "values": [values!]]
            } else {
                return ["key": key, "values": [""]]
            }
        } else {
            return nil
        }
    }
}

class ArrayTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    typealias Object = List<T>
    typealias JSON = Array<[String:Any]>
    
    func transformFromJSON(_ value: Any?) -> List<T>? {
        let realmList = List<T>()
        
        if let jsonArray = value as? Array<Any> {
            for item in jsonArray {
                if let realmModel = Mapper<T>().map(JSONObject: item) {
                    realmList.append(realmModel)
                }
            }
        }
        
        return realmList
    }
    
    func transformToJSON(_ value: List<T>?) -> Array<[String:Any]>? {
        
        guard let realmList = value, realmList.count > 0 else { return nil }
        
        var resultArray = Array<[String:Any]>()
        
        for entry in realmList {
            resultArray.append(entry.toJSON())
        }
        
        return resultArray
    }
}


