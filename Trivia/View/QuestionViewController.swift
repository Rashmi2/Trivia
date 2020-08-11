//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RealmSwift

class QuestionViewController: BaseViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var choice3Button: UIButton!
    @IBOutlet weak var choice4Button: UIButton!
    @IBOutlet weak var optionsType: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    var count:Int = 0
    var name: String?
    var arrayList: [String] = []
    private var viewModel: QuestionViewModel!
    private var preferenceManager: PreferenceManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.choice1Selected.asObservable().subscribe(onNext: {[weak self] (selected) in
            if selected {
                if self?.count == 0{
                    self?.viewModel.choice2Selected.accept(false)
                    self?.viewModel.choice3Selected.accept(false)
                    self?.viewModel.choice4Selected.accept(false)
                }
            }else{
                self?.choice1Button.backgroundColor = UIColor.white
            }
        }).disposed(by:disposeBag)
        
        viewModel.choice2Selected.asObservable().subscribe(onNext: {[weak self] (selected) in
            if selected {
                if self?.count == 0{
                    self?.viewModel.choice1Selected.accept(false)
                    self?.viewModel.choice3Selected.accept(false)
                    self?.viewModel.choice4Selected.accept(false)
                }
            }else{
                self?.choice2Button.backgroundColor = UIColor.white
            }
        }).disposed(by:disposeBag)
        
        viewModel.choice3Selected.asObservable().subscribe(onNext: {[weak self] (selected) in
            if selected {
                if self?.count == 0 {
                    self?.viewModel.choice1Selected.accept(false)
                    self?.viewModel.choice2Selected.accept(false)
                    self?.viewModel.choice4Selected.accept(false)
                }
            }else{
                self?.choice3Button.backgroundColor = UIColor.white
            }
        }).disposed(by:disposeBag)
        
        viewModel.choice4Selected.asObservable().subscribe(onNext: {[weak self] (selected) in
            if selected {
                if self?.count == 0{
                    self?.viewModel.choice1Selected.accept(false)
                    self?.viewModel.choice2Selected.accept(false)
                    self?.viewModel.choice3Selected.accept(false)
                }
            }else{
                self?.choice4Button.backgroundColor = UIColor.white
            }
        }).disposed(by:disposeBag)
    }
    
    
    @IBAction func choice1ButtonTap(_ sender: Any) {
        if !viewModel.choice1Selected.value {
            viewModel.choice1Selected.accept(true)
            choice1Button.backgroundColor = UIColor.green
            if count == 0{
                if let answer = self.choice1Button.titleLabel?.text{
                    viewModel.answer.accept(answer)
                }
            }else{
                if let answer = self.choice1Button.titleLabel?.text{
                    self.arrayList.append(answer)
                }
            }
        }else{
            viewModel.choice1Selected.accept(false)
            choice1Button.backgroundColor = UIColor.white
            if count == 1{
                for value in arrayList{
                    if value == self.choice1Button.titleLabel?.text, let index = getIndex(vm: value){
                        self.arrayList.remove(at: index)
                    }
                }
            }
        }
    }
    
    @IBAction func choice2ButtonTap(_ sender: Any) {
        if !viewModel.choice2Selected.value {
            viewModel.choice2Selected.accept(true)
            choice2Button.backgroundColor = UIColor.green
            if count == 0{
                if let answer = self.choice2Button.titleLabel?.text{
                    viewModel.answer.accept(answer)
                }
            }else{
                if let answer = self.choice2Button.titleLabel?.text{
                    self.arrayList.append(answer)
                }
            }
        }else{
            viewModel.choice2Selected.accept(false)
            choice2Button.backgroundColor = UIColor.white
            if count == 1{
                for value in arrayList{
                    if value == self.choice2Button.titleLabel?.text, let index = getIndex(vm: value){
                        self.arrayList.remove(at: index)
                    }
                }
            }
        }
    }
    
    @IBAction func choice3ButtonTap(_ sender: Any) {
        if !viewModel.choice3Selected.value {
            viewModel.choice3Selected.accept(true)
            choice3Button.backgroundColor = UIColor.green
            if count == 0{
                if let answer = self.choice3Button.titleLabel?.text{
                    viewModel.answer.accept(answer)
                }
            }else{
                if let answer = self.choice3Button.titleLabel?.text{
                    self.arrayList.append(answer)
                }
            }
        }else{
            viewModel.choice3Selected.accept(false)
            choice3Button.backgroundColor = UIColor.white
            if count == 1{
                for value in arrayList{
                    if value == self.choice3Button.titleLabel?.text, let index = getIndex(vm: value){
                        self.arrayList.remove(at: index)
                    }
                }
            }
        }
    }
    
    @IBAction func choice4ButtonTap(_ sender: Any) {
        if !viewModel.choice4Selected.value {
            viewModel.choice4Selected.accept(true)
            choice4Button.backgroundColor = UIColor.green
            if count == 0{
                if let answer = self.choice4Button.titleLabel?.text{
                    viewModel.answer.accept(answer)
                }
            }else{
                if let answer = self.choice4Button.titleLabel?.text{
                    self.arrayList.append(answer)
                }
            }
        }else{
            viewModel.choice4Selected.accept(false)
            choice4Button.backgroundColor = UIColor.white
            if count == 1{
                for value in arrayList{
                    if value == self.choice4Button.titleLabel?.text, let index = getIndex(vm: value){
                        self.arrayList.remove(at: index)
                    }
                }
            }
        }
    }
    
    func getIndex(vm: String) -> Int?{
        let index = self.arrayList.firstIndex(where: {(item) -> Bool in
            return item == vm
        })
        return index
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        if count == 0{
            if let key = questionLabel.text {
                let value = viewModel.answer.value
                let question = addData(key: key, list: [value])
                viewModel.questionList.append(contentsOf: question)
            }
            count = 1
            questionLabel.text = "What are the colors in the Indian national flag? Select all:"
            optionsType.text = "Select more than 1"
            choice1Button.setTitle("A) White.", for: .normal)
            choice2Button.setTitle("B) Yellow.", for: .normal)
            choice3Button.setTitle("C) Orange.", for: .normal)
            choice4Button.setTitle("D) Green.", for: .normal)
            self.clearAll()
        }else{
            if let key = questionLabel.text {
                let value = self.arrayList
                let question = addData(key: key, list: value)
                viewModel.questionList.append(contentsOf: question)
            }
            let realm = try! Realm()
            _ = realm.objects(UserData.self).toArray(ofType: UserData.self) as [UserData]
            let timestamp = Int(NSDate().timeIntervalSince1970 * 1000)

            viewModel.addData(name: self.name!, time:timestamp)
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FinalDeatilViewController") as? FinalDeatilViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    
    func addData(key: String, list: [String]) -> [QuestionList] {
        let objQuestions = QuestionList()
        var arrQuestions : [QuestionList] = []
        let arrValue = List<String>()
        objQuestions.key = key
        arrValue.insert(list.joined(), at: 0)
        objQuestions.values = arrValue.joined()
        arrQuestions.append(objQuestions)
        return arrQuestions
    }
    
    func clearAll() {
        viewModel.choice1Selected.accept(false)
        viewModel.choice2Selected.accept(false)
        viewModel.choice3Selected.accept(false)
        viewModel.choice4Selected.accept(false)
    }
    
    override func inject() {
        viewModel = DependencyInjector.defaultInjector.getContainer().resolve(QuestionViewModel.self)
        preferenceManager = DependencyInjector.defaultInjector.getContainer().resolve(PreferenceManager.self)
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}


