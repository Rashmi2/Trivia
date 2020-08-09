//
//  ViewController.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//
import Foundation
import UIKit

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    private var viewModel: DetailViewModel!
    private var preferenceManager: PreferenceManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.rx.text.orEmpty.bind(to: viewModel.userName).disposed(by: disposeBag)
        
    }
    @IBAction func nextButtonTap(_ sender: Any) {
        if viewModel.userName.value != "" {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController {
                vc.name = viewModel.userName.value
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            MatSnackBar.show(message: "Please enter the name")
        }
    }
    
    override func inject() {
        viewModel = DependencyInjector.defaultInjector.getContainer().resolve(DetailViewModel.self)
        preferenceManager = DependencyInjector.defaultInjector.getContainer().resolve(PreferenceManager.self)
    }
}

