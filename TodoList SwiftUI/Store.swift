

import SwiftUI
import Combine

class Store: BindableObject {
    let willChange = PassthroughSubject<Void,Never>()
    
    var toDOData: [ToDo] = [
        ToDo(title: "Learning about Lists and add Section header to it in SwiftUI", due: Date.from(year: 2019, month: 07, day: 25)!),
        ToDo(title: "Learning how to work with State and Object binding in SwiftUI ", due: Date.from(year: 2019, month: 07, day: 24)!),
        ToDo(title: "Learning how to work with Alerts and TextField in SwiftUI", due: Date.from(year: 2019, month: 07, day: 25)!),
        ToDo(title: "Learning how to move rows in a list in SwiftUI", due: Date.from(year: 2019, month: 07, day: 24)!),
        ToDo(title: "Learning how to work with CoreData in SwiftUI", due: Date.from(year: 2019, month: 07, day: 26)!),
        ToDo(title: "Learning how to Delete Rows by swiping in SwiftUI", due: Date.from(year: 2019, month: 07, day: 24)!),
        ] {
        willSet { update() }
    }
    
    func CompleteTask(_ task: ToDo?) {
         guard let task = task else { return }
        if self.toDOData.contains(task) {
            self.toDOData = self.toDOData.filter { $0 != task }
        }
    }
    
    func update() {
        willChange.send(())
    }

}
