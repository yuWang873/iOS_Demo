//
//  Annotation.swift
//  ibi_demo
//
//  Created by WY on 2021/6/25.
//

import Foundation

struct Annotation:  Identifiable, Decodable{
    var id = UUID()
    var lat: Double
    var lon: Double
    var name: String
    var description: String?
    var color: String
    
    private enum CodingKeys: CodingKey{
        case lat
        case lon
        case name
        case description
        case color
        
    }

}
