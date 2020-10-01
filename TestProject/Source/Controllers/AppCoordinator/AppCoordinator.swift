//
//  AppCoordinator.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import Foundation

enum AppCoordinatorEvent: Event {
    
}

class AppCoordinator: RootCoordanator<AppCoordinatorEvent> {
    
    private let requestService: APIService
    
    init(
        requestService: APIService,
        isHiddenNavigationBar: Bool
    ) {
        self.requestService = requestService
        
        super.init(isHiddenNavigatioBar: isHiddenNavigationBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func start() {
        super.start()
        self.createRootViewController()
    }

    func createRootViewController() {
        let viewController = SearchUsersViewController(
            requestService: self.requestService,
            eventHandler: { event in
                self.handle(event: event)
        })
        
        self.push(controller: viewController)
    }
    
    func handle(event: SearchUsersViewControllerEvent) {
        switch event {
        case let .showUserDetail(model):
            self.createUserDetailViewController(user: model)
        }
    }
    
    func createUserDetailViewController(user: UserModel) {
        let controller = UserDetailViewController(
            user: user,
            requestService: self.requestService,
            eventHandler: { [weak self] event in
                self?.handle(event: event)
            }
        )
        
        self.pushOnTopViewController(controller: controller)
    }
    
    func handle(event: UserDetailViewControllerEvent) {
        switch event {

        }
    }
    
//    func createRootViewController() {
//        let dataSource = PopularArtistsDataSource() { _ in
//
//        }
//        let viewController = PopularArtistsViewController(
//            requestService: self.requestService,
//            dataSource: dataSource,
//            networkService: self.networkService
//        ) { [weak self] in
//            self?.handle(event: $0)
//        }
//
//        self.push(controller: viewController)
//    }
    
//    func handle(event: ArtistDetailViewControllerEvent) {
//        switch event {
//        case let .showAlbumDetailViewController(album):
//            let viewModel = AlbumDetailViewModel(album: album)
//            let albumViewController = AlbumDetailViewController(eventHandler: { _ in
//
//            })
//
//            albumViewController.fill(model: viewModel)
//
//            self.topViewController?.navigationController?.pushViewController(albumViewController, animated: false)
//        }
//    }
}
