//
//  ContentView.swift
//  SwiftDataScratch
//
//  Created by Nitish M on 16/11/25.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var isShowingSheet = false;
    @Query(sort: \ExpenseModel.date) var expenses: [ExpenseModel]
    @State private var selectedExpense: ExpenseModel?

    
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses){ expense in
                    HStack{
                        Text(expense.date, format: .dateTime.month(.abbreviated).day())
                            .frame(width: 70, alignment: .leading)
                        Text(expense.name)
                        Spacer()
                        Text(expense.amount, format: .currency(code: "USD"))
                    }
                    .onTapGesture {
                        selectedExpense = expense
                    }
                }
                .onDelete{ indexSet in
                    for index in indexSet{
                        context.delete(expenses[index])
                    }
                }
            }
            .navigationTitle(Text("Expenses"))
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingSheet) { AddingSheet() }
            .sheet(item: $selectedExpense){expense in
                UpdateSheet(expense: expense)
            }
            .toolbar{
                if !expenses.isEmpty{
                    Button("Add expense", systemImage: "plus"){
                        isShowingSheet = true
                    }
                }
            }
            .overlay{
                if expenses.isEmpty{
                    ContentUnavailableView(label: {
                        Label("No Expense Done!", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding your expense by clicking below!")
                    }, actions: {
                        Button("Add Expense"){
                            isShowingSheet = true
                        }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

struct AddingSheet: View{
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var amount: Double = 0
    @State private var date: Date = .now
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("amount", value: $amount, format: .currency(code: "USD"))
                    .navigationTitle("New Expense")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("cancel"){
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing){
                            Button("Add"){
                                let newExpense = ExpenseModel(name: name, date: date, amount: amount)
                                context.insert(newExpense)
                                dismiss()
                            }
                        }
                    }
            }
        }
    }
}


struct UpdateSheet: View {

    @Environment(\.dismiss) private var dismiss

    @Bindable var expense: ExpenseModel

    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Amount", value: $expense.amount, format: .currency(code: "USD"))
            }
            .navigationTitle("Update Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Update") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
