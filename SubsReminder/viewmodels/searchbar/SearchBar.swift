//
//  SearchBar.swift
//  SubsReminder
//

import SwiftUI
 
struct SearchBar: View {
    @Binding var searchText: String
 
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search subscription...", text: $searchText)
                .background(Color(UIColor.secondarySystemBackground))
                .disableAutocorrection(true)
                .padding(7)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.dismissKeyboard()
                            searchText = ""
                        },
                    alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        .padding()
    }
}

extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
 }

/*
#if DEBUG
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
#endif
*/
