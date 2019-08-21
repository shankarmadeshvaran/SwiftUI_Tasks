
import SwiftUI
import CoreData

struct AddNewToDoTaskHeaderView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext

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
        Alert(title: Text("Please enter the Task name"), message: Text("Next Task to Do"), dismissButton: .default(Text("OK")))
    }
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            TextField("Enter the new task to do",text: $newToDo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.primary)
                .font(.system(size: 20))
                .frame(height: 60)
            
            HStack(alignment: .center, spacing: 10) {
                Text("Due Date")
                    .foregroundColor(.primary)
                    .font(.system(size: 21))
                    .bold()
                
                Text("\(dueDate, formatter: dateFormatter)")
                    .foregroundColor(.secondary)
                    .font(.system(size: 20))
                    .bold()
            }.onTapGesture {
                self.showDatePicker.toggle()
            }
            if self.showDatePicker {
                DatePicker(
                    selection: $dueDate,
                    in: dateClosedRange,
                    displayedComponents: [.hourAndMinute, .date],
                    label: {Text("")})
                    .datePickerStyle(DefaultDatePickerStyle())
            }
            Button(action: {
                self.addNewTask()
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
    
    func addNewTask() {
        if !self.newToDo.isEmpty {
            let todo = ToDo(context: self.managedObjectContext)
            todo.title = self.newToDo
            todo.due = self.dueDate
            todo.isNotify = false
            try! self.managedObjectContext.save()
            self.newToDo = ""
        } else {
            self.isShowAlert = true
        }
    }
}

struct AddNewTaskButtonView: View  {
    var body: some View {
        Text("Add New Task")
            .bold()
            .foregroundColor(.white)
            .font(.system(size: 22))
    }
}

