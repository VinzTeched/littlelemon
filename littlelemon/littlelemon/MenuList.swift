//
//  MenuList.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 10/08/2023.
//

import Foundation

//struct MenuLists: Decodable {
//    let menu = [MenuItems]
//}

struct MenuList: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable, Identifiable {
    //
    var id = UUID()
    let title: String
    let image: String
    let price: String
}
