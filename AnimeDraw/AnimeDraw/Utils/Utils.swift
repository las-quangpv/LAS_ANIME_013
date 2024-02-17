//
//  Utils.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 28/11/2023.
//

import Foundation
import UIKit

struct Utils {
    static func save(image: UIImage) -> String{
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        let fileName = "\(Date().millisecondsSince1970).png"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
           try? imageData.write(to: fileURL, options: .atomic)
           return fileName // ----> Save fileName
        }
        print("Error saving image")
        return ""
    }
    
    static func load(fileName: String) -> UIImage {
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)!
        } catch {
            print("Error loading image : \(error)")
        }
        return UIImage()
    }
}
