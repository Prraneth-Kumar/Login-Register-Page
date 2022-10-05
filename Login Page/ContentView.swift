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
    var text = ""
    var body: some View {
        Text(text)
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
    @State var bolVal: Bool = false

    var body: some View {
      // LoginView()

        NavigationStack{
            NavigationLink(destination: LoginView(),
                           isActive: $isLoggedIn) {
            }
            NavigationLink(destination: LoginView(),
                           isActive: $bolVal) {
            }
            VStack {
                ExtractedView(text: "Welcome!")
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
                        primaryButton: .destructive(Text("Cancel")),
                        secondaryButton: .cancel(Text("Sign Up")){
                            bolVal = true
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
    
    @State private var firstName: String = ""
    @State private var secondName: String = ""
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var conformpassword: String = ""
    
    
    @State var status: Bool = false
    @State var mess: String = ""
    
    
    let verticalPaddingForForm = 40
    // @Binding var isLoggedIn: Bool
    
    @State private var animationAmount = 0.0
    
    
    var body: some View {
        
        VStack {
            ExtractedView(text: "User Registration")
            //LoginView(isLoggedIn:$isLoggedIn)
            TextField("Enter First Name", text: $firstName)
                .padding()
                .background(lightGreyColor)
            
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            TextField("Enter Second Name", text: $secondName)
                .padding()
                .background(lightGreyColor)
            
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
            
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Conform Password", text: $conformpassword)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            //action: {print("Button tapped")}
            
            
            Button() {
               // getuserRegistration(email: username, password: password)
                getuserRegistration(FirNam: firstName,SecNam: secondName, EmaID: email, Pass: password, ConPass: conformpassword)
            }label:{
                Text("SIGN UP")
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
    
    func getuserRegistration(FirNam: String,SecNam: String, EmaID: String, Pass: String, ConPass:String){
        
        
        
        
        let urlRegister = "https://apponedemo.top/vouwch/api/register"
        
        
        let dictRegister = ["user_type": "1", "first_name": FirNam, "last_name": SecNam, "email": EmaID, "password": Pass, "confirm_password": ConPass, "device_type": "IOS", "device_token": "Personal"] as [String : String]
      //  print(dictRegister)
        Alamofire.request( urlRegister, method: .post, parameters: dictRegister)
            .responseJSON {  [self]  request in
                
                let json = try! JSON(data: request.data!)
                status = json["status"].bool!
                mess = json["message"].string!
                
//                if status {
//                    isLoggedIn = true
//                }
                
                print(json)
                status = true
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


