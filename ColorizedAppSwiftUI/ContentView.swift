//
//  ContentView.swift
//  ColorizedAppSwiftUI
//
//  Created by Герман Ставицкий on 17.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue: Double = 150
    @State private var greenSliderValue: Double = 100
    @State private var blueSliderValue: Double = 75
    
    var body: some View {
        VStack(spacing: 40) {
            ColorView(
                redValue: $redSliderValue,
                greenValue: $greenSliderValue,
                blueValue: $blueSliderValue
            )
            ColorSliderView(value: $redSliderValue, sliderColor: .red)
            ColorSliderView(value: $greenSliderValue, sliderColor: .green)
            ColorSliderView(value: $blueSliderValue, sliderColor: .blue)
            Spacer()
        }
        .padding()
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(white: 0.7)
                .ignoresSafeArea()
            ContentView()
        }
    }
}

struct ColorView: View {
    @Binding var redValue: Double
    @Binding var greenValue: Double
    @Binding var blueValue: Double
    
    var body: some View {
        Color(red: redValue / 255, green: greenValue / 255, blue: blueValue / 255)
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.white, lineWidth: 5)
            )
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    
    let sliderColor: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .font(.headline)
                .foregroundColor(.white)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(sliderColor)
            TextField("", text: .constant("\(lround(value))"))
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .font(.headline)
                .background(.white)
                .cornerRadius(10)
                .frame(width: 50)
                
        }
    }
}
