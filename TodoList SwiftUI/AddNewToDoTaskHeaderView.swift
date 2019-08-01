

import SwiftUI

struct AddNewToDoTaskHeaderView: View {
    @ObjectBinding var toDoStore: Store
    @State var dueDate = Date()
    
    @State var newToDo: String = ""
    @State var textfieldText: String = ""
    
    @State var isShowAlert: Bool = false
    @State var showDatePicker = false
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        return min...max
    }
    
    var alert: Alert {
        Alert(title: Text("Task to do can't be empty"), message: Text("Next Task to Do"), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            TextField("Enter the new task to do",text: $newToDo)
                .foregroundColor(.primary)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 20))
                .lineLimit(nil)
            
            DatePicker(
                selection: $dueDate,
                in: dateClosedRange,
                displayedComponents: [.hourAndMinute, .date],
                label: { DateView() }
            ).datePickerStyle(.default)
                .foregroundColor(.primary)
                .font(.system(size: 25))
            
            Button(action: {
                self.addNewTask(dueDate: self.dueDate)
            }) {
                AddNewTaskButtonView()
                    .frame(width: 250, height: 45, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        } .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
            .alert(isPresented: $isShowAlert, content:  {
                alert
            })
    }
    
    func addNewTask(dueDate: Date) {
        if !self.newToDo.isEmpty {
            self.toDoStore.toDOData.append(ToDo(title: self.newToDo, due: dueDate))
            self.newToDo = ""
        } else {
            self.isShowAlert = true
        }
    }
    
}

struct DateView: View  {
    var body: some View {
        Text("Due Date")
            .foregroundColor(.gray)
            .font(.system(size: 20))
    }
}

struct AddNewTaskButtonView: View  {
    var body: some View {
        Text("Add New Task")
            .bold()
            .foregroundColor(.white)
            .font(.system(size: 24))
    }
}
