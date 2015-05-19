//
//  Database.swift
//  InfoTable
//
//  Created by Mattias Olsson on 2015-05-16.
//  Copyright (c) 2015 MOAN Enterprises. All rights reserved.
//

import UIKit

class Database: NSObject {
    // Members!!
    
    let databaseName = "sqlite3.db"
    var databasePath: String
    
    var documentsPath: AnyObject
    var documentsDir: String
    
    var db: FMDatabase?
    
    var fileManager = NSFileManager.defaultManager()
    
    // Methods!!
    
    func executeQueryAndReturnArrayForColumn(query: String, column: String) -> [String] {
        // öppna db
        var returnArray: [String] = []
        if(self.db!.open()) {
            println("DB öppnad")
            var res: FMResultSet
            res = self.db!.executeQuery(query, withArgumentsInArray: nil)
            
            // fill returnArray
            while(res.next()) {
                returnArray.append(res.stringForColumn(column))
            }
            self.db!.close()
        }
        return returnArray
    }
    
    func executeQueryAndReturnRow(query: String, params: [AnyObject]) -> NSMutableArray {
        var returnArray: NSMutableArray = []
        
        if(self.db!.open()) {
            var res: FMResultSet
            res = self.db!.executeQuery(query, withArgumentsInArray: params)
            
            while (res.next()) {
                returnArray.addObject(res.resultDictionary())
            }
            self.db!.close()
        }
        return returnArray
    }
    
    override init() {
        self.documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        self.documentsDir = self.documentsPath[0] as! String
        // raden nedanför är nog till för om den ska köras på device.
        // self.databasePath = self.documentsDir.stringByAppendingPathComponent(self.databaseName)
        self.databasePath = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent(databaseName)
        self.db = FMDatabase(path: self.databasePath)
        
        if(fileManager.fileExistsAtPath(databasePath)) {
            if(self.db == nil) {
                println(self.db?.lastError())
            }
        }
        
    }
    
    
}
