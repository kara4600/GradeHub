//
//  GradeHubApp.swift
//  GradeHub
//
//  Created by Kara Rizzardi on 4/18/23.
//

import SwiftUI

@main
struct GradeHubApp: App {
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
