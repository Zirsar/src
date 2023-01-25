//
//  SubscribeRowView.swift
//  SubsReminder
//
//  Created by Владислав Харин on 13.01.2022.
//

import SwiftUI

struct SubscribeRowView: View {
    let item: SubscribeModel
    var body: some View {
        HStack {
            Image(item.icon)
                .resizable()
                .frame(width: 30, height: 30)
            Text(item.name)
                .font(.headline)
                .padding(.leading, 6)
            Spacer()
        }
        .foregroundColor(item.color == Color.white ? .black :.primary)
        .padding()
        .background(item.color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#if DEBUG
struct SubscribeRowView_Previews: PreviewProvider {
    static var previewItem1 = SubscribeModel(name: "YouTube", icon: "youtube", color: Color.red)
    static var previews: some View {
        SubscribeRowView(item: previewItem1)
    }
}
#endif
