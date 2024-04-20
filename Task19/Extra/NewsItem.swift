//
//  NewsItem.swift
//  Task19
//
//  Created by ana namgaladze on 19.04.24.
//

import UIKit
struct NewsItem: Decodable {
    let title: String
    let time: String
    let url: String
    let type: Int
    let photoUrl: String
    let photoAlt: String
    
    enum CodingKeys: String, CodingKey {
            case title = "Title"
            case time = "Time"
            case url = "Url"
            case type = "Type"
            case photoUrl = "PhotoUrl"
            case photoAlt = "PhotoAlt"
        }
}
struct ResponseData: Decodable {
    let list: [NewsItem]
    enum CodingKeys: String, CodingKey {
          case list = "List"
      }
}





