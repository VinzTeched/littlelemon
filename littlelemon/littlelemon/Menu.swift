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
    
    let buttons: [CategoryButton] = [
        CategoryButton(id: 0, title: "Starters"),
        CategoryButton(id: 1, title: "Mains"),
        CategoryButton(id: 2, title: "Desserts"),
        CategoryButton(id: 3, title: "Drinks")
    ]
    
    @State var selected = 5
    
    var body: some View {
        VStack {
            Group{
                HStack {
                    Spacer()
                    Image("Logo")
                        .padding(.trailing, -40)
                    Spacer()
                    
                    NavigationLink(destination: UserProfile()) {
                        Image("Profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    }
                    
                }
                .padding(.trailing, 10)
            }
            VStack(alignment: .leading) {
                Text("Little Lemon")
                    .font(.custom("MarkaziText-Medium", size: 60))
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.9568627450980393, green: 0.807843137254902, blue: 0.0784313725490196)/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, -13.0)
                   
                   
                HStack {
                    VStack (alignment: .leading){
                        Text("Chicago")
                            .font(.custom("MarkaziText-Medium", size: 38))
                            .foregroundColor(Color.white)
                            .padding(.top, -31.0)
                        Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.system(size: 17))
                            .foregroundColor(Color.white)
                            .padding(.top, -28.0)
                            .fixedSize(horizontal: false, vertical: true)
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
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search Text", text: $searchText).foregroundColor(Color.black).frame(height: 15)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                Divider()
                    .padding(40)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 276,
                alignment: .topLeading
                )
            .padding(14)
            .background(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
            
            VStack(alignment: .leading) {
                Text("ORDER FOR DELIVERY!")
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(buttons, id: \.id) { btn in
                            CategoryButtonView(btn: btn, selectedBtn: self.$selected)
                            
                        }
                    }
                }
            }
            .padding(10)
            Divider()
            FetchedObjects(predicate: buildPredicate(),sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        ZStack{
                            NavigationLink(destination:
                                            MenuDetails(dish)) {}.opacity(0)
                            VStack(alignment: .leading) {
                                Text(dish.title ?? "")
                                    .fontWeight(.semibold)
                                HStack() {
                                    VStack(alignment: .leading) {
                                        Text(dish.describe ?? "")
                                            .lineLimit(2)
                                            .padding(.top, -9)
                                            .font(.system(size: 15))
                                        Text("$"+(dish.price ?? "") )
                                            .fontWeight(.medium)
                                            .padding(.top, 1)
                                    }
                                    .frame(width: 250)
                                    Spacer()
                                    AsyncImage(url: URL(string: dish.image ?? "")){ image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 80, height: 80)
                                    
                                }
                                .padding(.leading, -2)
                            }
                        }
                    }
                }
                .background(Color.white)
                .listStyle(PlainListStyle())
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

struct CategoryButton: Identifiable {
    var id: Int
    var title: String
}

struct CategoryButtonView: View {
    var btn: CategoryButton
    @Binding var selectedBtn: Int
    
    var body: some View {
        Button(action: {
            self.selectedBtn = self.btn.id
        }) {
            Text(btn.title)
                .foregroundColor(self.selectedBtn == self.btn.id ? Color.white : Color.black)
        }
        .frame(width: 84, height: 40)
        .background(self.selectedBtn == self.btn.id ? Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353) : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.1))
        .cornerRadius(25)
        .shadow(radius: 2)
        .padding(2)

    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
