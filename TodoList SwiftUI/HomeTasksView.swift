

import SwiftUI

struct HomeTasksView : View {
    @ObjectBinding var data = Store()
    @State var selectedTask: ToDo? = nil

    @State var showingSheet: Bool = false
    @State var selectedDate = Date()
    
    var presentSheet: ActionSheet {
        ActionSheet(
            title: Text("Todo Actions"),
            message: nil,
            buttons: [
                ActionSheet.Button.default(Text("Mark as Complete"), onTrigger: {
                    self.data.CompleteTask(self.selectedTask)
                    self.showingSheet.toggle()
                }), ActionSheet.Button.cancel({
                    self.showingSheet.toggle()
                })])
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: AddNewToDoTaskHeaderView(toDoStore: self.data)) {
                    ForEach(self.data.toDOData, id: \.self) { todo in
                        Button(action: {
                            self.selectedTask = todo
                            self.showingSheet = true
                        }) {
                            TaskRow(todo: todo ,todayDate: self.selectedDate)
                                .padding()
                        }
                        .listRowBackground(todo.due.isEqual(currentDate: self.selectedDate) ? Color.green : todo.due.isPast(today: self.selectedDate) ? Color.yellow : Color.pink)
                    } .onDelete(perform: removeExistingToDoAction)
                        .onMove(perform: move)
                }
            }.navigationBarTitle(Text("Tasks").font(.largeTitle))
                .listStyle(.grouped)
                .navigationBarItems(trailing: EditButton())
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
