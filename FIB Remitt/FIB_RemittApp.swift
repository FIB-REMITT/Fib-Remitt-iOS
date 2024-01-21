//
//  FIB_RemittApp.swift
//  FIB Remitt
//
//  Created by Jamil Hasnine on 21/1/24.
//

import SwiftUI

@main
struct FIB_RemittApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
