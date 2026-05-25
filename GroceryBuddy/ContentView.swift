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
            if let encoded = try? JSONEncoder().encode(items) {
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
    @State private var groceries = GroceryItems()
    @State private var showAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                let produceItems = groceries.items.filter {
                    $0.type == "Produce"
                }
                let dairyItems = groceries.items.filter {
                    $0.type == "Dairy"
                }
                let meatItems = groceries.items.filter {
                    $0.type == "Meat"
                }
                let frozenItems = groceries.items.filter {
                    $0.type == "Frozen"
                }
                let snackItems = groceries.items.filter {
                    $0.type == "Snacks"
                }
                let drinkItems = groceries.items.filter {
                    $0.type == "Drinks"
                }
                let bakeryItems = groceries.items.filter {
                    $0.type == "Bakery"
                }
                let householdItems = groceries.items.filter {
                    $0.type == "Household"
                }
                let personalItems = groceries.items.filter {
                    $0.type == "Personal Care"
                }
                let otherItems = groceries.items.filter {
                    $0.type == "Other"
                }
                if !produceItems.isEmpty {
                    Section("Produce") {
                        ForEach(produceItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: produceItems)
                        }
                    }
                }
                if !dairyItems.isEmpty {
                    Section("Dairy") {
                        ForEach(dairyItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: dairyItems)
                        }
                    }
                }
                if !meatItems.isEmpty {
                    Section("Meat") {
                        ForEach(meatItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: meatItems)
                        }
                    }
                }
                if !frozenItems.isEmpty {
                    Section("Frozen") {
                        ForEach(frozenItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: frozenItems)
                        }
                    }
                }
                if !snackItems.isEmpty {
                    Section("Snacks") {
                        ForEach(snackItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: snackItems)
                        }
                    }
                }
                if !drinkItems.isEmpty {
                    Section("Drinks") {
                        ForEach(drinkItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: drinkItems)
                        }
                    }
                }
                if !bakeryItems.isEmpty {
                    Section("Bakery") {
                        ForEach(bakeryItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: bakeryItems)
                        }
                    }
                }
                if !householdItems.isEmpty {
                    Section("Household") {
                        ForEach(householdItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: householdItems)
                        }
                    }
                }
                if !personalItems.isEmpty {
                    Section("Personal Care") {
                        ForEach(personalItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: personalItems)
                        }
                    }
                }
                if !otherItems.isEmpty {
                    Section("Other") {
                        ForEach(otherItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, from: otherItems)
                        }
                    }
                }
            }
            .navigationTitle("Grocery Buddy")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showAddScreen = true
                }
            }
            .sheet(isPresented: $showAddScreen) {
                AddView(groceries: groceries)
            }
        }
    }
    func removeItems(at offsets: IndexSet, from filtered: [GroceryItem]) {
        for index in offsets {
            let item = filtered[index]
            
            if let original = groceries.items.firstIndex(where: { $0.id == item.id }) {
                groceries.items.remove(at: original)
            }
        }
    }
}

#Preview("List Screen") {
    ContentView()
}
