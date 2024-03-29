import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth


struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var goToDashboard: Bool = false
    @EnvironmentObject var viewModel: ViewModel
    
    
    var body: some View {
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
                
                SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.gray))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                Button("Login") {
                    viewModel.errorMessage = nil
                    viewModel.login(email: email, password: password)
                }
                .buttonStyle(GrowingButton())
                
                Button("Sign Up") {
                    viewModel.errorMessage = nil
                    viewModel.signUp(email: email, password: password)
                }
                .buttonStyle(GrowingButton())
                
                if let errorMessage = viewModel.errorMessage{
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top)
                }
            }
            .navigationTitle("Grade Hub")
        }
    }
}
