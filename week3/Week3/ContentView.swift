//
//  ContentView.swift
//  Week3
//
//  Created by Jindi Chai on 9/26/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🍊", "🍋", "🍎", "🍐", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅"]

    @State private var currentEmoji = "❓"
    @State private var backgroundColor = Color.white

    var body: some View {
        NavigationStack{
            ZStack {
                // Background color
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Display the current emoji
                    Text(currentEmoji)
                        .font(.system(size: 280)) 
                        .padding()
                    
                    Button(action: {
                        currentEmoji = emojis.randomElement() ?? "🍊"
                        backgroundColor = Color(
                            red: Double.random(in: 0...1),
                            green: Double.random(in: 0...1),
                            blue: Double.random(in: 0...1)
                        )
                    }) {
                        Text("GET!")
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Get Today's Lucky Foods and Colors")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            // randomize the emoji and background color when the view appears
            currentEmoji = emojis.randomElement() ?? "🍊"
            backgroundColor = Color(
                red: Double.random(in: 0...1),
                green: Double.random(in: 0...1),
                blue: Double.random(in: 0...1)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
