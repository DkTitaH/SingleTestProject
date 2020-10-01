//
//  AppDelegate.swift
//  TestProject
//
//  Created by iphonovv on 28.09.2020.
//

import UIKit
import Octokit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var config: OAuthConfiguration?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let conf = TokenConfiguration("6b7177978319f1d05dddce378a5198908932abc2", url: "https://api.github.com")

        self.loadCurrentUser(config: conf)
        
        let urlBuilder = URLBuilder()
        let requestService = APIService(session: .shared, urlBuilder: urlBuilder)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = AppCoordinator(
            requestService: requestService,
            isHiddenNavigationBar: true
        )
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }

    func loadCurrentUser(config: TokenConfiguration) {
      Octokit(config).me() { response in
        switch response {
        case .success(let user):
          print(user.login)
        case .failure(let error):
          print(error)
        }
      }
    }
}
