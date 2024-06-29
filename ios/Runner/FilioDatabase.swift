import Foundation
import SQLite

class FilioDatabase {
    static let shared = FilioDatabase()
    private var db: Connection?

    private let filioTable = Table("filio_table")
    private let id = Expression<Int64>("id")
    private let counter = Expression<Int>("counter")

    private init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/filio.db")
            try db?.run(filioTable.create { t in
                t.column(id, primaryKey: true)
                t.column(counter)
            })
        } catch {
            print("Unable to create/open database")
        }
    }
    func incrementCounter() {
        do {
            let insert = filioTable.insert(counter <- 0)
            try db?.run(insert)
            let update = filioTable.update(counter <- counter + 1)
            try db?.run(update)
        } catch {
            print("Failed to increment counter: \(error)")
        }
    }

    func getCurrentCounter() -> Int {
         do {
             if let firstRow = try db?.pluck(filioTable) {
                  return firstRow[counter]
               }
            } catch {
                print("Failed to fetch counter: \(error)")
            }
            return 0
        }
}
