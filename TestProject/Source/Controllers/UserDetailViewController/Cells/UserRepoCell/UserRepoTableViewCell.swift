//
//  UserRepoTableViewCell.swift
//  TestProject
//
//  Created by iphonovv on 30.09.2020.
//

import UIKit
import Octokit

struct UserRepoTableViewCellModel {
    let models: [Repository]
    let height: CGFloat
}

enum UserRepoTableViewCellEvent {
    
}

class UserRepoTableViewCell: BaseCell<UserRepoTableViewCellModel, UserRepoTableViewCellEvent> {

    @IBOutlet var height: NSLayoutConstraint?
    @IBOutlet var tableView: UITableView?
    
    private var models: [RepoModel] = []
    
    private var tableAdapter: TableAdapter?
    
    override func fill(with model: UserRepoTableViewCellModel) {
        self.configureTableView(self.tableView)
        self.tableAdapter?.sections = [self.section(models: model.models)]
        self.height?.constant = model.height
    }
    
    private func section(models: [Repository]) -> Section {
        let cellModels = models.map { UserRepoDetailTableViewCellModel(model: $0) }
        
        return Section(cell: UserRepoDetailTableViewCell.self, models: cellModels, eventHandler: { [weak self] event in
            self?.handle(event: event)
        })
    }
    
    private func handle(event: UserRepoDetailTableViewCellEvent) {
        switch event {
        case .showMore:
            self.tableView?.reloadData()
        }
    }
}

extension UserRepoTableViewCell {
    public func configureTableView(_ tableView: UITableView?) {
        let cellTypes = self.allCellTypes()
        
        self.tableAdapter = TableAdapter(table: tableView, cells: cellTypes)
        self.tableAdapter?.sections = []
    }
    
    // MARK: - Private API
    
    private func allCellTypes() -> [UITableViewCell.Type] {
        return [UserRepoDetailTableViewCell.self]
    }
}
