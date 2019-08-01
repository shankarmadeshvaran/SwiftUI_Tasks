
import SwiftUI
import Combine

class ToDoStore: ObservableObject {    
    
    @Published
    var toDOData: [ToDo] = [
        ToDo(title: "Learning about Lists and add Section header to it in SwiftUI", due: Date.from(hour: 10,minutes: 30, year: 2019, month: 08, day: 2)!, isNotify: true),
        ToDo(title: "Learning how to work with State and Object binding in SwiftUI ", due: Date.from(hour: 8,minutes: 30,year: 2019, month: 08, day: 1)!, isNotify: true),
        ToDo(title: "Learning how to work with Alerts and TextField in SwiftUI", due: Date.from(hour: 10,minutes: 00,year: 2019, month: 07, day: 31)!, isNotify: true),
        ToDo(title: "Learning how to move rows in a list in SwiftUI", due: Date.from(hour: 4,minutes: 30,year: 2019, month: 08, day: 3)!,isNotify: true),
        ToDo(title: "Learning how to work with CoreData in SwiftUI", due: Date.from(hour: 5,minutes: 00,year: 2019, month: 08, day: 1)!, isNotify: true),
        ToDo(title: "Learning how to Delete Rows by swiping in SwiftUI", due: Date.from(hour: 1,minutes: 30,year: 2019, month: 08, day: 1)!, isNotify: true),
        ]
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func CompleteTask(_ task: ToDo?) {
         guard let task = task else { return }
        if self.toDOData.contains(task) {
            self.toDOData = self.toDOData.filter { $0 != task }
        }
    }
    
    func toggleNotifySetting(_ task: ToDo?) {
        guard let index = getElementPosition(task) else { return }
        if self.toDOData[index].isNotify == true {
            self.toDOData[index].isNotify.toggle()
            self.appDelegate?.scheduleNotification(notificationType: self.toDOData[index])
        } else {
            self.toDOData[index].isNotify.toggle()
        }
    }
    
    func getElementPosition(_ task: ToDo?) -> Int? {
        let index = self.toDOData.firstIndex(where: { (item) -> Bool in
          item == task
        })
        return index
    }
}
