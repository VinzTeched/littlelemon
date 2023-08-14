//
//  Home.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 08/08/2023.
//

import SwiftUI

struct Home: View {
    let persistenceController = PersistenceController.shared
    var body: some View {
        TabView {
            Menu()
                .tabItem{
                    return Label("Menu", systemImage: "list.dash")
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            UserProfile()
                .tabItem {
                    return Label("Profile", systemImage: "square.and.pencil")
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "app.fill")
                            Text("helslk")
                        }
                    }
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
