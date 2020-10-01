//
//  BaseCell.swift
//  TestProject
//
//  Created by iphonovv on 30.09.2020.
//

import UIKit

open class BaseCell<Model, Events>: UITableViewCell, AnyCellType {
    
    //MARK: -
    //MARK: Accesors
    
    var eventHandler: EventHandler<Events>?
    
    //MARK: -
    //MARK: View Lifycycle
    
    override open func awakeFromNib() {
        super.awakeFromNib()

        self.configure()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    open override func prepareForReuse() {
        self.eventHandler = nil
        
        super.prepareForReuse()
    }

    open func configure() {

    }
    
    //MARK: -
    //MARK: AnyCellType
    
    func fill(with model: Any, eventHandler: EventHandler<Any>?) {
        if let value = model as? Model {
            self.eventHandler = {
                eventHandler?($0)
            }

            self.fill(with: value)
        }
    }
    
    open func fill(with model: Model) {
//        fatalError("Abstract method used for child classes")
    }
}

