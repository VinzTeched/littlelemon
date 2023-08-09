//
//  Onboarding.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 08/08/2023.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 5) {
                TextField("First Name", text: $firstName)
                Divider()
                    .padding(.bottom, 20)
                TextField("Last Name", text: $lastName)
                Divider()
                    .padding(.bottom, 20)
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
                Divider()
                    .padding(.bottom, 20)
                Button("Register"){
                    if(firstName.isEmpty) {
                        //UserDefaults.standard.set(firstName, forKey: kFirstName)
                    } else if (lastName.isEmpty) {
                        //UserDefaults.standard.set(lastName, forKey: kLastName)
                    } else if (email.isEmpty) {
                        //UserDefaults.standard.set(email, forKey: kEmail)
                    } else if (email.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) == nil) {
                        //
                    }
                    else {
                        isLoggedIn = true
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    }
                }
                .padding(10)
                .background(Color(red: 0.085, green: 0.533, blue: 0.019))
                .cornerRadius(8)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear() {
                if(UserDefaults.standard.bool(forKey: kIsLoggedIn) == true) {
                    isLoggedIn = true
                }
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
