//
//  OctokitService.swift
//  TestProject
//
//  Created by iphonovv on 01.10.2020.
//

import Octokit

class OctokitService {
    
    static var token = TokenConfiguration("f492505e3a8621fcf8f648239cfaa1374fb08bff", url: "https://api.github.com")
    
    static var current: Octokit {
        return Octokit(self.token)
    }
}
