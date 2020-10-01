//
//  Parser.swift
//  TestProject
//
//  Created by iphonovv on 29.09.2020.
//

import Foundation

enum ParserErrors: Error {
    case dataError
}

class Parser<Object: Decodable> {
    
    func object(from data: Data?) -> Result<Object, Error> {
        return data
            .flatMap {
                try? JSONDecoder().decode(Object.self, from: $0)
            }
            .map {
                .success($0)
            }
            ?? .failure(ParserErrors.dataError)
    }
}
