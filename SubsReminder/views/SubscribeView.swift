//
//  SubscribeView.swift
//  SubsReminder
//
//

import SwiftUI

struct SubscribeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var item: ItemModel
    @State var clone: ItemModel = ItemModel(name: "", price: "", notes: "", currency: SettingsView.currency, cycleId: Cycle.month, date: Date(), notifyMe:  1, isTrial: false, isFamily: false)
    // var cycleIntArray = Array(1...30)
    @State var cycle: Int = 0
    @State var cycleInt: Int = 0
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var placeHolderText: String = "Enter notes here..."
    
    var body: some View {
        List {
                Section {
                    VStack(spacing: 20) {
                        Group {
                            HStack {
                                Text("Name:")
                                Spacer()
                                TextField("My subscription", text: $clone.name)
                                    .multilineTextAlignment(.trailing)
                            }
                    
                            Divider()
                            HStack {
                                Text("Price:")
                                Spacer()
                                TextField("0.00", text: $clone.price)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                        
                            Divider()
                            HStack {
                                Text("Currency:")
                                Spacer()
                                PickerField("", data: Constants.currenciesArray, selectionIndex: $clone.currency).fixedSize()
                            }
                    
                            Divider()
                            HStack {
                                Text("Cycle:")
                                Spacer()
                                DoublePickerField("", data: Constants.everyArray /* cycleIntArray.map(String.init) */, data2: Constants.cycleArray, selectionIndex: $cycleInt, selectionIndex2: $cycle).fixedSize()
                            }
                    }
                        Group {
                            Divider()
                            HStack {
                                DatePicker("Date:", selection: $clone.date, displayedComponents: .date)
                            }
                            
                            Divider()
                            HStack {
                                Text("Notify me:")
                                Spacer()
                                PickerField("", data: Constants.notifyMeArray, selectionIndex: $clone.notifyMe).fixedSize()
                            }
                    
                            Divider()
                            HStack {
                                Toggle("Trial period:", isOn: $clone.isTrial)
                            }
                            
                            Divider()
                            HStack {
                                Text("Type:")
                                Spacer()
                                Text(clone.isFamily ? "Family" : "Individual").onTapGesture {
                                    clone.isFamily.toggle()
                                    HapticManager.instance.impact(style: .soft)
                                }
                            }
                    }
                    }
                    .animation(.none)
                    .padding()
                    .font(.headline)
                }
            
            Section {
                ZStack(alignment: .leading) {
                    if clone.notes.isEmpty {
                        TextEditor(text: $placeHolderText)
                            .font(.custom("Helvetica", size: 24))
                            .padding(.all)
                    }
                    
                    TextEditor(text: $clone.notes)
                        .font(.custom("Helvetica", size: 24))
                        .padding(.all)
                }
            }
    }
        .navigationTitle("Subscription editor")
        .toolbar {
            Button("Save") {
                saveButtonPressed()
            }
        }
        .onAppear(perform: onViewAppear)
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func onViewAppear() {
        clone = item
        cycle = clone.cycleId.rawValue
    }
    
    func saveButtonPressed() {
        if(priceCorrector()) {
            clone.cycleId = Cycle(rawValue: cycle) ?? Cycle.month
            item = clone
            NotificationManager.instance.updateNotification(subscription: item)
            presentationMode.wrappedValue.dismiss()
        } else {
            alertTitle = "Please, enter price!"
            showAlert.toggle()
        }
    }
    
    func priceCorrector() -> Bool {
        return clone.price.count > 0
    }
    
    func getAlert() -> Alert {
        HapticManager.instance.notification(type: .error)
        return Alert(title: Text(alertTitle))
    }
}

/* #if DEBUG
struct SubscribeView_Previews: PreviewProvider {
    static var previewItem1 = ItemModel(title: "Preview Item 1", notes: "notes of 1", date: DateComponents(), isCompleted: false)
    static var previews: some View {
        SubscribeView(/*item: previewItem1*/)
    }
}
#endif */
