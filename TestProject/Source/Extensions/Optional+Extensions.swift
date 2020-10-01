//
//  Optional+Extensions.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import Foundation

extension Optional {

    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
}
