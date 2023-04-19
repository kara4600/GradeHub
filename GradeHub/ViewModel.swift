import SwiftUI

class ViewModel: ObservableObject {
    @Published var loggedIn: Bool
    @Published var courseList: [CourseListItem]
    
    init() {
        self.loggedIn = false
        self.courseList = [CourseListItem]()
    }
    
    func login(email: String, password: String) {
        self.loggedIn = true
    }
    
    func addCourseListItem(newCourse: CourseListItem) {
        self.courseList.append(newCourse)
    }
}
