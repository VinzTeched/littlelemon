//
//  Menu.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 08/08/2023.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
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
                    oneDish.describe = menu.description
                }
                try? viewContext.save()
            }
        }
        task.resume()
        
    }
    var body: some View {
        VStack {
            Group{
                HStack {
                    Spacer()
                    Image("Logo")
                        .padding(.trailing, -40)
                    Spacer()
                    Image("Profile")
                        .resizable()
                        .frame(width: 50, height: 50)
                        
                }
            }
            Text("Little Lemon for Agnes")
            Text("Chicago")
            Text("The place where all go to eat and satiate be happy.")
            TextField("Search Text", text: $searchText)
            Divider()
                .padding(.bottom, 6)
            FetchedObjects(predicate: buildPredicate(),sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink(destination:
                                        MenuDetails(dish)) {
                            HStack {
                                AsyncImage(url: URL(string: dish.image ?? "")){ image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                
                                Text(dish.title ?? "")
                                Spacer()
                                Text((dish.price ?? "") + " USD" )
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            getMenuData()
        }
        .padding()
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    private func buildPredicate() -> NSPredicate {
        return searchText == "" ?
        NSPredicate(value: true) :
        NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
  
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
