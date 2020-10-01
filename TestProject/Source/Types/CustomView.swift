//
//  CustomView.swift
//  TestProject
//
//  Created by iphonovv on 01.10.2020.
//

import UIKit

protocol CustomViewType: UIView {

    var contentView: UIView? { get }
}

class CustomView: UIView, CustomViewType {

    @IBOutlet var contentView: UIView?

    init() {
        super.init(frame: .zero)
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("\(Self.self)", owner: self, options: nil)

        self.contentView.map { contentView in
            self.addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight ,.flexibleWidth]
        }
    }
}
