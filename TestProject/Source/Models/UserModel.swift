//
//  UserModel.swift
//  TestProject
//
//  Created by iphonovv on 28.09.2020.
//

import Foundation

enum UserType: String, Codable {
    case org = "Organization"
    case user = "User"
}

struct UsersModel: Codable {
    var total_count: Int
    var incomplete_results: Bool
    var items: [UserModel]
}

struct UserModel: Codable {
    
    var id: Int
    var login: String?
    var avatar_url: String?
    var repos_url: String?
    var type: UserType?
}
