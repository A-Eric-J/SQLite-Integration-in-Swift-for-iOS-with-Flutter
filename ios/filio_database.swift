import Foundation
import SQLite

class FilioDatabase {
    static let shared = FilioDatabase()
    private var db: Connection?

    private let exampleTable = Table("filio_table")
    private let id = Expression<Int64>("id")
    private let counter = Expression<Int>("counter")

    private init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/filio.db")
            try db?.run(exampleTable.create { t in
                t.column(id, primaryKey: true)
                t.column(counter)
            })
        } catch {
            print("Unable to create/open database")
        }
    }
}
