
import SwiftUI
import Foundation
import CoreData

// ToDo code generation is turned OFF in the xcdatamodeld file
public class ToDo: NSManagedObject, Identifiable {
    @NSManaged public var title: String?
    @NSManaged public var due: Date
    @NSManaged public var isNotify: Bool
}

extension ToDo {
    
    static func allToDoFetchRequest() -> NSFetchRequest<ToDo> {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest() as! NSFetchRequest<ToDo>
        
        // The @FetchRequest property wrapper in the ContentView requires a sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
          
        return request
    }
}

