//
//  Section.swift
//  TestProject
//
//  Created by iphonovv on 30.09.2020.
//

import UIKit

public struct SectionHeaderAdapter {
    
    let view: UIView?
    let height: CGFloat
    
    static func create(color: UIColor, height: CGFloat) -> SectionHeaderAdapter {
        let view = UIView()
        view.backgroundColor = color

        return SectionHeaderAdapter(view: view, height: height)
    }
}

public struct Section {
    
    //MARK: -
    //MARK: Accesors
    
    let cell: AnyCellType.Type
    let header: SectionHeaderAdapter?
    var models: [Any]
    let eventHandler: ((Any) -> ())?
    let isEditing: Bool
    
    //MARK: -
    //MARK: Initializations
    
    //TO-DO: Wrap event handler into WeakBox
     init<Cell, Model, EventsType>(
        cell: Cell.Type,
        models: [Model],
        eventHandler: EventHandler<EventsType>? = nil,
        header: SectionHeaderAdapter? = nil,
        isEditing: Bool = false
    )
        where Cell: BaseCell<Model, EventsType>
    {
        self.cell = cell
        self.models = models
        self.header = header
        self.isEditing = isEditing
        self.eventHandler = {
            if let event = $0 as? EventsType {
                eventHandler?(event)
            }
        }
    }

    init<Cell, Model, EventsType>(
        cell: Cell.Type,
        model: Model,
        eventHandler: EventHandler<EventsType>? = nil,
        header: SectionHeaderAdapter? = nil,
        isEditing: Bool = false
    )
        where Cell: BaseCell<Model, EventsType>
    {
        self.init(cell: cell,
                  models: [model],
                  eventHandler: eventHandler,
                  header: header,
                  isEditing: isEditing)
    }
}


protocol AnyCellType: UITableViewCell {
    
    func fill(with model: Any, eventHandler: EventHandler<Any>?)
}
