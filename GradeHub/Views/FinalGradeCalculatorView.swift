import SwiftUI

struct FinalGradeCalculatorView: View {
    @State var currentPercent: Double = 0
    @State var desiredPercent: Double = 0
    @State var finalExamWorth: Double = 1
    @State private var showingAlert = false
    
    func calculateMinScore() -> Double {
        return (100 * desiredPercent - (100 - finalExamWorth) * currentPercent) / finalExamWorth
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Determine what grade percentage you need on your final exam to get your desired grade")
                
                HStack {
                    Text("Current grade %:")
                        .padding()
                    TextField("Current grade", value: $currentPercent, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Text("Desired grade %:")
                        .padding()
                    TextField("Desired grade", value: $desiredPercent, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Text("Final Exam Worth %:")
                        .padding()
                    TextField("Final Exam Worth", value: $finalExamWorth, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding(.horizontal)
                }
                
                Button("Calculate") {
                    showingAlert = true
                }
                .buttonStyle(GrowingButton())
                .alert("You need at least " + String(calculateMinScore()) + "% on your exam!", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
            }
        }
        .navigationTitle("Final Grade Calculator")
    }
}
