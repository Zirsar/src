//
//  DoublePickerField.swift
//  SubsReminder
//
//

import SwiftUI


import Foundation
import SwiftUI

struct DoublePickerField: UIViewRepresentable {
    @Binding var selectionIndex: Int
    @Binding var selectionIndex2: Int
    private var placeholder: String
    private var data: [String]
    private var data2: [String]
    private let textField: DoublePickerTextField
    
    init<S>(_ title: S, data: [String], data2: [String], selectionIndex: Binding<Int>, selectionIndex2: Binding<Int>) where S: StringProtocol {
        self.placeholder = String(title)
        self.data = data
        self.data2 = data2
        self._selectionIndex = selectionIndex
        self._selectionIndex2 = selectionIndex2
        
        textField = DoublePickerTextField(data: data, data2: data2, selectionIndex: selectionIndex, selectionIndex2: selectionIndex2)
    }

    func makeUIView(context: UIViewRepresentableContext<DoublePickerField>) -> UITextField {
        textField.placeholder = placeholder
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<DoublePickerField>) {
        if selectionIndex >= 0 && selectionIndex2 >= 0 {
            uiView.text = data[selectionIndex] + " " + data2[selectionIndex2].lowercased()
       } else {
            uiView.text = ""
        }
    }
}
