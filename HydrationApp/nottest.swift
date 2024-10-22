//
//  nottest.swift
//  Hydrate
//
//  Created by Maryam on 22/10/2024.
//

import SwiftUI

struct nottest: View {
    @State private var selectedTime: String = ""

    var body: some View {
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
        
        return VStack {
            VStack{
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
        .padding(20)
        .frame(width: 77, height: 70)
        .background(isSelected ?  Color(red: 0.192, green: 0.68, blue: 0.903): Color(red: 0.949, green: 0.949, blue: 0.971))
        
        .cornerRadius(10)
        .onTapGesture {
            onTap()
        }
    }
}





//struct TimerView: View {
//    let time: String
//
//    var body: some View {
//        VStack() {
//            Text(time)
//                .font(.caption2)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.center)
//
//        }
//        .padding(20)
//        .frame(width: 77, height: 70)
//        .background(Color(red: 0.949, green: 0.949, blue: 0.971))
//        //.foregroundColor(.white)
//        .cornerRadius(10)
//    }
//}

#Preview {
    nottest()
}
