//
//  DoublePickerTextField.swift
//  SubsReminder
//
//  Created by Владислав Харин on 15.01.2022.
//

import Foundation

import SwiftUI

class DoublePickerTextField: UITextField {
    var data: [String]
    var data2: [String]
    @Binding var selectionIndex: Int
    @Binding var selectionIndex2: Int
        
    init(data: [String], data2: [String], selectionIndex: Binding<Int>, selectionIndex2: Binding<Int>) {
        self.data = data
        self._selectionIndex = selectionIndex
        self.data2 = data2
        self._selectionIndex2 = selectionIndex2
        
        super.init(frame: .zero)

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
            
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.inputAccessoryView = toolBar
        self.inputView = pickerView
        self.tintColor = .clear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(selectionIndex, inComponent: 0, animated: false)
        pickerView.selectRow(selectionIndex2, inComponent: 1, animated: false)
        return pickerView
    }()

    @objc private func donePressed() {
        self.selectionIndex = self.pickerView.selectedRow(inComponent: 0)
        self.selectionIndex2 = self.pickerView.selectedRow(inComponent: 1)
        self.endEditing(true)
    }
}

extension DoublePickerTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return data.count
        } else {
            return data2.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if component == 0 {
            return data[row]
        } else {
            return data2[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.selectionIndex = row
        } else {
            self.selectionIndex2 = row
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
        
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        .zero
    }
}
