//
//  Book_a_roomApp.swift
//  Book a room
//
//  Created by Felix Fischer on 25/11/2021.
//

import SwiftUI

@main
struct Book_a_roomApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(RoomsService())
        }
    }
}
