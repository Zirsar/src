//
//  ListView.swift
//  SubsReminder
//
//  Created by Владислав Харин on 11.01.2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }
            List {
                ForEach($listViewModel.items) { $item in
                    NavigationLink(destination: SubscribeView(item: $item)) {
                        ListRowView(item: item)
                    }
                    .padding() //.padding(.vertical, 8)
                    // .listRowBackground(Color.green
                                  //      .clipped()
                                    //    .cornerRadius(20))
                    //.clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .onDelete(perform: listViewModel.deleteItem)
                .onMove(perform: listViewModel.moveItem)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("My subscriptions")
        .navigationBarItems(
            leading: EditButton())
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0 // сброс Badge
        }
    }
}

#if DEBUG
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
#endif
