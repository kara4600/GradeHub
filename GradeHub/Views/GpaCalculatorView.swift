import SwiftUI

struct GpaCalculatorView: View {
    @EnvironmentObject var viewModel: ViewModel
    var gradePointsMapping:[String:Double] = ["A+": 4.0, "A": 4.0, "A-":3.7, "B+": 3.3, "B": 3, "B-": 2.7, "C+": 2.3, "C": 2, "C-": 1.7, "D+": 1.3, "D": 1, "D-": 0.7, "F": 0.0]
    let pink = Color(red: 242/255, green: 207/255, blue: 231/255)
    let purple = Color(red: 113/255, green: 115/255, blue: 227/255)
    
    func calculateGpa() -> Double {
        var totalGradePoints = 0.0
        var totalUnits = 0.0
        
        for course in viewModel.courseList {
            if course.units != 0 {
                if let points = gradePointsMapping[course.grade] ?? nil {
                    totalGradePoints += points * Double(course.units)
                }
                totalUnits += Double(course.units)
            }
        }
        
        return (totalUnits == 0) ? 0.0 : (totalGradePoints / totalUnits)
    }
    
    var body: some View {
        NavigationView {
            ZStack{LinearGradient(gradient: Gradient(colors: [purple,pink]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    if viewModel.courseList.isEmpty {
                        Text("You have no saved courses.")
                        Text("Navigate to My Courses to add one").foregroundColor(.gray)
                    }
                    else {
                        Text("Based on your courses below, your GPA is:")
                        Text(String(calculateGpa()))
                        
                        List {
                            ForEach(viewModel.courseList, id: \.id) { course in
                                HStack {
                                    Text(course.courseName.uppercased())
                                    Spacer()
                                    
                                    Text("Grade: " + course.grade)
                                        .padding(.horizontal)
                                    
                                    Text("Units: " + String(course.units))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("GPA Calculator")
        }
        
    }
}

