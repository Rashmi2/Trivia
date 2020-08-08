//
//  SplashViewController.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    var timer: Timer? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(navigateTo), userInfo: nil, repeats: false)
    }
    
    @objc func navigateTo() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginInViewController") as? Detail {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
