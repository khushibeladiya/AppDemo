////
////  DataBaseHelper.swift
////  StudentDemo
////
////  Created by Netra Technosys on 12/02/21.
////
//
//import Foundation
//import SQLite3
//
//class DBHelper{
//    
//    init(){
//        db = openDatabase()
//        createTable()
//    }
//
//    let dbPath: String = "studentdemo.db"
//    var db:OpaquePointer?
//
//    func openDatabase() -> OpaquePointer?{
//        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
//        print(fileURL)
//        self.db = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
//            print("error opening database")
//            return nil
//        }else{
//            print("Successfully opened connection to database at \(dbPath)")
//            return db
//        }
//    }
//    
//    func createTable() {
//    let createTableString = "CREATE TABLE IF NOT EXISTS students(id TEXT,name TEXT,email TEXT,password TEXT,number   TEXT,city TEXT,gender TEXT,image TEXT);"
//    
//        var createTableStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
//        {
//            if sqlite3_step(createTableStatement) == SQLITE_DONE
//            {
//                print("person table created.")
//            } else {
//                print("person table could not be created.")
//            }
//        } else {
//            print("CREATE TABLE statement could not be prepared.")
//        }
//        sqlite3_finalize(createTableStatement)
//    }
//    
//    func insert(id:String, name:String,email: String,password: String,number: String ,city: String,gender: String,image: String){
//        let strudents = read()
//        for s in strudents
//        {
//            if s.id == id
//            {
//                return
//            }
//        }
//        var insertStatement: OpaquePointer? = nil
//        let insertStatementString = "INSERT INTO students(id, name, email,password,number,city,gender,image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
//        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 3, (email as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 4, (password as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 5, (number as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 6, (city as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 7, (gender as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 8, (image as NSString).utf8String, -1, nil)
//            
//            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("Successfully inserted row.")
//            } else {
//                print("Could not insert row.")
//            }
//        } else {
//            print("INSERT statement could not be prepared.")
//        }
//        sqlite3_finalize(insertStatement)
//        db = closeDataBase()
//    }
//    
//    func read() -> [Student] {
//        let queryStatementString = "SELECT * FROM students;"
//        var queryStatement: OpaquePointer? = nil
//        var stud : [Student] = []
//        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
//                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
//                let password = String(describing: String(cString: sqlite3_column_text(queryStatement,3)))
//                let number = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
//                let city = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
//                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement,6)))
//                let image = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
//                
//                stud.append(Student(id: id, name: name, email: email, password: password, number: number, city: city, gender: gender, image: image))
//                print("Query Result:")
////                print("\(id) | \(name) | \(year)")
//                
//            }
//        } else {
//            print("SELECT statement could not be prepared")
//        }
//        sqlite3_finalize(queryStatement)
//        return stud
//    }
//    
//    func deleteByID(id:Int) {
//        let deleteStatementStirng = "DELETE FROM person WHERE id = ?;"
//        var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(deleteStatement, 1, Int32(id))
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//    }
//    
//    func closeDataBase() -> OpaquePointer? {
//        if sqlite3_close(db) != SQLITE_OK {
//           return nil
//            print("error closing database")
//        }else{
//            return db
//            
//        }
//        db = nil
//    }
//}
