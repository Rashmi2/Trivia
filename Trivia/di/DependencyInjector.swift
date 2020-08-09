//
//  DependencyInjector.swift
//  ExpenseTracker
//
//  Created by Rashmi on 14/07/20.
//  Copyright © 2020 Rashmi. All rights reserved.
//

import Foundation
import Swinject
import CoreLocation

class DependencyInjector {
    
    private var container = Container()
    
    public static var defaultInjector: DependencyInjector = {
        let injector = DependencyInjector()
        return injector
    }()
    
    func getContainer()->Container{
        return container
    }
    
    func reset(){
        container = Container()
        register()
    }
    
    public func register() {
        container.register(PreferenceManager.self) { r  in
            PreferenceManager()
        }.inObjectScope(ObjectScope.container)
        
        container.register(UserRepository.self) {r in
            UserRepository()
        }.inObjectScope(ObjectScope.container)
        
        container.register(QuestionViewModel.self) {r in
            QuestionViewModel(userRepository: r.resolve(UserRepository.self)!)
        }.inObjectScope(ObjectScope.container)
        
        container.register(DetailViewModel.self) {r in
            DetailViewModel()
        }.inObjectScope(ObjectScope.container)
        
        container.register(FinalDetailViewModel.self) {r in
            FinalDetailViewModel(userRepository: r.resolve(UserRepository.self)!)
        }.inObjectScope(ObjectScope.container)
        
        container.register(HisoryDetailViewModel.self) {r in
            HisoryDetailViewModel(userRepository: r.resolve(UserRepository.self)!)
        }.inObjectScope(ObjectScope.container)
    }
}

