
import SwiftUI

struct HomeTasksView : View {
    @ObservedObject var data = ToDoStore()
    @State var selectedTask: ToDo? = nil
    
    @State var showingSheet: Bool = false
    @State var selectedDate = Date()
    
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
            self.data.CompleteTask(self.selectedTask)
            self.showingSheet.toggle()
        }
    }
    
    var NotifyButton: ActionSheet.Button {
        ActionSheet.Button.default(Text(self.selectedTask?.isNotify == true ? "Enable Notification" : "Disable Notification")) {
            self.data.toggleNotifySetting(self.selectedTask)
            self.showingSheet.toggle()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: AddNewToDoTaskHeaderView(toDoStore: self.data)) {
                    ForEach(self.data.toDOData, id: \.title) { todo in
                        Button(action: {
                            self.selectedTask = todo
                            self.showingSheet = true
                        }) {
                            TaskRow(todo: todo ,todayDate: self.selectedDate)
                        }
                        .listRowBackground(todo.due.isEqual(currentDate: self.selectedDate) ? Color.green : todo.due.isPast(today: self.selectedDate) ? Color.yellow : Color.pink)
                    } .onDelete(perform: removeExistingToDoAction)
                        .onMove(perform: move)
                }
            }.navigationBarTitle(Text("Tasks").font(.largeTitle))
                .navigationBarItems(trailing: EditButton())
                .edgesIgnoringSafeArea(.bottom)
        }.actionSheet(isPresented: $showingSheet, content: {
            presentSheet
        })
    }
    
    func move(from source: IndexSet, to destination: Int) {
        self.data.toDOData.move(fromOffsets: source, toOffset: destination)
    }
    
    func removeExistingToDoAction(at index: IndexSet) {
        index.forEach { self.data.toDOData.remove(at: $0) }
    }
}
