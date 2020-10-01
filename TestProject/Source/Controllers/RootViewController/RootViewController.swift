//
//  RootViewController.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import UIKit

class RootViewController<Events: Event>: UIViewController {

    let requestService: APIService
    let eventHandler: EventHandler<Events>
    
    init(
        requestService: APIService,
        eventHandler: @escaping EventHandler<Events>
    ) {
        self.requestService = requestService
        self.eventHandler = eventHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}
