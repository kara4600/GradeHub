import SwiftUI

struct CourseListView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var addCourseName: String = ""
    @State var addUnits: Int = 0
    @State var addGrade: String = "A"
    let gradeOptions = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
    let unitOptions = [0, 1, 2, 3, 4, 5]
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.courseList.isEmpty {
                    Text("You have no saved courses.")
                    Text("Add one below").foregroundColor(.gray)
                }
                else {
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
                        .onDelete(perform: deleteCourse)
                    }
                }

                TextField("Course Name", text:$addCourseName)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Select the number of units:")
                    Picker("Select units", selection: $addUnits) {
                        ForEach(unitOptions, id: \.self) { unitOption in
                            Text("\(unitOption)").tag(unitOption)
                        }
                    }
                    .pickerStyle(.menu)
                }

                HStack {
                    Text("Select a grade:")
                    Picker("Select a grade", selection: $addGrade) {
                        ForEach(gradeOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Button("Add Course") {
                    viewModel.addCourseListItem(newCourse: CourseListItem(courseName: addCourseName, units: addUnits, grade: addGrade))
                    addCourseName = ""
                    addUnits = 0
                    addGrade = "A"
                }
                .buttonStyle(GrowingButton())
            }
            .onAppear {
                viewModel.fetchCourses()
            }
            .navigationTitle("Your Courses")
        }
    }
    private func deleteCourse(at offsets: IndexSet) {
            offsets.forEach { index in
                let course = viewModel.courseList[index]
                viewModel.deleteCourse(courseId: course.id)
            }
        }
}
