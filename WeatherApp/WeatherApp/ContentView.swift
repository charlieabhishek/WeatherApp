//
//  ContentView.swift
//  WeatherApp
//
//  Created by Abhishek Kumar on 30/06/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var input: String = ""
    @ObservedObject var weatherViewModel: WeatherViewModel = WeatherViewModel()
    var body: some View {
        VStack{
            TextField("Enter City", text: $input, onEditingChanged: { (_) in
                
            }, onCommit: {
                if !self.input.isEmpty {
                    self.weatherViewModel.fetch(city: self.input)
                }
            })
                .font(.title)
            
            Divider()
            
            Text(weatherViewModel.weatherInfo)
                .font(.body)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
