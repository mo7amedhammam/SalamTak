//
//  GenderView.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 1/11/22.
//

import SwiftUI


struct GenderView: View {
    //@State private var isSelected = 1

    @Binding var selection: Int?


        var body: some View {
            VStack {
                MyRadioButtons(selection: $selection)
//                Button(action: {
//                    //whatever
//                }) {
//                    Text("Click me!: \(selection)")
//                }
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


//struct LanguageView: View {
//    //@State private var isSelected = 1
//
//    @Binding var selection: Int?
//
//
//        var body: some View {
//            VStack {
//                MyRadioButtons1(selection: $selection)
////                Button(action: {
////                    //whatever
////                }) {
////                    Text("Click me!: \(selection)")
////                }
//            }
//        }
//
//}
//
//struct LanguageView_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguageView(selection: .constant(1))
//    }
//}
//
//struct MyRadioButton1: View {
//    var id: Int
//    @Binding var currentlySelectedId: Int?
//    @State var text:String
//    @ObservedObject var doctorCreatedVM = ViewModelCreateDoctorProfile()
//    let screenWidth = UIScreen.main.bounds.size.width - 100
//
//    var body: some View {
//        Button(action: {
//            self.currentlySelectedId = self.id
//////            doctorCreatedVM.GenderId = self.currentlySelectedId ?? 0
////            print(currentlySelectedId ?? 0)
////            print(doctorCreatedVM.GenderId ?? 0)
//            if self.currentlySelectedId == 1 {
//                LocalizationService.shared.language = .english_us
//                Helper.setLanguage(currentLanguage: "en")
//            } else if self.currentlySelectedId == 2 {
//                LocalizationService.shared.language = .arabic
//                Helper.setLanguage(currentLanguage: "ar")
//            }
//            
//        }, label: { Text(text)
//                .font(Font.SalamtechFonts.Reg14)
//
//            
//        })
//            .foregroundColor(id == currentlySelectedId ? Color.white : .black)
//            .frame(width: screenWidth / 2, height: 37)
//            .background(id == currentlySelectedId ? Color("darkGreen") : Color.gray.opacity(0.1))
//            .cornerRadius(10)
//            .onAppear(perform: {
//                if Helper.getLanguage() == "en" {
//                    currentlySelectedId = 1
//                } else if Helper.getLanguage() == "ar" {
//                    currentlySelectedId = 2
//                }
//            })
//    }
//}
//
//
//struct MyRadioButtons1: View {
//    init(selection: Binding<Int?>) {
//        self._currentlySelectedId = selection
//        
//    }
//    @Binding var currentlySelectedId: Int?
//    @ObservedObject var doctorCreatedVM = ViewModelCreateDoctorProfile()
//
//    var body: some View {
//        HStack (spacing: 20){
//            MyRadioButton1(id: 2, currentlySelectedId: $currentlySelectedId , text: "العربية")
//            MyRadioButton1(id: 1, currentlySelectedId: $currentlySelectedId , text: "English")
//        }
//        
//    }
//}

