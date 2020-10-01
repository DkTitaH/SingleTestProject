//
//  UserDetailViewController.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import UIKit
import Octokit
import RequestKit

enum UserDetailViewControllerEvent: Event {

}

class UserDetailViewController: RootViewController<UserDetailViewControllerEvent> {
    
    @IBOutlet var tableView: UITableView?
    
    private let user: UserModel
    private var tableAdapter: TableAdapter?
    
    private var indicator: UIActivityIndicatorView?
    
    init(user: UserModel, requestService: APIService, eventHandler: @escaping EventHandler<UserDetailViewControllerEvent>) {
        self.user = user
        
        super.init(requestService: requestService, eventHandler: eventHandler)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 200, height: 200))
        
        let iosVersion = NSString(string: UIDevice.current.systemVersion).doubleValue
        
        if iosVersion >= 13 {
            activityIndicator.color = UIColor(named: "BlackAndWhite")
        } else {
            activityIndicator.style = .gray
        }
        activityIndicator.startAnimating()
        
        self.view?.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo((self.view.frame.height - 260) / 1.5)
        }
        
        self.indicator = activityIndicator
        
        self.configureTableView(self.tableView)
        
        let _ = OctokitService.current.user(name: self.user.login ?? "", completion: { [weak self] response in
            DispatchQueue.main.async {
                switch response {
                  case .success(let user):
                    if let section = self?.section(user: user) {
                        self?.tableAdapter?.sections = [section]
                    }
                  case .failure(let error):
                    print(error)
                }
            }
        })
        
        let _ = OctokitService.current.repositories(URLSession.shared, owner: self.user.login, page: "1", perPage: "20", completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(repos):
                    if let section = self?.section(models: repos) {
                        self?.tableAdapter?.sections.append(section)
                        self?.tableAdapter?.reload()
                        self?.indicator?.removeFromSuperview()
                    }
                case let .failure(error):
                    print(error)
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.indicator?.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func section(user: User) -> Section {
        let model = UserInfoTableViewCellModel(user: user)
        
        return Section(cell: UserInfoTableViewCell.self, models: [model])
    }
    
    private func section(models: [Repository]) -> Section {
        var height: CGFloat = 200
        
        if let cell = self.tableView?.cellForRow(at: .init(row: 0, section: 0)) as? UserInfoTableViewCell {
            height = (self.tableView?.frame.height ?? 0) - cell.frame.height
        }
                        
        let model = UserRepoTableViewCellModel(
            models: models,
            height: height
        )
        
        return Section(cell: UserRepoTableViewCell.self, models: [model])
    }
}

extension UserDetailViewController {
    public func configureTableView(_ tableView: UITableView?) {
        let cellTypes = self.allCellTypes()
        
        self.tableAdapter = TableAdapter(table: tableView, cells: cellTypes)
        self.tableAdapter?.sections = []
    }
    
    // MARK: - Private API
    
    private func allCellTypes() -> [UITableViewCell.Type] {
        return [UserInfoTableViewCell.self, UserRepoTableViewCell.self]
    }
}
