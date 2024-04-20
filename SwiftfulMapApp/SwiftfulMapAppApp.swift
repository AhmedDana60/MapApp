//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Ahmed Dana Mohammed on 3/13/24.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {

@StateObject private var vm = LocationsViewModel()

    
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
