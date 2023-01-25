//
//  ListRowView.swift
//  SubsReminder
//
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    var body: some View {
        HStack {
            Image(item.icon)
                .resizable()
                .frame(width: 30, height: 30)
            Text(item.name)
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.accentColor)
            Spacer()
            VStack(alignment: .trailing) {
                Text(item.price + Constants.currencies[item.currency])
                    .bold()
                    .foregroundColor(Color.accentColor)
            }
        }
    }
}

#if DEBUG
struct ListRowView_Previews: PreviewProvider {
    static var previewItem1 = ItemModel(name: "Preview Item 1", price: "149", notes: "notes of 1", currency: 0, cycleId: Cycle.month, date: Date(), notifyMe: 1, isTrial: false, isFamily: false)
    static var previewItem2 = ItemModel(name: "Preview Item 2", price: "149", notes: "notes of 2", currency: 0, cycleId: Cycle.month, date: Date(), notifyMe: 1, isTrial: true, isFamily: false)
    static var previews: some View {
        Group {
            ListRowView(item: previewItem1)
            ListRowView(item: previewItem2)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
