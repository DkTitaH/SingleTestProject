//
//  SearchUsersViewController.swift
//  TestProject
//
//  Created by iphonovv on 28.09.2020.
//

import UIKit

enum SearchUsersViewControllerEvent: Event {
    case showUserDetail(UserModel)
}

class SearchUsersViewController: RootViewController<SearchUsersViewControllerEvent>, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet var sortButton: UIButton?
    @IBOutlet var searchTextField: UITextField?
    @IBOutlet var tableView: UITableView?
    
    private var currentSearchTask: URLSessionDataTask? {
        didSet {
            oldValue?.cancel()
        }
    }
    private var previousSearchText = ""
    private var page = 1
    private var isSorted = false
    private var loadedModels = [UserModel]() {
        didSet {
            if self.isSorted {
                self.sortModels()
            } else {
                self.models = self.loadedModels
            }
        }
    }
    
    private var models = [UserModel]() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    private var indicator: UIActivityIndicatorView?
    private var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.separatorColor = UIColor(named: "BlackAndWhite")
        
        self.searchTextField?.layer.borderWidth = 1
        self.searchTextField?.layer.borderColor = UIColor(named: "BlackAndWhite")?.cgColor
        self.searchTextField?.layer.cornerRadius = 6
        
        self.sortButton?.layer.borderWidth = 1
        self.sortButton?.layer.borderColor = UIColor(named: "BlackAndWhite")?.cgColor
        self.sortButton?.layer.cornerRadius = 6
        
        let activityIndicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 200, height: 200))
        activityIndicator.isHidden = true
        self.indicator = activityIndicator
        
        self.view?.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.tableView?.register(TableViewCell.self)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        
        self.searchTextField?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.searchTimer?.invalidate()
    }
    
    private func sortModels() {
        let arr = NSMutableArray(array: self.loadedModels)
        
        let sortedArray = arr.sorted(by: { (a, b) in
            let aVal = (a as? UserModel)?.login ?? ""
            let bVal = (b as? UserModel)?.login ?? ""

            return aVal.localizedCaseInsensitiveCompare(bVal) == ComparisonResult.orderedAscending
        })
        
        self.models = sortedArray.compactMap { $0 as? UserModel }
        self.tableView?.reloadData()
    }
    
    @IBAction func sortByAccountAction(_ sender: Any) {
        self.isSorted = !self.isSorted
        
        if self.isSorted {
            self.sortButton?.backgroundColor = .lightGray
            self.sortModels()
        } else {
            self.sortButton?.backgroundColor = UIColor(named: "WhiteAndBlack")
            self.models = self.loadedModels
            self.tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.loadedModels.count - 1 {
            self.page += 1
//            self.indicator?.isHidden = false
            
            self.loadData(query: self.previousSearchText, page: self.page, isNextPage: true)
        }
        
        return  tableView.reusableCell(TableViewCell.self, for: indexPath, configure: { cell in
            cell.fill(model: self.models[indexPath.row])
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.loadedModels[indexPath.row]
        self.eventHandler(.showUserDetail(model))
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text,
        let textRange = Range(range, in: text) else {
            return true
        }
        let searchText = text.replacingCharacters(in: textRange, with: string)
        
        self.previousSearchText = searchText

        self.loadData(query: searchText, page: self.page)
        
        return true
    }
    
    var isLoading = false
    
    private func loadData(query: String, page: Int, isNextPage: Bool = false) {
        if query == "" {
            self.searchTimer?.invalidate()
            self.currentSearchTask = nil
            self.loadedModels = []
            self.models = []
            self.indicator?.isHidden = true
            
            return
        }
        
        if self.previousSearchText != query {
            self.page = 1
        }
        
        self.indicator?.isHidden = false
        self.isLoading = true
        self.currentSearchTask?.cancel()
        self.searchTimer?.invalidate()
        
        self.indicator?.startAnimating()
        self.searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] (timer) in
            self?.currentSearchTask = self?.requestService.searchUser(
                query: query,
                page: page,
                completion: { [weak self] result in
                    self?.indicator?.isHidden = true
                    switch result {
                    case let .success(model):
                        if isNextPage {
                            self?.loadedModels.append(contentsOf: model.items)
                        } else {
                            self?.loadedModels = model.items
                        }
                        print(model.items.count)
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
            )
        })
    }
}
