//
//  ChooseFoodAllergy.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 05/04/2022.
//

import SwiftUI

struct ChooseMedicineAllergy: View {
    var language = LocalizationService.shared.language
    @StateObject var MedicAlgVM = ViewModelMedicineAllergy()
    @Binding var IsPresented: Bool
    @Binding var selectedMedicalAlgName : [String]
    @Binding var selectedMedicalAlgId : [Int]
    @State var isTapped : Bool? = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
                .foregroundColor(.white)
                .shadow(radius: 15)
            
            VStack {
                    Capsule()
                        .frame(width: 50, height: 4)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                VStack {
                    Text("Medical_Allergies".localized(language))
                        .font(.title2)
                        .bold()
                    
                    ScrollView( showsIndicators: false) {
                        VStack {
                            ForEach(MedicAlgVM.publishedCountryModel,id:\.self){supspec in
                                ExtractedViewMedicineAllergy( supspec: supspec, selectedServiceName: $selectedMedicalAlgName, selectedServiceId: $selectedMedicalAlgId)
                            }
                        }
                    }
                    
                    HStack {
                        ButtonView(text: "CompeleteProfile_Screen_ConfirmButton".localized(language), action: {
                            withAnimation(.easeIn(duration: 0.3)) {
                                print(self.selectedMedicalAlgName)
                                IsPresented.toggle()
                            }
                        })
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal,20)

                    Spacer()
                }
                .padding(.top,10)

                .padding(.bottom,hasNotch ? 300 : 230)
                
            }
        }
        .onAppear(perform: {
//            MedicAlgVM.startFetchMedicineAllergy()
        })
//        .onDisappear{
//            MedicAlgVM.Id = selectedServiceId
//            MedicAlgVM.Name = selectedServiceName
//            medicalCreatedVM.PatientMedicineAllergiesDto = MedicAlgVM.Id
//        }
        .offset(y: (UIScreen.main.bounds.size.height / 2) - 80)
        
    }
}
struct ChooseMedicineAllergy_Previews: PreviewProvider {
    static var previews: some View {
        ChooseMedicineAllergy(IsPresented: .constant(true), selectedMedicalAlgName: .constant([]), selectedMedicalAlgId: .constant([]))
        
    }
}

struct ExtractedViewMedicineAllergy: View {
    var language = LocalizationService.shared.language
    var supspec : MedicineAllergy
    @Binding var selectedServiceName : [String]
    @Binding var selectedServiceId : [Int]
    @State var isTapped : Bool? = false
    
    var body: some View {
        Button(action: {
            isTapped?.toggle()
            //            self.buttonSelected = supspec
            
            if selectedServiceId == []{
                self.selectedServiceId.insert(supspec.id ?? 0, at: 0)
                self.selectedServiceName.insert(supspec.Name ?? "", at: 0)
            } else{
                
                if self.selectedServiceId.contains(supspec.id ?? 0) && self.selectedServiceName.contains(supspec.Name ?? "") {
                    self.selectedServiceId.removeAll(where: {$0 == supspec.id
                    })
                    self.selectedServiceName.removeAll(where: {$0 == supspec.Name
                    })
                }else{
                    self.selectedServiceId.append(supspec.id ?? 0)
                    self.selectedServiceName.append(supspec.Name ?? "")
                }
            }
        }, label: {
            
            if language.rawValue == "en" {
                HStack (spacing: 20 ){
                    
                    Image(systemName: isTapped ?? false ? "checkmark.rectangle.fill": "checkmark.rectangle")
                        .foregroundColor( isTapped ?? false ? Color("blueColor") :Color("lightGray"))
                    Text(supspec.Name ?? "")
                        .font(.system(size: 20))
                        .foregroundColor( isTapped ?? false ? Color("blueColor") :Color("lightGray"))
                    
                    Spacer()
                }
                
                .padding([.top,.bottom],5)
                .padding([.leading,.trailing],10)
            } else if language.rawValue == "ar" {
                HStack (spacing: 20 ){
                    Spacer()
                    Text(supspec.Name ?? "")
                        .font(.system(size: 20))
                        .foregroundColor( isTapped ?? false ? Color("blueColor") :Color("lightGray"))
                    Image(systemName: isTapped ?? false ? "checkmark.rectangle.fill": "checkmark.rectangle")
                        .foregroundColor( isTapped ?? false ? Color("blueColor") :Color("lightGray"))
                    
                }
                
                .padding([.top,.bottom],5)
                .padding([.leading,.trailing],10)
            }
        })
            .onAppear(perform: {
                for id  in selectedServiceId {
                    if supspec.id == id {
                        self.isTapped = true
                    }
                }
            })
    }
}
