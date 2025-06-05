import Foundation
import SQLite3

class UserDatabase {
    static let shared = UserDatabase()
    
    private var db: OpaquePointer?
    
    private init() {
        db = openDatabase()
        createTable()
    }
    
    // SQLiteファイルへのパスを取得する関数でゲス！！！
    private func getDBPath() -> String {
        // Documentsディレクトリ配下にUserDatabase.sqliteを配置するでゲス！！！
        let fileUrl = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent("UserDatabase.sqlite")
        
        return fileUrl.path
    }
    
    // データベースを開く関数でゲス！！！
    private func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        if sqlite3_open(getDBPath(), &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(getDBPath())")
            return db
        } else {
            print("Unable to open database！！！")
            return nil
        }
    }
    
    // usersテーブルを作成する関数でゲス！！！
    private func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
        );
        """
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("users table created！！！")
            } else {
                print("users table could not be created！！！")
            }
        } else {
            print("CREATE TABLE statement could not be prepared！！！")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // 新規ユーザー登録
    // 既に同じメールアドレスがあればfalseを返すでゲス！！！
    func registerUser(email: String, password: String) -> Bool {
        // まず既存ユーザーかチェックするでゲス！！！
        let selectQuery = "SELECT * FROM users WHERE email = ?"
        var selectStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(selectStatement, 1, NSString(string: email).utf8String, -1, nil)
            
            // 既に同じメールアドレスがあればreturn false
            if sqlite3_step(selectStatement) == SQLITE_ROW {
                sqlite3_finalize(selectStatement)
                return false
            }
        }
        sqlite3_finalize(selectStatement)
        
        // ユーザーをINSERTするでゲス！！！
        let insertQuery = "INSERT INTO users (email, password) VALUES (?, ?)"
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, NSString(string: email).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, NSString(string: password).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row！！！")
                sqlite3_finalize(insertStatement)
                return true
            } else {
                print("Could not insert row！！！")
            }
        } else {
            print("INSERT statement could not be prepared！！！")
        }
        
        sqlite3_finalize(insertStatement)
        return false
    }
    
    // ログイン検証
    // 成功すればtrueを返すでゲス！！！
    func loginUser(email: String, password: String) -> Bool {
        let query = "SELECT password FROM users WHERE email = ?"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, NSString(string: email).utf8String, -1, nil)
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                if let cString = sqlite3_column_text(queryStatement, 0) {
                    let storedPassword = String(cString: cString)
                    sqlite3_finalize(queryStatement)
                    // パスワードが一致するか確認
                    return (storedPassword == password)
                }
            }
        }
        
        sqlite3_finalize(queryStatement)
        return false
    }
}
