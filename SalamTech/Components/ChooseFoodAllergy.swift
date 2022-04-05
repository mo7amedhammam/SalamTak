//
//  ChooseFoodAllergy.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 05/04/2022.
//

import SwiftUI

struct ChooseFoodAllergy: View {
    var language = LocalizationService.shared.language
//    @StateObject var ServiceVM = ViewModelGetServises()
    @StateObject var FoodAlgVM = ViewModelFoodAllergy()
    //@ObservedObject var dataModel: DataModel
//    @ObservedObject var SpecialityVM = ViewModelSpecialist()
  //  @StateObject var checkModel = CheckBoxViewModel()
    @StateObject  var medicalCreatedVM = ViewModelCreateMedicalProfile()
    @Binding var IsPresented: Bool
//    @ObservedObject private var doctorCreatedVM = ViewModelCreateDoctorProfile()
    @Binding var selectedServiceName : [String]
    @Binding var selectedServiceId : [Int]
//
    @State var isTapped : Bool? = false
    
//    var specid: Int
    var width: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
                .foregroundColor(.white)
                .ignoresSafeArea()
                .opacity(0.6)
                .shadow(radius: 15)
            
            VStack {
                ZStack{
                    Capsule()
                        .frame(width: 50, height: 4)
                        .foregroundColor(.gray)
                } // capsule design
                .padding(.top, 10)
//                VStack {
                    VStack {
                        Text("Food Allergies")
                            .font(.title2)
                            .bold()
                        
                        
                        //                        List(SubSpecialityVM.publishedSubSpecialistModel){ x in
                        //                            Text("\(x.Name ?? "")")
                        ////                            Text(x.)
                        //                        }
                        
                            ScrollView( showsIndicators: false) {
                                ForEach(FoodAlgVM.publishedCountryModel){supspec in

                                    ExtractedViewFoodAllergy( supspec: supspec, selectedServiceName: $selectedServiceName, selectedServiceId: $selectedServiceId)
//                                        .padding([.leading,.trailing],0)


                        }


                        }
                       
                        HStack {
                            ButtonView(text: "CompeleteProfile_Screen_ConfirmButton".localized(language), action: {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    print(self.selectedServiceId)
                                    IsPresented.toggle()

                                }

                            })


                        }.padding(.bottom, 20)

                        
                        //MARK: end of vstack
//                }
                //                .frame(height: width * 1.2)
//                .padding(30)
                
//                Spacer()
            }
                    .frame(height: (UIScreen.main.bounds.size.height / 2) + 40)
                    
                    Spacer()
            
        }
            
//        .offset(y: 220)

    }
        .onAppear(perform: {
        print("on appear")
//            print( specid)
//            SubSpecialityVM.startFetchSpecialist(id: specid)
            FoodAlgVM.startFetchFoodAllergy()
        
        //SubSpecialityVM.SpecialistId = specid
//                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
//
//                print(SubSpecialityVM.publishedSubSpecialistModel)
//            })
//            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
//                print(SubSpecialityVM.publishedSubSpecialistModel)
//            })

//            print(SubSpecialityVM.SpecialistId)
//            print(SubSpecialityVM.publishedSubSpecialistModel)
        
    })
    .onDisappear{
        FoodAlgVM.Id = selectedServiceId
        FoodAlgVM.Name = selectedServiceName
         medicalCreatedVM.PatientFoodAllergiesDto = FoodAlgVM.Id
        
        print(self.FoodAlgVM.Id)
        print(self.FoodAlgVM.Name)
        print(medicalCreatedVM.PatientFoodAllergiesDto)
    
    }
        .offset(y: (UIScreen.main.bounds.size.height / 2) - 200)

}
}

struct ExtractedViewFoodAllergy: View {
    var language = LocalizationService.shared.language
//    @StateObject var SubSpecialityVM = ViewModelSubSpecialist()
    var supspec : FoodAllergy
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
            
            
            //                                        if selectedSubSpecialityId == []{
            //                                            self.selectedSubSpecialityId.insert(SubSpecialityVM.publishedSubSpecialistModel[supspec].id ?? 0, at: 0)
            //                                            self.selectedSubSpecialityName.insert(SubSpecialityVM.publishedSubSpecialistModel[supspec].Name ?? "", at: 0)
            //                                        }else { if self.selectedSubSpecialityId.contains(SubSpecialityVM.publishedSubSpecialistModel[supspec].id ?? 0){
            //                                            self.selectedSubSpecialityId.removeAll(where: {$0 == SubSpecialityVM.publishedSubSpecialistModel[supspec].id
            //                                            })
            //                                        }
            //                                        if self.selectedSubSpecialityName.contains(SubSpecialityVM.publishedSubSpecialistModel[supspec].Name ?? ""){
            //                                            self.selectedSubSpecialityName.removeAll(where: {$0 == SubSpecialityVM.publishedSubSpecialistModel[supspec].Name
            //                                            })
            //
            //                                        }else {
            //                                            self.selectedSubSpecialityId.append(SubSpecialityVM.publishedSubSpecialistModel[supspec].id ?? 0)
            //                                            self.selectedSubSpecialityName.append(SubSpecialityVM.publishedSubSpecialistModel[supspec].Name ?? "")
            //                                        }
            //                                        }
            print(selectedServiceId)
            
            
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
            
            
            //                                            SucspecView(isTapped: $isTapped , subspeciality: SubSpecialityVM.publishedSubSpecialistModel[supspec])
            //                                                .padding([.leading,.trailing],0)
            //
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
