//
//  GradientView.swift
//  ExpenseTracker
//
//  Created by Rashmi on 09/07/20.
//  Copyright © 2020 Rashmi. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    @IBInspectable var cornerRadius:Bool = false {
        didSet{
            self.layer.cornerRadius = CGFloat(50.0)
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    override class var layerClass: AnyClass { get {
        return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
    }
}
