//
//  UIImageView+Extensions.swift
//  TestProject
//
//  Created by iphonovv on 01.10.2020.
//

import UIKit

extension UIImageView {
    
    func loadImageFrom(url: URL?) {
        
        let indicator = UIActivityIndicatorView(frame: self.frame)
        indicator.startAnimating()
        
        self.addSubview(indicator)
        
        self.sd_setImage(with: url, completed: { _,_,_,_  in
            indicator.removeFromSuperview()
        })
    }
}
