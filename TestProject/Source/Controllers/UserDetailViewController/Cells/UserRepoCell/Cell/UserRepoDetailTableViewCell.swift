//
//  UserRepoDetailTableViewCell.swift
//  TestProject
//
//  Created by iphonovv on 30.09.2020.
//

import UIKit
import SnapKit

class UserRepoDetailTableViewCellModel {
    let model: RepoModel
    var isShowMore: Bool = false
    
    init(model: RepoModel) {
        self.model = model
    }
}

enum UserRepoDetailTableViewCellEvent {
    case showMore
}

class UserRepoDetailTableViewCell: BaseCell<UserRepoDetailTableViewCellModel, UserRepoDetailTableViewCellEvent> {
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var starsCountLabel: UILabel?
    @IBOutlet var languageLabel: UILabel?
    @IBOutlet var updatedAtLabel: UILabel?
    @IBOutlet var updatedAtView: UIView?
    @IBOutlet var starsView: UIView?
    @IBOutlet var showMoreButton: UIButton!
    
    private var showMoreEvent: (() -> ())?
    
    override func configure() {
        self.showMoreButton.layer.borderWidth = 1
        self.showMoreButton.layer.borderColor = UIColor(named: "BlackAndWhite")?.cgColor
    }
    
    override func fill(with model: UserRepoDetailTableViewCellModel) {
        self.setMoreInfoVisible(bool: model.isShowMore)
        
        self.showMoreEvent = { [weak model, weak self] in
            let bool = !(model?.isShowMore ?? false)
            model?.isShowMore = bool
                        
            self?.setMoreInfoVisible(bool: bool)
            self?.eventHandler?(.showMore)
        }
        
        self.nameLabel?.text = model.model.name
        self.languageLabel?.text = model.model.language
        self.starsCountLabel?.text = model.model.stargazers_count?.description
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.date(from: model.model.updated_at ?? "")
        
        self.updatedAtLabel?.text = formatter.date(from: model.model.updated_at ?? "")?.description
    }
    
    private func setMoreInfoVisible(bool: Bool) {
        [self.starsView,self.updatedAtView].forEach {
            $0?.isHidden = !bool
            
            let text = !bool ? "Show More" : "Hide"
            
            self.showMoreButton.setTitle(text, for: .normal)
        }
    }
    
    @IBAction func showMoreAction(_ sender: Any) {
        self.showMoreEvent?()
    }
}
