//
//  NotificationPrefrences.swift
//  Hydrate
//
//  Created by Maryam on 20/10/2024.
//

import SwiftUI

struct NotificationPrefrences: View {
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    
    @State private var selectedTime: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Notification Preferences")
                .font(.title2)
                .bold()
                .padding()
                
            
            VStack(alignment: .leading){
                Text("The start and End hour")
                    .bold()
                
             
                
                Text("Specify the start and end date to receive the notifications ")
                    .foregroundStyle(.gray)
                    
            }
            .padding()
            VStack{
                
                HStack{
                    Text("Start hour")
                        .offset(x:-66)
                    
                    DatePicker("Select Time", selection: $startTime, displayedComponents: [ .hourAndMinute])
                        .labelsHidden()
                        .offset(x:66)
                }
                .frame(width: 355, height: 44)
                
                Divider()
                    .frame(width: 323)
                
                HStack{
                    Text("End hour")
                    .offset(x:-70)
                    
                    
                    DatePicker("Select Time", selection: $endTime, displayedComponents: [ .hourAndMinute])
                        .labelsHidden()
                        .offset(x:70)
                        
                        
                        
                }
                .frame(width: 355, height: 44)
                
            }
            .frame(width: 355, height: 108)
            .background(Color(red: 0.949, green: 0.949, blue: 0.971))
            .padding()
            
            VStack(alignment: .leading){
                Text("Notification interval")
                    .bold()
                
                Text("How often would you like to receive notifications within the specified time interval")
                    .foregroundStyle(.gray)
                
            }
            .padding()
            
            VStack(spacing: 20) {
                        HStack(spacing: 20) {
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
                                        
                                        HStack(spacing: 20) {
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
            
            
            Button("Next"){
                //action
            }
            .frame(width: 355, height: 50 )
            .background(Color(red: 0.192, green: 0.68, blue: 0.903))
            .foregroundStyle(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}



#Preview {
    NotificationPrefrences()
}
