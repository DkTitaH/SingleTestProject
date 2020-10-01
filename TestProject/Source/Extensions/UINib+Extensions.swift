//
//  UINib+Extensions.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import UIKit

extension UINib {
    
    public convenience init(_ viewClass: AnyClass, bundle: Bundle? = nil) {
        self.init(nibName: toString(viewClass), bundle: bundle)
    }
}
