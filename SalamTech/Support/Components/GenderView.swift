//
//  GenderView.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 1/11/22.
//

import SwiftUI


struct GenderView: View {
    @Binding var selection: Int?
        var body: some View {
            VStack {
                MyRadioButtons(selection: $selection)
            }
        }
}

struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        GenderView(selection: .constant(1))
    }
}

struct MyRadioButton: View {
    var id: Int
    @Binding var currentlySelectedId: Int?
    @State var text:String
    @ObservedObject var patientCreatedVM = ViewModelCreatePatientProfile()
    let screenWidth = UIScreen.main.bounds.size.width - 50

    var body: some View {
        Button(action: {
            self.currentlySelectedId = self.id
            patientCreatedVM.GenderId = self.currentlySelectedId ?? 0
            print(currentlySelectedId ?? 0)
            print(patientCreatedVM.GenderId ?? 0)
            
        }, label: { Text(text)
                .font(Font.SalamtechFonts.Reg16)

        })
            .foregroundColor(id == currentlySelectedId ? Color("blueColor") : .black)
            .frame(width: screenWidth / 2, height: 57)
            .background(id == currentlySelectedId ? Color("blueColor").opacity(0.2) : Color.gray.opacity(0.1))
            .cornerRadius(3)
    }
}


struct MyRadioButtons: View {
    var language = LocalizationService.shared.language
    init(selection: Binding<Int?>) {
        self._currentlySelectedId = selection
        
    }
    @Binding var currentlySelectedId: Int?
//    @ObservedObject var doctorCreatedVM = ViewModelCreateDoctorProfile()
    var body: some View {
        HStack (spacing: 20){
            MyRadioButton(id: 1, currentlySelectedId: $currentlySelectedId , text: "CompeleteProfile_Screen_male".localized(language))
            MyRadioButton(id: 2, currentlySelectedId: $currentlySelectedId , text: "CompeleteProfile_Screen_female".localized(language))
            
        }
        
    }
}
