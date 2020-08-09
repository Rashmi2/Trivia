//
//  BaseViewController.swift
//  ExpenseTracker
//
//  Created by Rashmi on 09/07/20.
//  Copyright © 2020 Rashmi. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController{
    
    var disposeBag = DisposeBag()
//    weak var overlay : OverlayViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inject()
        setStyle()
    }
    
    func setStyle(){
        
        navigationController?.navigationBar.shadowImage  = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = true
//        navigationItem.hideBackButtonTitle()
    }
    
    func inject(){
        
    }
    
    @IBAction func endEditing() {
        view.endEditing(true)
    }

    func addChild(vc:UIViewController?, superView:UIView){
        
        if let vc = vc{
            self.addChild(vc)
            let subView = vc.view!
            superView.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
            let views : [String:UIView] = ["view": subView]
            superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .alignAllLeft, metrics: nil, views: views))
            superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[view]|", options: .alignAllTop, metrics: nil, views: views))
        }
        
    }
    
//    @objc func hideErrorOverlay(){
//        removeOverlay(child: overlay)
//    }

    @objc func goToDashboard(){
        self.tabBarController?.selectedIndex = 0
       // removeOverlay(child: overlay)
    }

    
    @IBAction func back() {
        self.navigationController?.popViewController(animated: true)
    }
    func animate() {
        UIView.animate(withDuration: 0.2) {[view] in
            view?.layoutIfNeeded()
        }
    }
    ///use it on viewDidLoad function. If you are using TabBarController this code segment should be on viewWillAppear function. This is important!
    func setStatusBar(color: UIColor) {
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
}
