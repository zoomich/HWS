//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Anton Kramarenko on 15.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Text("Hello, world!")
                .padding()
    //            .frame(maxWidth: .infinity, maxHeight: .infinity) - allows us to fill the whole scheen area instead
                .background(.red)
            
            //combining together
            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
            
            //button example
            Button("Hello, world!") {
                // do nothing
            }
            .frame(width: 200, height: 200)
            .background(.red)
            
        }
        
    }
}

struct ContentView2: View {
    
    @State private var useRedText = false

    var body: some View {
        
        //For example, if you had a property that could be either true or false, you could use that to control the foreground color of a button like this:
        Button("Hello World") {
                // flip the Boolean between true and false
                useRedText.toggle()
                }
                .foregroundColor(useRedText ? .red : .blue)
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        ContentView2()
    }
}
