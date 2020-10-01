//
//  UserInfoTableViewCell.swift
//  TestProject
//
//  Created by iphonovv on 30.09.2020.
//

import UIKit
import Octokit

struct UserInfoTableViewCellModel {
    let user: User
}

enum UserInfoTableViewCellEvent {
    
}

class UserInfoTableViewCell: BaseCell<UserInfoTableViewCellModel,UserInfoTableViewCellEvent> {

    @IBOutlet var avatarImageView: UIImageView?
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var loginLabel: UILabel?
    @IBOutlet var createdAtLabel: UILabel?
    @IBOutlet var locationLabel: UILabel?
    
    
    override func fill(with model: UserInfoTableViewCellModel) {
        let url = URL(string: model.user.avatarURL ?? "")
        
        self.avatarImageView?.loadImageFrom(url: url)
        self.nameLabel?.text = model.user.login
        self.loginLabel?.text = model.user.login
        self.locationLabel?.text = model.user.location
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        self.createdAtLabel?.text = formatter.date(from: model.user.createdAt ?? "")?.description
    }
}
