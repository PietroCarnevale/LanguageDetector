//
//  ContentView.swift
//  LanguageDetector
//
//  Created by Pietro Carnevale on 16/11/23.
//

import SwiftUI
import CoreML

let mlModel = LanguageDetectorModel()
//ciao


struct MainView: View {
    
    @State private var sentence: String = ""
    @State private var answer: String = "Here you will see the answer!"
    @State private var pulseAnimation: Bool = false
    
    var body: some View {
        NavigationStack{
            Image(systemName: "globe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(80)
                .foregroundStyle(.blue)
                .symbolEffect(.pulse, value: pulseAnimation)
                .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            HStack {
                TextField("Write here...", text: $sentence)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    sentence = ""
                    answer = "Here you will see the answer!"
                }, label: {
                    Text("CLEAR")
                })
                Spacer()
            }
            Button(action: {
                let expectedValue = try? mlModel.prediction(text: sentence)
                pulseAnimation.toggle()
                answer = expectedValue!.label
            }, label: {
                Text("DETECT")
                    .bold()
            })
            .padding()
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            Text(answer)
                .font(.title3)
                .padding()
            Spacer()
            .navigationTitle("Language Detector")
        }
    }
}

#Preview {
    MainView()
}
