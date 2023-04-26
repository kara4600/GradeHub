import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: ViewModel
    let pink = Color(red: 242/255, green: 207/255, blue: 231/255)
    let purple = Color(red: 113/255, green: 115/255, blue: 227/255)
    
    var body: some View {
        NavigationView {
            ZStack{LinearGradient(gradient: Gradient(colors: [purple,pink]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    NavigationLink(destination: CourseListView()) {
                        Text("My Courses")
                            .frame(minWidth: 300, minHeight: 100)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                    
                    NavigationLink(destination: GpaCalculatorView()) {
                        Text("GPA Calculator")
                            .frame(minWidth: 300, minHeight: 100)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                    .controlSize(.large)
                    
                    NavigationLink(destination: FinalGradeCalculatorView()) {
                        Text("Final Grade Calculator")
                            .frame(minWidth: 300, minHeight: 100)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                    
                    Spacer()
                    Button(action: {
                        viewModel.signOut()
                    })  {
                        Text("Sign Out")
                            .frame(minWidth:200)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                .navigationTitle("Grade Hub")
            }
        }
    }
}
