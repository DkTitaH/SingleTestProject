//
//  Navigatable.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import UIKit

protocol Navigatable {
    func push(controller: UIViewController)
}

extension Navigatable where Self: UINavigationController {
    
    func push(controller: UIViewController) {
        self.pushViewController(controller, animated: true)
    }
    
    func pushOnTopViewController(controller: UIViewController) {
        self.topViewController?.navigationController?.pushViewController(controller, animated: true)        
    }
}
