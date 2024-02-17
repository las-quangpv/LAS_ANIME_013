//
//  AnimeDraw.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 08/11/2023.
//

import Foundation
struct AnimeDraw {
    var id: Int
    var image: String
    var count: Int
    var currentIndex: Int
}

//class AnimeDrawParser {
//    
//    static func parseAnimeDraw(from strings: [String]) -> [AnimeDrawModel] {
//        return strings.compactMap { str-> AnimeDrawModel? in
//            let components = str.split(separator: ":").map(String.init)
//            guard components.count == 2,
//                  let count = Int(components[1]) else {
//                print("Invalid category string: \(str)")
//                return nil
//            }
//            let image = components[0]
//            
//            return AnimeDrawModel(image: image, count: count, currentIndex: 0)
//        }
//    }
//}
