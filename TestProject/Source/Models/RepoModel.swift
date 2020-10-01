//
//  RepoModel.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import Foundation

struct RepoModel: Codable {
    
    var id: Int
    var name: String?
    var stargazers_count: Int?
    var language: String?
    var updated_at: String?
}
