import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    @State private var textField = ""
    @State var doubleValue: Double?
    @State private var weight: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                
                Image("drop")
                    .imageScale(.large)
                    .frame(width: 50, height: 28)
                    .padding()
                    .offset(x: -10.0, y: -20)
                
                Text("Hydrate")
                    .font(.title)
                    .bold()
                    .padding()
                    .offset(x: -10.0, y: -20)
                
                Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                    .foregroundStyle(.gray)
                    .font(.callout)
                    .padding()
                    .offset(x: -10.0, y: -30)
                
                HStack {
                    Text("Body Weight")
                        .padding()
                    TextField("Value", text: $textField)
                        .keyboardType(.decimalPad) // Use decimal pad for number input
                        .onChange(of: textField) { newValue in
                            // Allow only numeric input
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                textField = filtered // Update textField to only contain valid characters
                            }
                            // Convert the valid input to a Double
                            doubleValue = Double(filtered)
                        }
                    
                    Spacer()
                    // ClearButton
                    if !textField.isEmpty {
                        Button(action: {
                            textField = "" // Clear the text
                        }) {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                }
                .frame(width: 355, height: 44)
                .background(Color(red: 0.949, green: 0.949, blue: 0.971))
                .offset(y: -30)
                
                Spacer() // Pushes content to the bottom
                
                // Update the NavigationLink to pass the weight
                NavigationLink(destination: NotificationPrefrences(textField: textField)){
                    //                    todayProgress(weight: textField)
                 Text("Next")
            
                .frame(width: 355, height: 50)
                .background(Color(red: 0.192, green: 0.68, blue: 0.903))
                .foregroundStyle(.white)
                .cornerRadius(10)
                .disabled(textField.isEmpty) // Disable if textField is empty
                .opacity(textField.isEmpty ? 0.5 : 1.0) // Change opacity for visual feedback
                .onAppear {
                    // This is the first launch, set the state
                    hasLaunchedBefore = false
                }
            }
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ContentView()
}
