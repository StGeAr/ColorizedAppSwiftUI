//
//  ContentView.swift
//  ColorizedAppSwiftUI
//
//  Created by Герман Ставицкий on 17.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @FocusState private var isTextFieldActive: Bool
    
    var body: some View {
        ZStack {
            Color(white: 0.7)
                .ignoresSafeArea()
                .onTapGesture { isTextFieldActive = false }
            VStack(spacing: 40) {
                ColorView(
                    redValue: redSliderValue,
                    greenValue: greenSliderValue,
                    blueValue: blueSliderValue
                )
                VStack {
                    ColorSliderView(value: $redSliderValue, sliderColor: .red)
                    ColorSliderView(value: $greenSliderValue, sliderColor: .green)
                    ColorSliderView(value: $blueSliderValue, sliderColor: .blue)
                }
                .focused($isTextFieldActive)
                .keyboardType(.numberPad)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Up") { }
                        Button("Dowm") { }
                        Spacer()
                        Button("Done") { isTextFieldActive = false }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    var body: some View {
        Color(
            red: redValue / 255,
            green: greenValue / 255,
            blue: blueValue / 255
        )
        .frame(height: 150)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 5)
        )
    }
}

struct TextView: View {
    let value: Double
    
    var body: some View {
        Text("\(lround(value))")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 40)
    }
}

struct TextFieldView: View {
    @Binding var text: String
    @Binding var value: Double
    
    @State private var alertPresented = false
    
    var body: some View {
        TextField("", text: $text) { _ in checkValue() }
            .frame(width: 50)
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .alert("Invalid color value", isPresented: $alertPresented, actions: {}) {
                Text("Please enter value from 0 to 255")
            }
    }
    
    private func checkValue() {
        if let value = Int(text), (0...255).contains(value) {
            self.value = Double(value)
            return
        }
        alertPresented.toggle()
        text = "0"
        value = 0
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    @State private var text = ""
    
    let sliderColor: Color
    
    var body: some View {
        HStack {
            TextView(value: value)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(sliderColor)
                .onChange(of: value) { newValue in text = "\(lround(newValue))" }
                .onAppear { text = "\(lround(value))" }
            TextFieldView(text: $text, value: $value)
        }
        
    }
}
