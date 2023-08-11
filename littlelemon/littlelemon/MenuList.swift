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

struct MenuList: Decodable {
    let menu: [MenuItem]
}

struct MenuItem: Decodable {
    //
    let title: String
    let image: String
    let price: String
    let description: String
}
