//
//  DateOfBirthView.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 1/11/22.
//

import SwiftUI

struct DateOfBirthView: View {
    var language = LocalizationService.shared.language
    @Binding var date: Date?
    let screenWidth = UIScreen.main.bounds.size.width - 55
    var body: some View {
        HStack{
            DatePickerTextField(placeholder: "birthdate".localized(language), date: self.$date)
            Spacer()
            Image(systemName: "calendar.badge.plus")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("lightGray"))
            }
            .frame(width: screenWidth, height: 30)
            .font(.system(size: 13))
            .padding(12)
            .disableAutocorrection(true)
            .background(
                Color.white
            ).foregroundColor(Color("blueColor"))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.099), radius: 3)
            .onAppear(perform: {
//                DoctorCreatedVM.Birthday = "\(date , datef: datef )"

            })
    }
}

struct DateOfBirthView_Previews: PreviewProvider {
    static var previews: some View {
        DateOfBirthView(date: .constant(Date()))
    }
}
