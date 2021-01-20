//
//  ContentView.swift
//  DemoBlog
//
//  Created by Pierre Felgines on 16/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Base url: \(Environment.current.baseUrl)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
