//
//  MatSnackBar.swift
//  Trivia
//
//  Created by Rashmi on 09/08/20.
//  Copyright © 2020 Team. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar

class MatSnackBar: MDCSnackbarMessage {
    
    static func show(message:String){
        MDCSnackbarManager.show(MDCSnackbarMessage.init(text: message))
    }
}
