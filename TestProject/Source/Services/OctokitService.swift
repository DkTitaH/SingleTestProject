//
//  OctokitService.swift
//  TestProject
//
//  Created by iphonovv on 01.10.2020.
//

import Octokit

class OctokitService {
    
    static var token = TokenConfiguration("6b7177978319f1d05dddce378a5198908932abc2", url: "https://api.github.com")
    
    static var current: Octokit {
        return Octokit(self.token)
    }
}
