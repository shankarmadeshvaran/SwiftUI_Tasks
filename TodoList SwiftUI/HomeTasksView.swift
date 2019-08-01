

import SwiftUI

struct HomeTasksView : View {
    @ObjectBinding var data = Store()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: AddNewToDoTaskHeaderView(toDoStore: self.data)) {
                    ForEach(self.data.toDOData, id: \.self) { todo in
                        TaskRow(todo: todo)
                    } .onDelete(perform: removeExistingToDoAction)
                        .onMove(perform: move)
                }
            } .navigationBarTitle(Text("Tasks").font(.largeTitle))
            .listStyle(.grouped)
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        self.data.toDOData.move(fromOffsets: source, toOffset: destination)
    }
    
    func removeExistingToDoAction(at index: IndexSet) {
        index.forEach { self.data.toDOData.remove(at: $0) }
    }
}
