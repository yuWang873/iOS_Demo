//
//  Polylibe.swift
//  ibi_demo
//
//  Created by WY on 2021/6/26.
//

import Foundation

struct Polyline: Decodable {
    var polyline: [Coordinates]
}

struct Coordinates: Decodable {
    var coords: [Double]
}
