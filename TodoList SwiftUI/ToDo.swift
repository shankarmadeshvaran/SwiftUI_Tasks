
import SwiftUI

struct ToDo: Codable,Hashable {
    var title: String
    var due: Date
    var isNotify: Bool
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
//    @NSManaged var title: String
//    @NSManaged var due: Date
//    @NSManaged var isNotify: Bool
//
//    static func create(description: String, dueDate: Date, in context: NSManagedObjectContext) {
//        let newTodo = ToDo(context: context)
//        newTodo.title = description
//        newTodo.due = dueDate
//        newTodo.isNotify = false
//    }
//}

