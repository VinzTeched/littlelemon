//
//  UserProfile.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 08/08/2023.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: "first name key")
    let lastName = UserDefaults.standard.string(forKey: "last name key")
    let email = UserDefaults.standard.string(forKey: "email key")
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Group {
                Text("Personal Information")
                    .bold()
                Image("profile-image-placeholder")
                    .clipShape(Capsule())
                Divider()
                    .padding(20)
                Text(firstName ?? "null")
                Divider()
                    .frame(width: 0)
                Text(lastName ?? "null")
                Divider()
                    .frame(width:0)
                Text(email ?? "null")
                Divider()
                    .frame(width: 0.0, height: 20)
                Button("Logout") {
                    UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                    dismiss()
                }
                .foregroundColor(.red)
            }
            Spacer()
            
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
