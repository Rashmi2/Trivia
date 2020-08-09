//
//  FinalDetailViewController.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class FinalDeatilViewController: BaseViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var firstAnswer: UILabel!
    @IBOutlet weak var secondAnswer: UILabel!
    private var viewModel: FinalDetailViewModel!
    private var preferenceManager: PreferenceManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        
        self.userName.text = viewModel.userData.name
        let questionList = viewModel.userData.questions
        for count in 0...questionList.count - 1{
            if count == 0{
                self.firstAnswer.text = questionList[count].values
            }else{
                if let list = questionList[count].values?.dropLast(){
                    let newString = list.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
                    self.secondAnswer.text = newString
                }
            }
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let data = UserData()
        viewModel.userData = data
    }
    @IBAction func historyButtonTap(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryDetailViewController") as? HistoryDetailViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func finishButtonTap(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func inject() {
        viewModel = DependencyInjector.defaultInjector.getContainer().resolve(FinalDetailViewModel.self)
        preferenceManager = DependencyInjector.defaultInjector.getContainer().resolve(PreferenceManager.self)
    }
}
