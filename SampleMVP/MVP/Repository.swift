//
//  Repository.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/18.
//

import Foundation

struct Repository: Codable {
    let fullName: String
    var urlStr: String {
        return "https://github.com/\(fullName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}

