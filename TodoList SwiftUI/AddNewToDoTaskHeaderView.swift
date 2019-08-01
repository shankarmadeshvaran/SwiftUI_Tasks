

import SwiftUI

struct AddNewToDoTaskHeaderView: View {
    
    @ObjectBinding var toDoStore: Store
    @State var newToDo: String = ""
    @State var isShowAlert: Bool = false
    
    var body: some View {
        HStack {
            TextField("Enter the new task to do",text: $newToDo)
                .foregroundColor(.primary)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 20))
            Button(action: {
                self.addNewTask()
            }) {
                Image(systemName: "plus.circle.fill").font(.title)
            }
        } .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
            .frame(height: 70)
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text("Task to do can't be empty"), message: Text("Next Task to Do"), dismissButton: .default(Text("OK")))
        }
    }
    
    func addNewTask() {
        if !self.newToDo.isEmpty {
            self.toDoStore.toDOData.append(ToDo(title: self.newToDo, due: "Today"))
            self.newToDo = ""
        } else {
            self.isShowAlert = true
        }
    }
    
}
