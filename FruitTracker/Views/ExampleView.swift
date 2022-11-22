//
//  ExampleView.swift
//  FruitTracker
//
//  Created by Alexandra Baker on 22/11/2022.
//

import SwiftUI

struct ExampleView: View {
    var inputArray: [String] = [
        "Andrew",
        "Zara",
        "Laura",
        "Adam",
        "David"
    ]
    @State var groupedArray: [String: [String]] = [:]
    
    var body: some View {
        List {
            ForEach(groupedArray.keys.sorted(), id: \.self) {key in
                Section(header: Text(key)) {
                    ForEach(groupedArray[key]!, id: \.self) {value in
                        Text(value)
                    }
                }
            }
        }
        .onAppear {
            groupedArray = Dictionary(
                grouping: inputArray,
                by: {$0.first?.uppercased() ?? ""}
            ).mapValues{$0.sorted()}
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
