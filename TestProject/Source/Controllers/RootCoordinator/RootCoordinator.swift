//
//  RootCoordinator.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import UIKit

class RootCoordanator<CoordinatorEnent: Event>: UINavigationController, Navigatable {

    var eventHandler: ((CoordinatorEnent) -> ())?
    var isHiddenNavigatioBar: Bool
    
    init(isHiddenNavigatioBar: Bool) {
        self.isHiddenNavigatioBar = isHiddenNavigatioBar
        super.init(nibName: nil, bundle: nil)
        
        self.navigationBar.isHidden = self.isHiddenNavigatioBar

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.start()
    }
    
    func start() {
        
    }
}
