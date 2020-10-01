//
//  APIService.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import Foundation

enum ArtistsCountry: String, CaseIterable {
    case ukraine
    case spain
    case israel
}

enum APIMethods: String {
    case search = "search/"
    case users = "users/"
}

enum SearchType: String {
    case users = "users?"
}

enum UserDataType: String {
    case repos = "/repos"
}
//ttps://api.github.com/users/q/repos

class URLBuilder {
    
    let apiUrl = "https://api.github.com/"
    
    func search(query: String, page: Int, type: SearchType) -> URL? {
        let stringValue = self.apiUrl + APIMethods.search.rawValue + type.rawValue +  "q=\(query)&page=\(page)&per_page=15"

        return URL(string: stringValue)
    }
    
    func reposUser(login: String) -> URL? {
        let stringValue = self.apiUrl + APIMethods.users.rawValue + login + UserDataType.repos.rawValue

        return URL(string: stringValue)
    }
}

class APIService: RequestService {
    
    @discardableResult
    func repos(
        user: UserModel,
        completion: @escaping (Result<[RepoModel], Error>) -> ()
    )
        -> URLSessionDataTask?
    {
        let login = user.login ?? ""
        if let url = self.urlBuilder.reposUser(login: login) {
            return self.getData(url: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(data):
                        let parser = Parser<[RepoModel]>()
                        completion(parser.object(from: data))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            }
        }
        
        return nil
    }
    
    @discardableResult
    func searchUser(
        query: String,
        page: Int,
        completion: @escaping (Result<UsersModel, Error>) -> ()
    )
        -> URLSessionDataTask?
    {
        if let url = self.urlBuilder.search(query: query, page: page, type: .users) {
            return self.getData(url: url) { result in
                switch result {
                case let .success(data):
                    let parser = Parser<UsersModel>()
                    completion(parser.object(from: data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        
        return nil
    }
}
