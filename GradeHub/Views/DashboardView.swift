import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CourseListView()) {
                    Text("My Courses")
                        .frame(minWidth: 200)
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                
                NavigationLink(destination: GpaCalculatorView()) {
                    Text("GPA Calculator")
                        .frame(minWidth: 200)
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
            .navigationTitle("Grade Hub")
        }
    }
}
