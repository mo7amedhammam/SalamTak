//
//  GenderView.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 1/11/22.
//

import SwiftUI


struct GenderView: View {
    @Binding var GenderId: Int?
    @Binding var GenderName: String?

        var body: some View {
            HStack {
                MyRadioButtons(selectedId: $GenderId, selectedName: $GenderName)
            }
        }
}

struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        GenderView(GenderId: .constant(1), GenderName: .constant(""))
    }
}

struct MyRadioButton: View {
    var id: Int
    @Binding var currentlySelectedId: Int?
    @Binding var currentlySelectedName: String?

    @State var text:String
//    @ObservedObject var patientCreatedVM = ViewModelCreatePatientProfile()
    let screenWidth = UIScreen.main.bounds.size.width - 50

    var body: some View {
        Button(action: {
            self.currentlySelectedId = self.id
            self.currentlySelectedName = self.text
//            patientCreatedVM.GenderId = self.currentlySelectedId ?? 0
//            print(currentlySelectedId ?? 0)
//            print(patientCreatedVM.GenderId ?? 0)
            
        }, label: {
            Text(text)
                .font(.salamtakBold(of: 16))
        
            .foregroundColor(.white )
            .frame(width: screenWidth / 3, height: 40)
            .background(id == currentlySelectedId ? Color.salamtackBlue .opacity(0.8) : Color.gray.opacity(0.8))
            .cornerRadius(25)
        })
    }
}


struct MyRadioButtons: View {
    var language = LocalizationService.shared.language
    init(selectedId: Binding<Int?>, selectedName:Binding<String?>) {
        self._currentlySelectedId = selectedId
        self._currentlySelectedName = selectedName
    }
    @Binding var currentlySelectedId: Int?
    @Binding var currentlySelectedName: String?

    var body: some View {
        HStack (spacing: 20){
            MyRadioButton(id: 1, currentlySelectedId: $currentlySelectedId, currentlySelectedName: $currentlySelectedName , text: "CompeleteProfile_Screen_male".localized(language))
            MyRadioButton(id: 2, currentlySelectedId: $currentlySelectedId, currentlySelectedName: $currentlySelectedName , text: "CompeleteProfile_Screen_female".localized(language))
            
        }
        
    }
}
