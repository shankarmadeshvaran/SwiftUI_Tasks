

import SwiftUI
import CoreData

struct HomeTasksView: View {
    // Core Data property wrappers
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // The ToDo class has an `allToDoFetchRequest` function that can be used here
    @FetchRequest(fetchRequest: ToDo.allToDoFetchRequest()) var toDos: FetchedResults<ToDo>
    @State var selectedTask: ToDo? = nil
    
    @State var showingSheet: Bool = false
    @State var selectedDate = Date()
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var presentSheet: ActionSheet {
        ActionSheet(
            title: Text("Todo Actions"),
            message: nil,
            buttons: [
                CompleteButton,
                NotifyButton,
                ActionSheet.Button.cancel({
                    self.showingSheet.toggle()
                })])
    }
    
    var CompleteButton: ActionSheet.Button {
        ActionSheet.Button.default(Text("Mark as Complete")) {
            self.completeTask(task: self.selectedTask)
            self.showingSheet.toggle()
        }
    }
    
    var NotifyButton: ActionSheet.Button {
        ActionSheet.Button.default(Text(self.selectedTask?.isNotify == false ? "Enable Notification" : "Disable Notification")) {
            self.toggleNotifySettings(task: self.selectedTask)
            self.showingSheet.toggle()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: AddNewToDoTaskHeaderView().environment(\.managedObjectContext, self.managedObjectContext)) {
                    ForEach(self.toDos) { todo in
                        Button(action: {
                            self.selectedTask = todo
                            self.showingSheet = true
                        }) {
                            TaskRow(todo: todo ,todayDate: self.selectedDate)
                        }
                        .listRowBackground(self.rowBackgroundColor(dueDate: todo.due))
                    } .onDelete { (indexSet) in
                        let toDoDelete = self.toDos[indexSet.first!]
                        self.managedObjectContext.delete(toDoDelete)
                        try! self.managedObjectContext.save()
                    }
                    .onMove(perform: move)
                }
            }.navigationBarTitle(Text("Tasks").font(.largeTitle))
                .navigationBarItems(trailing: EditButton())
                .edgesIgnoringSafeArea(.bottom)
        }.actionSheet(isPresented: $showingSheet, content: {
            presentSheet
        })
    }
    
    func rowBackgroundColor(dueDate: Date) -> Color {
        return dueDate.isEqual(currentDate: self.selectedDate) ? Color.green : dueDate.isPast(today: self.selectedDate) ? Color.yellow : Color.pink
    }
    
    func move(from sourceIndex: IndexSet, to destination: Int) {
        let toMoveTask = self.toDos[sourceIndex.first!]
        let toDestination = self.toDos[destination]
        print(toMoveTask, toDestination)
        try! self.managedObjectContext.save()
    }
    
    func toggleNotifySettings(task: ToDo?) {
        guard let index = checkTasksAvailable(task: task).first else { return }
        if self.toDos[index].isNotify == false {
            self.appDelegate?.scheduleNotification(notificationType: self.toDos[index])
            self.toDos[index].isNotify.toggle()
            print(self.toDos[index])
        } else {
            self.toDos[index].isNotify.toggle()
            print(self.toDos[index])
        }
       try! self.managedObjectContext.save()
    }
    
    func completeTask(task: ToDo?) {
        guard let task = task else { return }
        let indexes = self.toDos.indexes(of: task)
        let toDoDelete = self.toDos[indexes.first!]
        self.managedObjectContext.delete(toDoDelete)
        try! self.managedObjectContext.save()
    }
    
    func checkTasksAvailable(task: ToDo?) -> [Int] {
        guard let task = task else { return [] }
        return self.toDos.indexes(of: task)
    }
    
    func returnTodoByDate(dateString: String) -> ToDo? {
        let toDoArr = self.toDos.filter { "\($0.due)" == "\(dateString)" }
        return toDoArr.first
    }
}

extension FetchedResults where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
