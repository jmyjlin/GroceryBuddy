//
//  ContentView.swift
//  GroceryBuddy
//
//  Created by Jimmy Lin on 5/19/26.
//

import SwiftUI

struct GroceryItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
}

@Observable
class GroceryItems {
    var items = [GroceryItem]() {
        didSet {
            if let encoded = try? JSONEncoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([GroceryItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
