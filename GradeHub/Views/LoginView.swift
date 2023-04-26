import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth


struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var goToDashboard: Bool = false
    @EnvironmentObject var viewModel: ViewModel
    let pink = Color(red: 242/255, green: 207/255, blue: 231/255)
    let orange = Color(red: 240/255, green: 97/255, blue: 30/255)
    
    
    var body: some View {
        NavigationView {
            ZStack {LinearGradient(gradient: Gradient(colors: [orange,pink]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("GRADEHUB").font(.largeTitle).foregroundColor(.black).fontWeight(.bold).frame(alignment: .top)
                    Text("Welcome!").foregroundColor(.black)
                    Text("Login or Sign up to get started.").foregroundColor(.black)
                    
                    TextField("Email", text: $email, prompt: Text("Email").foregroundColor(.black))
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 2)
                        }
                        .padding(.horizontal)
                    
                    Spacer().frame(height: 13)
                    
                    SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.black))
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
            }
            
        }
    }
}
