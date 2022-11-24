//
//  ExamenFinalApp.swift
//  ExamenFinal
//
//  Created by CCDM21 on 23/11/22.
//

import SwiftUI

@main
struct ExamenFinalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
