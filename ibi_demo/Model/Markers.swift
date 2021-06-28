//
//  JsonDecode.swift
//  ibi_demo
//
//  Created by WY on 2021/6/25.
//

import Foundation

struct Markers: Decodable{
    let markers: [Annotation]
    
    enum CodingKeys: String, CodingKey {
        case markers = "markers"
    }

}


 

