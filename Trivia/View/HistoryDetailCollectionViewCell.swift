//
//  HistoryDetailCollectionViewCell.swift
//  Trivia
//
//  Created by Rashmi on 08/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import UIKit

class HistoryDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameCount: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var question1Label: UILabel!
    @IBOutlet weak var answer1LAbel: UILabel!
    @IBOutlet weak var question2LAbel: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 5
    }
    
    func configure(model: UserData, index: Int) {
        self.nameLabel.text = model.name
        let num = String(index+1)
        self.gameCount.text = "Game"+""+num
        let questions = model.questions
        if let time = model.gameTime.value{
            let date = NSDate(timeIntervalSince1970: TimeInterval(time)/1000)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: date as Date)
            dateFormatter.dateFormat = "hh:mm a"
            let time = dateFormatter.string(from: date as Date)
            timeLabel.text = dateString+" "+time
        }
        for list in 0...model.questions.count{
            if list == 0{
                self.question1Label.text = questions[0].key
                self.answer1LAbel.text = questions[0].values
            }else{
                self.question2LAbel.text = questions[1].key
                if let list = questions[1].values?.dropLast(){
                    let newString = list.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
                    self.answer2Label.text = newString
                }
            }
        }
    }
}
