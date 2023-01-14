//
//  ChooseSubSpeciality.swift
//  SalamTak
//
//  Created by wecancity on 12/01/2023.
//

import SwiftUI

struct ChooseSubSpeciality: View {
    var language = LocalizationService.shared.language
    @StateObject var SubSpecialityVM = ViewModelSubspeciality()
    @Binding var IsPresented: Bool
    @Binding var selectedSpecialityId : Int
    @Binding var selectedSubSpecialityName : [String]
    @Binding var selectedSubSpecialityId : [Int]
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
                    Text("Subspeciality_".localized(language))
                        .font(.title2)
                        .bold()
                    
                    ScrollView( showsIndicators: false) {
                        VStack {
                            ForEach(SubSpecialityVM.publishedSubSpecialistModel,id:\.self){supspec in
                                SubspecialityCell( supspec: supspec, selectedName: $selectedSubSpecialityName, selectedId: $selectedSubSpecialityId)
                            }
                        }
                    }
                    
                    HStack {
                        ButtonView(text: "CompeleteProfile_Screen_ConfirmButton".localized(language), action: {
                            withAnimation(.easeIn(duration: 0.3)) {
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
            SubSpecialityVM.SpecialistId = selectedSpecialityId
            SubSpecialityVM.startFetchSubSpecialist()
        })
        .offset(y: (UIScreen.main.bounds.size.height / 2) - 80)
        
    }
}
struct ChooseSubSpeciality_Previews: PreviewProvider {
    static var previews: some View {
        ChooseSubSpeciality(IsPresented: .constant(true), selectedSpecialityId: .constant(0), selectedSubSpecialityName: .constant([]), selectedSubSpecialityId: .constant([]))
        
    }
}

struct SubspecialityCell: View {
    var language = LocalizationService.shared.language
    var supspec : subspeciality
    @Binding var selectedName : [String]
    @Binding var selectedId : [Int]
    @State var isTapped : Bool? = false
    
    var body: some View {
        Button(action: {
            isTapped?.toggle()
            //            self.buttonSelected = supspec
            
            if selectedId == []{
                self.selectedId.insert(supspec.id ?? 0, at: 0)
                self.selectedName.insert(supspec.Name ?? "", at: 0)
            } else{
                
                if self.selectedId.contains(supspec.id ?? 0) && self.selectedName.contains(supspec.Name ?? "") {
                    self.selectedId.removeAll(where: {$0 == supspec.id
                    })
                    self.selectedName.removeAll(where: {$0 == supspec.Name
                    })
                }else{
                    self.selectedId.append(supspec.id ?? 0)
                    self.selectedName.append(supspec.Name ?? "")
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
                for id  in selectedId {
                    if supspec.id == id {
                        self.isTapped = true
                    }
                }
            })
    }
}

