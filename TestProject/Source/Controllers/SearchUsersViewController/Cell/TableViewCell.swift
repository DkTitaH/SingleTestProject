//
//  TableViewCell.swift
//  TestProject
//
//  Created by iphonovv on 28.09.2020.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet var avatarImageView: UIImageView?
    @IBOutlet var loginLabel: UILabel?
    @IBOutlet var typeLabel: UILabel?
    @IBOutlet var stackView: UIStackView?
    
    func fill(model: UserModel) {
        self.avatarImageView?.sd_setImage(with: URL(string: model.avatar_url ?? ""))
        self.loginLabel?.text = "Login: \(model.login ?? "")"
        self.typeLabel?.text = "Type: \(model.type?.rawValue ?? "")"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarImageView?.image = nil
    }
}
