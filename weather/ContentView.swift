//
//  ContentView.swift
//  weather
//
//  Created by wtao on 5/27/20.
//  Copyright © 2020 wtao. All rights reserved.
//

import SwiftUI

struct ContentView: View {
     @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        List(viewModel.weatherItems) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                Text(item.temp)
                Image(item.icon).frame(width: 30, height: 30)
            }
        }.onAppear(perform: viewModel.loadModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
