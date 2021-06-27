//
//  JsonDecode.swift
//  ibi_demo
//
//  Created by WY on 2021/6/25.
//

import Foundation
import MapKit

struct Markers: Decodable{
    var markers: [Annotation]?
    
    enum CodingKeys: String, CodingKey {
        case markers = "markers"
    }

}


 

