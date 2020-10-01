//
//  Functions.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import Foundation

typealias EventHandler<Event> = (Event) -> ()

func toString(_ class: AnyClass) -> String {
    return String(describing: `class`)
}

public func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}
