//
//  Onboarding.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 08/08/2023.
//

import SwiftUI

let johnFirstName = "John"
let johnLastName = "Doe"
let johnEmail = "johndoe@email.com"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        VStack(spacing: 5) {
            TextField("First Name", text: $firstName)
            Divider()
                .padding(.bottom, 20)
            TextField("Last Name", text: $lastName)
            Divider()
                .padding(.bottom, 20)
            TextField("Email", text: $email)
            Divider()
                .padding(.bottom, 20)
            Button("Register"){
                if(firstName.isEmpty) {
                    UserDefaults.standard.set(firstName, forKey: johnFirstName)
                } else if (lastName.isEmpty) {
                    UserDefaults.standard.set(lastName, forKey: johnLastName)
                } else if (email.isEmpty) {
                    UserDefaults.standard.set(email, forKey: johnEmail)
                }
            }
            .padding(10)
            .background(Color(red: 0.085, green: 0.533, blue: 0.019))
            .cornerRadius(8)
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
