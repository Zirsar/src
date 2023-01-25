//
//  NoItemsView.swift
//  SubsReminder
//

import SwiftUI

struct NoItemsView: View {
    @State var animate: Bool = false
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Add your first subscription!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Please, click on add button!")
                    .padding(.bottom, 10)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("NoItemsTitle")
        }
    }
}
#endif
