//
//  ViewModel.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 17/08/2023.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var firstName = UserDefaults.standard.string(forKey: "first name key") ?? ""
    @Published var lastName = UserDefaults.standard.string(forKey: "last name key") ?? ""
    @Published var email = UserDefaults.standard.string(forKey: "email key") ?? ""
    @Published var phone = UserDefaults.standard.string(forKey: "phone key") ?? ""
    @Published var orderStatus = UserDefaults.standard.bool(forKey: "order status key")
    @Published var passwordChange = UserDefaults.standard.bool(forKey: "password change key")
    @Published var specialOffer = UserDefaults.standard.bool(forKey: "special offer key")
    @Published var newsletter = UserDefaults.standard.bool(forKey: "newsletter key")
}
