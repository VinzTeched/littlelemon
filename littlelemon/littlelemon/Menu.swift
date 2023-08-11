//
//  Menu.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 08/08/2023.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    func getMenuData() {
        PersistenceController.shared.clear()
        let serverUrl = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: serverUrl)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                let fullMenu = try? decoder.decode(MenuList.self, from: data)
                for menu in fullMenu!.menu {
                    let oneDish = Dish(context: viewContext)
                    oneDish.title = menu.title
                    oneDish.image = menu.image
                    oneDish.price = menu.price
                }
                try? viewContext.save()
            }
        }
        task.resume()
        
    }
    var body: some View {
        VStack {
            Text("Little Lemon for Agnes")
            Text("Chicago")
            Text("The place where all go to eat and satiate themselves.")
           
            FetchedObjects() {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack { 
                            Text(dish.title ?? "")
                            Text(dish.price ?? "")
                            AsyncImage(url: URL(string: dish.image ?? "")){ image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }
                    }
                }
            }
        }
        .onAppear() {
            getMenuData()
        }
    }
    
  
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
