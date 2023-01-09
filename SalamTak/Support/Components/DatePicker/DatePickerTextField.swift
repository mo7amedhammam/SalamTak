//
//  DatePickerTextField.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 1/11/22.
//

import Foundation
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    
    public var placeholder: String
    @Binding var date: Date?
//    @ObservedObject var docvm = ViewModelCreatePatientProfile()
    
    var datef:DateFormatter{
        let df = DateFormatter()
        df.dateFormat = "yyyy/mm/dd"
        return df
    }
    
    func makeUIView(context: Context) -> some UITextField {
        
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        toolbar.setItems([flexibleSpace,doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
        
        
        self.helper.dateChanged =  {
            self.date = self.datePicker.date
//            self.docvm.Birthday = self.datePicker.date
//            self.docvm.Birthday = datef.string(from: datePicker.date)

        }
        self.helper.doneButtonTapped =  {
            if self.date == nil {
                self.date = self.datePicker.date
//                self.docvm.Birthday = self.datePicker.date
//                self.docvm.Birthday = datef.string(from: datePicker.date)

//                self.docvm.Birthday = datef.string(from: date ?? Date())
                
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedDate = self.date {
            uiView.text = self.dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        public var dateChanged: (() -> Void)?
        public var doneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            self.dateChanged?()
        }
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator {
        
    }
}


extension Date {
        func formatDate() -> String {
                let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy/mm/dd")
            return dateFormatter.string(from: self)
        }
}

