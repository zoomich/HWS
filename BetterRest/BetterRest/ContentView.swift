//
//  ContentView.swift
//  BetterRest
//
//  Created by Anton Kramarenko on 04.04.2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var wakeUp = defaultWakeTime
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents:
                        .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker(selection: $coffeeAmount, label: Text("")) {
                        ForEach(0..<21) {
                            Text(String($0))
                        }
                    }
//                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Your recommended bed time is: \(calculateBedTime())")
                        .font(.system(size: 15))
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedTime)
//            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }

    }
    
    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60 //we need in seconds
            let minutes = (components.minute ?? 0 ) * 60 * 60
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            // Something went wrong!
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
