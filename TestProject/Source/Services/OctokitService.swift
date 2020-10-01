//
//  OctokitService.swift
//  TestProject
//
//  Created by iphonovv on 01.10.2020.
//

import Octokit

class OctokitService {
    
    static var token = TokenConfiguration("b8629bb073638535d2c3993e38d4d8227ca6d7cb", url: "https://api.github.com")
    
    static var current: Octokit {
        return Octokit(self.token)
    }
}
