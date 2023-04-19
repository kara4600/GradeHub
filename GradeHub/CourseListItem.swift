import SwiftUI

struct CourseListItem: Identifiable {
    var id: String = UUID().uuidString
    var courseName: String
    var units: Int
    var grade: String
}
