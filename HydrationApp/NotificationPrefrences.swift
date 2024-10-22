//
//  NotificationPrefrences.swift
//  Hydrate
//
//  Created by Maryam on 20/10/2024.
//

import SwiftUI
import UserNotifications

struct NotificationPrefrences: View {
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var isAM = true
    @State var textField: String
    @State private var navigateToProgress = false // State variable for navigation
    
    
    @State private var selectedTime: String = ""
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                
                Text("Notification Preferences")
                    .font(.system(size: 22))
                    .bold()
                    .padding()
                
                Spacer().frame(height: 3.2)
                
                
                VStack(alignment: .leading, spacing: 8){
                    Text("The start and End hour")
                        .bold()
                        .font(.system(size: 17))
                    
                    
                    Text("Specify the start and end date to receive the notifications ")
                        .foregroundColor(Color(red: 0.388, green: 0.388, blue: 0.401))
                        .font(.system(size: 16))
                }
                .padding()
                
                Spacer().frame(height: 22)
                
                VStack{
                    
                    HStack{
                        Text("Start hour")
                            .offset(x:-66)
                        
                        DatePicker("Select Time", selection: $startTime, displayedComponents: [ .hourAndMinute])
                            .labelsHidden()
                            .offset(x:66)
                        //
                        //                    Picker("", selection: $isAM) {
                        //                        Text("AM").tag(true) // Tag for AM
                        //                        Text("PM").tag(false) // Tag for PM
                        //                    }
                        //                    .pickerStyle(SegmentedPickerStyle())
                        //                    .frame(width: 120) // Adjust frame for the segmented picker }
                    }
                    .frame(width: 355, height: 44)
                    
                    Divider()
                        .frame(width: 323)
                    
                    HStack{
                        Text("End hour")
                            .offset(x:-70)
                        
                        
                        DatePicker("Select Time", selection: $endTime, displayedComponents: [.hourAndMinute])
                            .labelsHidden()
                            .offset(x:70)
                            .datePickerStyle(.automatic)
                        
                        
                        
                    }
                    .frame(width: 355, height: 44)
                    
                }
                .frame(width: 355, height: 108)
                .background(Color(red: 0.949, green: 0.949, blue: 0.971))
                .offset(x: 17)
                
                Spacer().frame(height: 30)
                
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Notification interval")
                        .bold()
                        .font(.system(size: 17))
                    
                    Text("How often would you like to receive notifications within the specified time interval")
                        .foregroundColor(Color(red: 0.388, green: 0.388, blue: 0.401))
                    
                        .font(.system(size: 16))
                }
                .offset(x: 17,y:10)
                
                Spacer().frame(height: 21)
                
                
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        TimerView(time: "15 Mins",isSelected: selectedTime == "15 Mins") {
                            selectedTime = "15 Mins"
                        }//                        TimerView(time: "30 Mins")
                        TimerView(time: "30 Mins", isSelected: selectedTime == "30 Mins") {
                            selectedTime = "30 Mins"
                        }
                        TimerView(time: "60 Mins", isSelected: selectedTime == "60 Mins") {
                            selectedTime = "60 Mins"
                        }
                        TimerView(time: "90 Mins", isSelected: selectedTime == "90 Mins") {
                            selectedTime = "90 Mins"
                        }
                    }
                    
                    HStack(spacing: 16) {
                        TimerView(time: "2 Hours", isSelected: selectedTime == "2 Hours") {
                            selectedTime = "2 Hours"
                        }
                        TimerView(time: "3 Hours", isSelected: selectedTime == "3 Hours") {
                            selectedTime = "3 Hours"
                        }
                        TimerView(time: "4 Hours", isSelected: selectedTime == "4 Hours") {
                            selectedTime = "4 Hours"
                        }
                        TimerView(time: "5 Hours", isSelected: selectedTime == "5 Hours") {
                            selectedTime = "5 Hours"
                        }
                    }
                }
                .padding()
                Spacer()
                
                Button(action: {
                    handleStartButtonTap()
                    
//                    hasLaunchedBefore = true // Update launch state
                }) {
                    Text("Start")
                        .frame(width: 355, height: 50 )
                        .background(Color(red: 0.192, green: 0.68, blue: 0.903))
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        .navigationBarBackButtonHidden()
                        .offset(x:20)
                }
                NavigationLink(destination: todayProgress(weight: textField), isActive: $navigateToProgress) {
                    EmptyView() // This is a hidden link that will activate based on state
                }
                
                //                NavigationLink(destination: todayProgress(weight: textField), isActive: $navigateToProgress){
                //
                //                    Text("Start")
                //                        .frame(width: 355, height: 50 )
                //                        .background(Color(red: 0.192, green: 0.68, blue: 0.903))
                //                        .foregroundStyle(.white)
                //                        .cornerRadius(10)
                //                        .navigationBarBackButtonHidden()
                //                        .offset(x:20)
                //                        .onTapGesture {
                //                            handleStartButtonTap()
                //
                //                        }
                //                }
                
                
                
                
                
            }
            .padding()
            
        }
        .navigationBarBackButtonHidden()
    }
    
    
    
        private func handleStartButtonTap() {
            requestNotificationPermission { granted in
                if granted {
                    scheduleNotifications()
                    navigateToProgress = true // Navigate after scheduling notifications
                } else {
                    print("Notification permission denied.")
                }
            }
        }
    
    private func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                // Request permission
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                    if let error = error {
                        print("Error requesting notifications: \(error.localizedDescription)")
                    }
                    completion(granted)
                }
            case .denied:
                print("Notification permission denied.")
                completion(false)
            case .authorized:
                print("Notification permission already granted.")
                completion(true)
            default:
                completion(false)
            }
        }
    }
    
    // Function to schedule notifications
    private func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() // Clear existing notifications

        let content = UNMutableNotificationContent()
        content.title = "Time to Hydrate!"
        content.body = "Don't forget to drink water!"
        content.sound = .default

        // Schedule notification to trigger after 5 seconds for testing
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }
    // Function to get a random notification message
//    func getRandomNotificationMessage() -> String {
//        let messages = [
//            "Hey there! It's time to hydrate. You're close to reaching today's water goal. Take a sip to stay on track!",
//            "Great job on staying hydrated! Keep up the good work. Every sip brings you closer to your health goals!",
//            "You're almost there! Just a few more sips to go to reach today's water goal. You're doing fantastic!"
//        ]
//        return messages.randomElement() ?? "Stay hydrated!"
//    }
    
    
    // Function to get interval in minutes based on selected time
    func getIntervalInMinutes(from selectedTime: String) -> Int? {
        switch selectedTime {
        case "15 Mins": return 15
        case "30 Mins": return 30
        case "60 Mins": return 60
        case "90 Mins": return 90
        case "2 Hours": return 120
        case "3 Hours": return 180
        case "4 Hours": return 240
        case "5 Hours": return 300
        default: return nil
        }
    }
    
    
    
}

struct TimerView: View {
    let time: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        let components = time.split(separator: " ")
        let number = String(components[0])
        let unit = components.count > 1 ? String(components[1]) : ""
        
        return VStack{
            VStack(spacing: 4){
                Text(number)
                    .font(.system(size: 17))
                
                
                    .foregroundColor(isSelected ? .white :
                                        Color(red: 0.192, green: 0.68, blue: 0.903)) // Number in blue
                
                Text(unit)
                    .font(.system(size: 17))
                
                
                    .foregroundColor(isSelected ? .white : .black) // Unit in black
            }
            .frame(width: 77, height: 70)
        }
        
        .frame(width: 77, height: 70)
        .background(isSelected ?  Color(red: 0.192, green: 0.68, blue: 0.903): Color(red: 0.949, green: 0.949, blue: 0.971))
        
        .cornerRadius(10)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    NotificationPrefrences(textField: "70")
}
