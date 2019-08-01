


import SwiftUI

struct ToDo: Codable,Hashable {
    var title: String
    var due: Date
}

//import CoreData
//import SwiftUI
//
//public class ToDo: NSManagedObject {}
//
//extension ToDo {
//    public class func fetchRequest() -> NSFetchRequest<ToDo> {
//        return NSFetchRequest<ToDo>(entityName: "ToDo")
//    }
//
//    @NSManaged var description: String
//    @NSManaged var due: Date
//
//    static func create(description: String, in context: NSManagedObjectContext) {
//        let newTodo = ToDo(context: context)
//        newTodo.description = description
//        newTodo.due = Date()
//    }
//}

