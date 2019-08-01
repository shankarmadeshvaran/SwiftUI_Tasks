

import SwiftUI

struct TaskRow: View {
    let todo: ToDo
    
    var body: some View {
        Text(todo.title)
            .foregroundColor(.white)
            .lineLimit(nil)
            .font(.system(size: 24))
            .listRowBackground(todo.due == "Today" ? Color.green : Color.gray)
            .padding()
    }
}
