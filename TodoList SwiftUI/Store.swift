

import SwiftUI
import Combine

class Store: BindableObject {
    let willChange = PassthroughSubject<Void,Never>()
    
    var toDOData: [ToDo] = [
        ToDo(title: "Learning about Lists and add Section header to it in SwiftUI", due: "Today"),
        ToDo(title: "Learning how to work with State and Object binding in SwiftUI ", due: "Yesterday"),
        ToDo(title: "Learning how to work with Alerts and TextField in SwiftUI", due: "Today"),
        ToDo(title: "Learning how to move rows in a list in SwiftUI", due: "Yesterday"),
        ToDo(title: "Learning how to Delete Rows by swiping in SwiftUI", due: "Today"),
        ] {
        willSet { update() }
    }
    
    func update() {
        willChange.send(())
    }
}
