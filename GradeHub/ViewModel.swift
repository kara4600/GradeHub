import SwiftUI
import FirebaseAuth
import FirebaseFirestore


class ViewModel: ObservableObject {
    @Published var loggedIn: Bool
    @Published var courseList: [CourseListItem]
    @Published var errorMessage: String? = nil
    
    init() {
        self.loggedIn = false
        self.courseList = [CourseListItem]()
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.loggedIn = true
                self.errorMessage = nil
            }
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.loggedIn = true
                self.errorMessage = nil
            }
        }
    }

    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.loggedIn = false
            print("Sucessfully signed out")
        } catch let error as NSError{
            print("Sign out error")
        }
    }
    
    func saveUserData(userId: String, email: String){
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)
        
        let userData: [String: Any] = [
            "email": email
        ]
        
        userRef.setData(userData){ error in
            if let error = error{
                print("Error saving user data")
            } else{
                print("User data saved sucessfully")
            }
        }
    }
    
    func fetchCourses(){
        //if somehow we fetch courses with no user logged in
        guard let userId = Auth.auth().currentUser?.uid else{
            print("This should never print")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("courses").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No courses found")
                    return
                }

                self.courseList = documents.map { documentSnapshot -> CourseListItem in
                    let data = documentSnapshot.data()
                    let id = documentSnapshot.documentID
                    let courseName = data["courseName"] as? String ?? ""
                    let units = data["units"] as? Int ?? 0
                    let grade = data["grade"] as? String ?? "A"
                    return CourseListItem(id: id, courseName: courseName, units: units, grade: grade)
                }
            }
    }
    
    func addCourseListItem(newCourse: CourseListItem) {
        //if we are adding a course with no user logged in
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Should never run")
            return
        }

        let db = Firestore.firestore()
        let courseData: [String: Any] = [
            "courseName": newCourse.courseName,
            "units": newCourse.units,
            "grade": newCourse.grade
        ]

        db.collection("users").document(userId).collection("courses").addDocument(data: courseData) { error in
            if let error = error {
                print("could not add course \(error)")
            } else {
                print("Course added successfully")
            }
        }
    }
    
    func deleteCourse(courseId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("error with user authentication")
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("courses").document(courseId).delete { error in
            if let error = error {
                print("Error deleting course: \(error)")
            } else {
                print("Course deleted successfully")
            }
        }
    }


}
