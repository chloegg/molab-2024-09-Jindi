//
//  ContentView.swift
//  Week4
//
//  Created by Jindi Chai on 10/3/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var selectedTime: Int = 60
    @State private var isTimerActive = false
    
    var body: some View {
        NavigationView {
            VStack {
              
                Text("Choose Focus Time")
                    .font(.headline)
                    .padding()
                
                Picker("time", selection: $selectedTime) {
                    Text("1 min").tag(60)
                    Text("5 min").tag(300)
                    Text("10 min").tag(600)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Start Focus Session bott
                NavigationLink(destination: TimerView(selectedTime: selectedTime)) {
                    Text("Start Focus Session")
                        .font(.title3)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Focus timer")
        }
    }
}

struct TimerView: View {
    let selectedTime: Int
    @State private var timeRemaining: Int
    @State private var timer: Timer? = nil
    @State private var showAlert = false
    @State private var audioPlayer: AVAudioPlayer?
    
    // Access to presentation mode to manually dismiss the view
    @Environment(\.presentationMode) var presentationMode
    
    init(selectedTime: Int) {
        self.selectedTime = selectedTime
        _timeRemaining = State(initialValue: selectedTime)
    }
    
    var body: some View {
        VStack {
            Text("Time remaining")
                .font(.headline)
                .padding()
            
            Text("\(timeString(from: timeRemaining))")
                .font(.system(size: 60, weight: .bold))
                .padding()

            Button("Stop timer") {
                stopTimer()
                presentationMode.wrappedValue.dismiss() // Dismiss the view manually
            }
            .font(.title)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear(perform: startTimer)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Time's Up！"), message: Text("Your focus time is over"), dismissButton: .default(Text("OK")))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            stopTimer()
            presentationMode.wrappedValue.dismiss() // Manually dismiss when tapping back
        }) {
            Text("Back")
        })
    }
    
    func startTimer() {
        if let path = Bundle.main.path(forResource: "focus_music", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("audio play error")
            }
        }
        
        // timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                showAlert = true
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        audioPlayer?.stop()
        timer = nil
    }
    
    // time to min:sec
    func timeString(from time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
