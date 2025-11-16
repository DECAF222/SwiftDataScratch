//
//  SwiftDataScratchApp.swift
//  SwiftDataScratch
//
//  Created by Nitish M on 16/11/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataScratchApp: App {
//    let container: ModelContainer = {
//        let schema = Schema([ExpenseModel.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(container)
        .modelContainer(for: [ExpenseModel.self])
    }
}
