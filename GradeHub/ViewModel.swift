import SwiftUI
import FirebaseAuth

class ViewModel: ObservableObject {
    @Published var loggedIn: Bool
    @Published var courseList: [CourseListItem]
    
    init() {
        self.loggedIn = false
        self.courseList = [CourseListItem]()
    }
    
    func signUp(email: String, password: String) {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error!)
                }
                else {
                    print("Sign up successful!")
                    DispatchQueue.main.async {
                        self.loggedIn = true
                    }
                }
            }
        }
    }
    
    func login(email: String, password: String) {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error != nil {
                        print(error!)
                    }
                    else {
                        print("Login successful!")
                        DispatchQueue.main.async {
                            self.loggedIn = true
                        }
                    }
                }
            }
        }
    
    func addCourseListItem(newCourse: CourseListItem) {
        self.courseList.append(newCourse)
    }
}
