//
//  AddView.swift
//  SubsReminder
//
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    var model: SubscribeViewModel = SubscribeViewModel()
    @State var searchQuery = ""
    var body: some View {
        VStack {
            List {
                ForEach(searchQuery == "" ? model.items : model.items.filter{$0.name.lowercased().contains(searchQuery.lowercased())}) { sub in
                    NavigationLink(destination: CreateSubscribeView(sub: sub)) {
                        SubscribeRowView(item: sub)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Add new subscription")
        }
    }
}


#if DEBUG
 struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }.environmentObject(ListViewModel())
    }
}
#endif
