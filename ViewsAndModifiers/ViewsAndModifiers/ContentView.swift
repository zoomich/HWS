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

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}


struct ContentView3: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")

        }
    }
}

//Custom modifiers
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView4: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello World")
                .modifier(Title())
            Text("Hello World2")
                .titleStyle()
            Text("Hello World3")
                 Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")

        }
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
//        ContentView2()
//        ContentView3()
        ContentView4()
    }
}
