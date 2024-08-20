//
//  FilterPopupView.swift
//  
//
//  Created by Softsuave on 24/06/24.
//

import SwiftUI

@available(iOS 14.0, *)
struct FilterPopupView: View {
    @Binding var filterOptions: [String: [String]]
    @Binding var selectedFilters: [String]
    @Binding var presented: Bool
    @State var filterHeaderText: String = "Filter Options"

    var body: some View {
        NavigationView {
            List {
                ForEach(filterOptions.keys.sorted(), id: \.self) { category in
                    Section(header: Text(category)) {
                        ForEach(filterOptions[category]!, id: \.self) { option in
                            MultipleSelectionRow(option: option, isSelected: selectedFilters.contains(option)) {
                                if selectedFilters.contains(option) {
                                    selectedFilters.removeAll { $0 == option }
                                } else {
                                    selectedFilters.append(option)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(filterHeaderText)
            .navigationBarItems(trailing: Button("Done") {
                presented.toggle()
            })
        }
    }
}

@available(iOS 13.0.0, *)
struct MultipleSelectionRow: View {
    var option: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Text(option)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
