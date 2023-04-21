import SwiftUI
import Firebase
import FirebaseCore

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var goToDashboard: Bool = false
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        func login(){
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error!)
                }
                else {
                    print("Login successful!")
                    viewModel.loggedIn = true
                }
            }
        }
        NavigationView {
            VStack {
                Text("Welcome!")
                Text("Login or Sign up to get started.").foregroundColor(.gray)
                
                TextField("Email", text: $email, prompt: Text("Email").foregroundColor(.gray))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                Spacer().frame(height: 13)
                
                TextField("Password", text: $password, prompt: Text("Password").foregroundColor(.gray))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                Button("Login") {
                    viewModel.login(email: email, password: password)
                    login()
                }
                .buttonStyle(GrowingButton())
                
                Button("Sign Up") {
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if error != nil {
                            print(error!)
                        }
                        else {
                            print("Sign up successful!")
                            viewModel.loggedIn = true
                        }
                    }
                }
                .buttonStyle(GrowingButton())
            }
            .navigationTitle("Grade Hub")
        }
    }
}
