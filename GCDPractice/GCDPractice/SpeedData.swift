//
//  SpeedData.swift
//  GCDPractice
//
//  Created by Savannah Su on 2020/1/14.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import Foundation

struct SpeedData: Codable {
    let result: Result
}

struct Result: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let sort: String
    let results: [Results]
}

struct Results: Codable {
    let functions: String
    let area: String
    let no: String
    let direction: String
    let speedLimit: String
    let id: Int
    let road: String
    
    enum CodingKeys: String, CodingKey {
      case id = "_id"
      case speedLimit = "speed_limit"
      case functions, area, no, direction, road
    }
}
