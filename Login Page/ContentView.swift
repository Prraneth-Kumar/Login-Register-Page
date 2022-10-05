//
//  ContentView.swift
//  Login Page
//
//  Created by Prraneth Kumar A R on 04/10/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct ExtractedView: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoggedIn: Bool = false
    @State var status: Bool = false
    @State var mess: String = ""
    @State private var animationAmount = 0.0

    var body: some View {
       LoginView()

        NavigationStack{
            NavigationLink(destination: LoginView(),
                           isActive: $isLoggedIn) {
            }
            VStack {
                ExtractedView()
                //LoginView(isLoggedIn:$isLoggedIn)
                TextField("Username", text: $username)
                    .padding()
                    .background(lightGreyColor)
                
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                //action: {print("Button tapped")}
                
                
                Button() {
                    getuserDetails(email: username, password: password)
                }label:{
                    Text("LOGIN")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }.alert(isPresented: $status){
                    Alert(
                        title: Text("User Details"),
                        message: Text("\(mess)"),
                        primaryButton: .cancel(Text("Cancel")),
                        secondaryButton: .destructive(Text("Okay")){
                            withAnimation(.interpolatingSpring(stiffness: 20, damping: 20)) {
                                animationAmount += 360
                            }
                        }
                    )
                }.rotation3DEffect(.degrees(animationAmount), axis: (x: 10, y: 10, z: 30))
            }
            .padding()
        }
    }
    
    func getuserDetails(email: String, password: String){
        let url = "https://apponedemo.top/vouwch/api/login"
        let dict = ["email": email,"password":password,"device_type":"IOS","device_token":"121312"] as [String:String]
        
        Alamofire.request(url, method: .post, parameters: dict).responseJSON{
            response in // print(response)
            let json = try! JSON(data: response.data!)
            status = json["status"].bool!
            mess = json["message"].string!
            
            if status {
                isLoggedIn = true
            }
            
            print(status)
            status = true
        }
    }
    
}




struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    let verticalPaddingForForm = 40
   // @Binding var isLoggedIn: Bool
    
    @State private var animationAmount = 0.0

    
    var body: some View {
        
        
        
        
        ZStack {
            Color(red: 20/225.0 ,green: 22/225.0 , blue: 25/225.0)
            
            VStack(alignment: .leading, spacing: 0) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 150)
                    .padding()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .ignoresSafeArea(.all)
            
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                
                VStack {
                    TextField("Email", text: $email)
                        .padding(.horizontal, 15).padding(.top, 50)
                    Divider()
                        .padding(.horizontal, 15)
                    SecureField("Password", text: $password)
                        .padding(.horizontal, 15).padding(.top, 20)
                    Divider()
                        .padding(.horizontal, 15)
                    
                }
                .background(Color(.white))
                
                
                Link("Forgotten Password",
                     destination: URL(string: "https://www.google.co.uk")!)
                .foregroundColor(.blue)
                .font(.system(size: 15))
                
                
                Button(action: {
                    
                    //Do login stuff here and if true switch view to to MainContentView
                    
                    
                }) {
                    Text("Login")
                        .padding()
                        .font(.system(size: 20))
                    
                }
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.top, 0)
                .padding(.bottom, 20)
                
            }
            .padding(.horizontal, CGFloat(verticalPaddingForForm))
            .background(Color(.white))
            
            VStack{
                Spacer()
                Button(action: {
                    withAnimation(.interpolatingSpring(stiffness: 1, damping: 1)) {
                        animationAmount += 360
                    }
                }) {
                    Text("Register")
                        .padding()
                        .font(.system(size: 40))
                    
                    
                }
                .background(.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding()
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 10, y: 10, z: 30))
            }
        }.ignoresSafeArea()
        
        
    };
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


