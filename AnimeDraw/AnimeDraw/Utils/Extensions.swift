//
//  Extensions.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 28/11/2023.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
