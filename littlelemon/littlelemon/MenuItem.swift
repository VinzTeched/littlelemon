//
//  MenuItem.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 10/08/2023.
//

import Foundation

struct MenuItems: Codable, Identifiable {
    //
    var id = UUID()
    let title: String
    let image: String
    let price: String
    let description: String
}
