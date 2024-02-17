//
//  DatabaseManager.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 27/11/2023.
//

import Foundation
import FMDB

class DatabaseManager {
    static let sharedInstance = DatabaseManager()
    var database: FMDatabase?
    
    private init() {
        DatabaseManager.copyFile(fileName: "databaseanime.db")
        database = FMDatabase(path: DatabaseManager.getPath(fileName: "databaseanime.db"))
    }
    
    class func getInstance() -> DatabaseManager {
        return sharedInstance
    }
    
    class func getPath(fileName: String) -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.path
    }
    
    class func copyFile(fileName: String) {
        let dbPath: String = getPath(fileName: fileName)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName)
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error {
                print("Could not copy file: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllAnimeDraws() -> [AnimeDraw] {
        var animeDrawList: [AnimeDraw] = []
        
        // Mở cơ sở dữ liệu
        database?.open()
        
        let query = "SELECT * FROM drawanime"
        if let result = database?.executeQuery(query, withArgumentsIn: []) {
            while result.next() {
                let id = Int(result.int(forColumn: "id"))
                let image = result.string(forColumn: "image") ?? ""
                let count = Int(result.int(forColumn: "count"))
                let currentIndex = Int(result.int(forColumn: "current_index"))
                
                let animeDraw = AnimeDraw(id: id, image: image, count: count, currentIndex: currentIndex)
                animeDrawList.append(animeDraw)
            }
        } else {
            print("Query execution failed.")
        }
        
        // Đóng cơ sở dữ liệu
        database?.close()
        
        return animeDrawList
    }
    
    func updateCurrentIndex(forAnimeDrawID id: Int, newIndex: Int) -> Bool {
        // Mở cơ sở dữ liệu
        database?.open()
        
        let updateQuery = "UPDATE drawanime SET current_index = ? WHERE id = ?"
        let success = database?.executeUpdate(updateQuery, withArgumentsIn: [newIndex, id]) ?? false
        
        if !success {
            print("Update failed.")
        }
        
        // Đóng cơ sở dữ liệu
        database?.close()
        
        return success
    }
    
    func getAnimeDrawByID(id: Int) -> AnimeDraw? {
        // Mở cơ sở dữ liệu
        database?.open()

        let query = "SELECT * FROM drawanime WHERE id = ?"
        if let result = database?.executeQuery(query, withArgumentsIn: [id]) {
            if result.next() {
                let image = result.string(forColumn: "image") ?? ""
                let count = Int(result.int(forColumn: "count"))
                let currentIndex = Int(result.int(forColumn: "current_index"))

                let animeDraw = AnimeDraw(id: id, image: image, count: count, currentIndex: currentIndex)

                // Đóng cơ sở dữ liệu
                database?.close()

                return animeDraw
            }
        } else {
            print("Query execution failed.")
        }

        // Đóng cơ sở dữ liệu
        database?.close()

        return nil // Trả về nil nếu không tìm thấy
    }
    
    func getAllPosters() -> [Poster] {
        var posterList: [Poster] = []
        
        // Mở cơ sở dữ liệu
        database?.open()
        
        let query = "SELECT * FROM poster"
        if let result = database?.executeQuery(query, withArgumentsIn: []) {
            while result.next() {
                let id = Int(result.int(forColumn: "id"))
                let image = result.string(forColumn: "image") ?? ""
                let favourite = result.string(forColumn: "favourite") ?? ""
                
                let poster = Poster(id: id, image: image, favourite: favourite)
                posterList.append(poster)
            }
        } else {
            print("Query execution failed.")
        }
        
        // Đóng cơ sở dữ liệu
        database?.close()
        
        return posterList
    }
    
    func updatePosterFavouriteStatus(forPosterID id: Int, newFavouriteStatus: String) -> Bool {
        // Mở cơ sở dữ liệu
        database?.open()
        
        let updateQuery = "UPDATE poster SET favourite = ? WHERE id = ?"
        let success = database?.executeUpdate(updateQuery, withArgumentsIn: [newFavouriteStatus, id]) ?? false
        
        if !success {
            print("Update failed.")
        }
        
        // Đóng cơ sở dữ liệu
        database?.close()
        
        return success
    }
    
    func getPostersWithFavouriteStatus() -> [Poster] {
        var favouritePosters: [Poster] = []
        
        // Mở cơ sở dữ liệu
        database?.open()
        
        let query = "SELECT * FROM poster WHERE favourite = ?"
        if let result = database?.executeQuery(query, withArgumentsIn: ["1"]) {
            while result.next() {
                let id = Int(result.int(forColumn: "id"))
                let image = result.string(forColumn: "image") ?? ""
                let favourite = result.string(forColumn: "favourite") ?? ""
                
                let poster = Poster(id: id, image: image, favourite: favourite)
                favouritePosters.append(poster)
            }
        } else {
            print("Query execution failed.")
        }
        
        // Đóng cơ sở dữ liệu
        database?.close()
        
        return favouritePosters
    }
    
    func getAllHistoryItems() -> [History] {
        var historyList: [History] = []

        // Mở cơ sở dữ liệu
        database?.open()

        let query = "SELECT * FROM history"
        if let result = database?.executeQuery(query, withArgumentsIn: []) {
            while result.next() {
                let id = Int(result.int(forColumn: "id"))
                let url = result.string(forColumn: "url") ?? ""
                let drawingData = result.string(forColumn: "drawingData") ?? ""
                let anime = Int(result.int(forColumn: "anime"))

                let historyItem = History(id: id, url: url, drawingData: drawingData, anime: anime)
                historyList.append(historyItem)
            }
        } else {
            print("Query execution failed.")
        }

        // Đóng cơ sở dữ liệu
        database?.close()

        return historyList
    }
    
    func insertHistoryItem(url: String, drawingData: String, anime: Int) -> Bool {
        // Mở cơ sở dữ liệu
        database?.open()

        let insertQuery = "INSERT INTO history (url, drawingData, anime) VALUES (?, ?, ?)"
        let success = database?.executeUpdate(insertQuery, withArgumentsIn: [url, drawingData, anime]) ?? false

        if !success {
            print("Insertion failed.")
        }

        // Đóng cơ sở dữ liệu
        database?.close()

        return success
    }
    
    func updateHistoryItem(id: Int, newURL: String, newDrawingData: String) -> Bool {
        // Mở cơ sở dữ liệu
        database?.open()

        let updateQuery = "UPDATE history SET url = ?, drawingData = ? WHERE id = ?"
        let success = database?.executeUpdate(updateQuery, withArgumentsIn: [newURL, newDrawingData, id]) ?? false

        if !success {
            print("Update failed.")
        }

        // Đóng cơ sở dữ liệu
        database?.close()

        return success
    }
}
