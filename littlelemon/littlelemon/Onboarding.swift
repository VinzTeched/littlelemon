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
    @State var error = false
    @State var errorMessage = ""
    
     
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 5) {
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
                                .aspectRatio(contentMode: .fill)
                                .frame(width:140, height: 150)
                                .clipShape(Rectangle())
                                .cornerRadius(16)
                        }
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 200,
                    alignment: .topLeading
                    )
                .padding(14)
                .background(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
                Divider()
                    .frame(width: 0)
                    .padding(8)
                
                if error {
                    withAnimation() {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("First Name *")
                        .padding(.bottom, -3)
                        .font(.system(size: 15))
                    TextField("First Name", text: $firstName)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353), lineWidth: 1))
                        .padding(.bottom, 8)
                    
                    Text("Last Name *")
                        .padding(.bottom, -3)
                        .font(.system(size: 15))
                    TextField("Last Name", text: $lastName)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353), lineWidth: 1))
                        .padding(.bottom, 8)
                    
                  
                    Text("Email *")
                        .padding(.bottom, -3)
                        .font(.system(size: 15))
                    TextField("Email", text: $email)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353), lineWidth: 1))
                        .padding(.bottom, 8)
                        .autocorrectionDisabled()
                    HStack(alignment: .center) {
                        Button("Register"){
                            if(firstName.isEmpty) {
                                error = true
                                errorMessage = "First Name must be provided!"
                            } else if (lastName.isEmpty) {
                                error = true
                                errorMessage = "Last Name must be provided!"
                            } else if (email.isEmpty) {
                                error = true
                                errorMessage = "Email must be provided!"
                            } else if (email.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) == nil) {
                                error = true
                                errorMessage = "Email incorrect!"
                            }
                            else {
                                isLoggedIn = true
                                UserDefaults.standard.set(firstName, forKey: kFirstName)
                                UserDefaults.standard.set(lastName, forKey: kLastName)
                                UserDefaults.standard.set(email, forKey: kEmail)
                                UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                                firstName = ""
                                lastName = ""
                                email = ""
                            }
                        }
                        .padding()
                        .background(Color(hue: 0.138, saturation: 0.966, brightness: 0.925))
                        .cornerRadius(10)
                        .foregroundColor(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
                        .padding(.vertical, 15)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 10)
                Spacer()
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear() {
                if(UserDefaults.standard.bool(forKey: kIsLoggedIn) == true) {
                    isLoggedIn = true
                }
            }
        }
    }
}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
