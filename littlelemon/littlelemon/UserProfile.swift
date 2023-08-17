//
//  UserProfile.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 08/08/2023.
//

import SwiftUI


struct UserProfile: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var error = false
    @State var errorMessage = ""
    @State var success = false
    
    @StateObject private var viewModel = ViewModel()
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var orderStatus = true
    @State private var passwordChange = true
    @State private var specialOffer = true
    @State private var newsletter = true
    
    @State private var isLoggedOut = false
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavView(title: "Home", content:
          NavigationStack {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading) {
                    Group {
                        HStack {
                            Text("Personal Information")
                                .bold()
                                .padding(.bottom, 6)
                            Spacer()
                            ZStack {
                                if success {
                                    Text("Changes Saved!")
                                        .foregroundColor(.green)
                                }
                            }
                            .shadow(radius: 10.0)
                            .animation(Animation.easeInOut(duration: 0.5), value: success)
                            
                            
                        }
                        Text("Avatar")
                            .font(.system(size: 13))
                            .padding(.bottom, -5)
                        HStack{
                            Image("Profile")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 80, height: 80)
                                .clipShape(Capsule())
                            Button("Change"){}
                                .frame(width: 85, height: 40)
                                .background(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                                .sheet(isPresented: $showingImagePicker){
                                    EditorImagePicker(image: $inputImage)
                                }
                            Button("Remove"){}
                                .frame(width: 85, height: 40)
                                .foregroundColor(.black)
                                .border(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
                        }
                        ZStack {
                            if error {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .animation(Animation.easeInOut(duration: 0.5), value: error)
                        Divider()
                            .frame(width: 0)
                            .padding(1)
                        Group {
                            Text("First name")
                                .padding(.bottom, -5)
                                .font(.system(size: 12))
                            TextField("First Name", text: $firstName)
                                .padding(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353), lineWidth: 1))
                                .padding(.bottom, 4)
                            
                            Text("Last name")
                                .padding(.bottom, -5)
                                .font(.system(size: 12))
                            TextField("First Name", text: $lastName)
                                .padding(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353), lineWidth: 1))
                                .padding(.bottom, 4)
                            
                            Text("Email")
                                .padding(.bottom, -5)
                                .font(.system(size: 12))
                            TextField("First Name", text: $email)
                                .padding(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353), lineWidth: 1))
                                .padding(.bottom, 4)
                            
                            Text("Phone number")
                                .padding(.bottom, -5)
                                .font(.system(size: 12))
                            TextField("Phone Number", text: $phone)
                                .padding(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353), lineWidth: 1))
                            
                        }
                        .font(.system(size: 14))
                        Group {
                            Text("Email Notification")
                                .font(.system(size: 16))
                                .padding(.top, 10)
                                .bold()
                            
                            HStack {
                                CheckBoxView(checked: $orderStatus)
                                Text("Order Statuses")
                            }
                            
                            HStack {
                                CheckBoxView(checked: $passwordChange)
                                Text("Password Changes")
                            }
                            
                            HStack {
                                CheckBoxView(checked: $specialOffer)
                                Text("Special Offers")
                            }
                            
                            HStack {
                                CheckBoxView(checked: $newsletter)
                                Text("Newsletter")
                            }
                            
                        }
                        .padding(.top, 3)
                        .font(.system(size: 14))
                        
                        Button("Logout") {
                            UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                            isLoggedOut = true
                        }
                        .frame(minWidth: 200, maxWidth: .infinity, minHeight: 35)
                        .background(Color(hue: 0.138, saturation: 0.966, brightness: 0.925))
                        .cornerRadius(10)
                        .foregroundColor(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
                        .padding(.vertical, 15)
                        
                        HStack (alignment: .center){
                            Button("Discard Changes"){
                                firstName = firstName
                                lastName = lastName
                                email = email
                                phone = phone
                                
                                orderStatus = orderStatus
                                passwordChange = passwordChange
                                specialOffer = specialOffer
                                newsletter = newsletter
                                
                                dismiss()
                                
                            }
                            .padding(10)
                            .foregroundColor(.black)
                            .border(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
                            .font(.system(size: 14))
                            
                            Button("Save Changes"){
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
                                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                                    UserDefaults.standard.set(lastName, forKey: kLastName)
                                    UserDefaults.standard.set(email, forKey: kEmail)
                                    UserDefaults.standard.set(phone, forKey: kPhone)
                                    UserDefaults.standard.set(orderStatus, forKey: kOrderStatus)
                                    UserDefaults.standard.set(passwordChange, forKey: kPasswordChange)
                                    UserDefaults.standard.set(specialOffer, forKey: kSpecialOffer)
                                    UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                                    
                                    success = true
                                    
                                }
                            }
                            .padding(10)
                            .background(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.leading, 10)
                            .font(.system(size: 14))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            .onAppear {
                firstName = viewModel.firstName
                lastName = viewModel.lastName
                email = viewModel.email
                phone = viewModel.phone
                orderStatus = viewModel.orderStatus
                passwordChange = viewModel.passwordChange
                specialOffer = viewModel.specialOffer
                newsletter = viewModel.newsletter
            }
            .navigationDestination(isPresented: $isLoggedOut) {
                Onboarding()
            }
        }
      )
    }
}


struct NavView<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let title: String
    let content: Content
    
    var body: some View {
        NavigationView {
            VStack {
                NavBar(backHandler: { self.presentationMode.wrappedValue.dismiss() }, title: title)
                content
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct NavBar: View {
    let backHandler: (() -> Void)
    let title: String
        
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: { self.backHandler() }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .frame(width: 40, height: 35)
                            .background(Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353))
                            .clipShape(Circle())
                            .foregroundColor(Color.white)
                    }
                }
                Spacer()
                Image("Logo")
                    .padding(.trailing, -10)
                Spacer()
                Image("Profile")
                    .resizable()
                    .frame(width: 50, height: 50)
            }.padding([.leading, .trailing], 16)
            Divider()
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .frame(height: 45)
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color.blue : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
