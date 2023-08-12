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
                .padding(.trailing, 10)
            }
            VStack(alignment: .leading) {
                Text("Little Lemon")
                    .font(.system(size: 52))
                    .padding(0)
                HStack {
                    VStack (alignment: .leading){
                        Text("Chicago")
                            .font(.system(size: 28))
                        Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.system(size: 17))
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 200)
                    Spacer()
                    VStack{
                        Image("Hero image")
                            .resizable()
                            .frame(width:140, height: 150)
                            .cornerRadius(20)
                    }
                }
                TextField("Search Text", text: $searchText)
                    
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 100,
                alignment: .topLeading
                )
            .padding(14)
            .background(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
            
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
