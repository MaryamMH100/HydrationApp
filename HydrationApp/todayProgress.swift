import SwiftUI

struct todayProgress: View {
    var weight: String // Accept weight as a parameter
    @State private var progressValue: Float = 0.0
    private let userDefaultsKey = "waterIntakeProgress"
       private let lastSavedDateKey = "lastSavedDate"

    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Today's Water Intake")
                    .foregroundColor(Color(red: 0.388, green: 0.388, blue: 0.401))
                
                // Calculate max intake based on weight
                let maxIntake = calculateMaxIntake(from: weight)
                
                // Calculate current intake
                let currentIntake = progressValue * maxIntake
                
                HStack {
                    Text("\(String(format: "%.1f", currentIntake)) liters")
                        .font(.title2)
                        .bold()
                        .foregroundColor(currentIntake >= maxIntake ? .green : .primary) // Current intake color
                    Text("/ \(String(format: "%.1f", maxIntake)) liters")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary) // Max intake color stays default
                }
                
                
            }
            .offset(x: -85, y: -90)
            
            ProgressBar(progress: self.$progressValue)
                .frame(width: 313, height: 313)
                .padding(20)
                .onAppear {
                    self.progressValue = 0
                }
            
            Text("\(String(format: "%.1f", progressValue * calculateMaxIntake(from: weight))) L")
                .font(.title2)
                .bold()
                .offset(x:5 ,y: 75)
            
            // Stepper for water intake
            Stepper("", value: $progressValue, in: 0...1, step: 0.1)
                .padding()
                .onChange(of: progressValue) { newValue in
                    if newValue > 1 {
                        progressValue = 1
                    }
                }
                .offset(x:-130, y: 70.6)
        }
        .navigationBarBackButtonHidden()
    }
    
    // Function to calculate the maximum intake based on weight
    private func calculateMaxIntake(from weight: String) -> Float {
        if let weightValue = Float(weight) {
            return weightValue * 0.03
        }
        return 0.0 // Return 0 if the weight is invalid
    }
    
    // Load progress from UserDefaults
        private func loadProgress() {
            let savedDate = UserDefaults.standard.string(forKey: lastSavedDateKey) ?? ""
            let todayDate = getCurrentDate()

            // Check if the saved date is today
            if savedDate == todayDate {
                progressValue = UserDefaults.standard.float(forKey: userDefaultsKey)
            } else {
                // Reset progress if it's a new day
                progressValue = 0.0
                saveProgress() // Save the reset value
            }
        }

    // Save progress to UserDefaults
       private func saveProgress() {
           UserDefaults.standard.set(progressValue, forKey: userDefaultsKey)
           UserDefaults.standard.set(getCurrentDate(), forKey: lastSavedDateKey)
       }
       
       // Get current date as a string in "yyyy-MM-dd" format
       private func getCurrentDate() -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter.string(from: Date())
       }
    
    
   }
    
    
    


struct ProgressBar: View {
    @Binding var progress: Float
    var color: Color = Color(red: 0.192, green: 0.68, blue: 0.903)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 33.0)
                .foregroundColor(Color(red: 0.933, green: 0.933, blue: 0.942))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 33.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0))
            
            Image(imageForProgress(progress))
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 70)
        }
    }
    
    func imageForProgress(_ progress: Float) -> String {
        switch progress {
        case 0.0:
            return "Status0"
        case 0.1...0.30:
            return "Status30"
        case 0.31...0.99:
            return "Status80"
        case 1.0:
            return "Status100"
        default:
            return "Status0"
        }
    }
}

#Preview {
    todayProgress(weight: "textField")
    //    ContentView()
}
