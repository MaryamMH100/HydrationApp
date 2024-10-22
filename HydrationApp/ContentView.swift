//
//  ContentView.swift
//  Hydrate
//
//  Created by Maryam on 20/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var textField = ""
    var body: some View {
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
                //.position(x: 17.0, y: 266.0)
                .offset(x: -10.0, y: -20)
                
            
                
            
            Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                .foregroundStyle(.gray)
                .font(.callout)
                .padding()
                .offset(x: -10.0 , y: -30)

                
                
            
            HStack{
                
                Text("Body Weight")
                    .padding()
                TextField( "Vlaue", text: $textField)
                
                    Spacer()
                //ClearButton
                    if !textField.isEmpty {
                        Button(action: {
                            textField = "" // Clear the text
                        }) {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                //End ClearButton Code
                    
                    
            }
            .frame(width: 355, height: 44)
            .background(Color(red: 0.949, green: 0.949, blue: 0.971))
            .offset( y: -30)
            
            
            
            Spacer() // Pushes content to the bottom
            
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
        ContentView()
    }

