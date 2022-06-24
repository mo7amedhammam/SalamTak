//
//  MedicalStateView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import SwiftUI

struct MedicalStateView: View {
    var language = LocalizationService.shared.language
    @State var bounds = UIScreen.main.bounds
    @State var offset = CGSize.zero
    @FocusState private var isfocused : Bool
    let screenWidth = UIScreen.main.bounds.size.width - 55
    @State var isValid = false
    @State var ShowingMap = false
    @State var ShowBloodType = false
    @State var ShowFoodAllergy = false
    @State var ShowMedicineAllergy = false
    @State var ShowOccupation = false
    
    @State var normalPressure = "120"
    @State var normalSugar = "96"
    
    @StateObject var medicalCreatedVM = ViewModelCreateMedicalProfile()
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var NationalityVM = ViewModelCountries()
    @StateObject var OccupationVM = ViewModelOccupation()
    @StateObject var BloodTypeVM = ViewModelBloodType()
    
    
    var body: some View {
        ZStack{
            ZStack{
                ZStack{
                    VStack{
                        Spacer().frame(height:180)
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack{
                                Spacer().frame(height: 30)
                                HStack(spacing: 40){
                                    Group{
                                        InputTextFieldMedicalInfo(text: $medicalCreatedVM.Height.string(), title: "Height")
                                        
                                        InputTextFieldMedicalInfo(text: $medicalCreatedVM.Weight.string(), title: "Weight")
                                    }  .focused($isfocused)
                                        .keyboardType(.numberPad)
                                }
                                Spacer().frame(height: 20)
                                Group{
                                    MedicalTextFieldInfo(text: $medicalCreatedVM.Pressure, text1: $normalPressure, title: "Pressure(MM/HG)")
                                    
                                    Spacer().frame(height: 20)
                                    MedicalTextFieldInfo(text: $medicalCreatedVM.SugarLevel, text1: $normalSugar, title: "Sugar Level(MG/DL)")
                                }  .focused($isfocused)
                                    .keyboardType(.numberPad)
                                
                                Spacer().frame(height: 20)
                                VStack{
                                    Button {
                                        if medicalCreatedVM.Height != 0 && medicalCreatedVM.Weight != 0  && medicalCreatedVM.BloodTypeId != 0 {
                                            isValid = true
                                        }else {
                                            isValid = false
                                        }
                                        withAnimation {
                                            ShowBloodType.toggle()
                                        }
                                        
                                    } label: {
                                        HStack{
                                            Text(medicalCreatedVM.BloodTypeName.isEmpty ? "Blood Group":medicalCreatedVM.BloodTypeName)
                                                .foregroundColor(medicalCreatedVM.BloodTypeName.isEmpty ? Color("lightGray"):Color("blueColor"))
                                            
                                            Spacer()
                                            Image(systemName: "staroflife.fill")
                                                .font(.system(size: 10))
                                                .foregroundColor(medicalCreatedVM.BloodTypeName.isEmpty ? Color.red : Color.white)
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color("lightGray"))
                                        }
                                        .frame(width: screenWidth, height: 30)
                                        .font(.system(size: 13))
                                        .padding(12)
                                        .disableAutocorrection(true)
                                        .background(
                                            Color.white
                                        )
                                        .foregroundColor(Color("blueColor"))
                                            .cornerRadius(5)
                                            .shadow(color: Color.black.opacity(0.099), radius: 3)
                                    }
                                    Spacer().frame(height: 20)
                                }
                                VStack{
                                    
                                    Button {
                                        
                                        if medicalCreatedVM.Height != 0 && medicalCreatedVM.Weight != 0  && medicalCreatedVM.BloodTypeId != 0 {
                                            isValid = true
                                        }else {
                                            isValid = false
                                        }
                                        withAnimation {
                                            ShowFoodAllergy.toggle()
                                        }
                                    } label: {
                                        HStack{
                                            Text( medicalCreatedVM.PatientFoodAllergiesName.isEmpty ? "Food Allergies" : medicalCreatedVM.PatientFoodAllergiesName.joined(separator: ",")) .font(Font.SalamtechFonts.Reg14)
                                                .foregroundColor(medicalCreatedVM.PatientFoodAllergiesName.isEmpty ? Color("lightGray"):Color("blueColor"))
                                            
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color("lightGray"))
                                        }
                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                        .frame(width: screenWidth, height: 30)
                                        .font(.system(size: 13))
                                        .padding(12)
                                        .disableAutocorrection(true)
                                        .background(
                                            Color.white
                                        ).foregroundColor(Color("blueColor"))
                                            .cornerRadius(5)
                                            .shadow(color: Color.black.opacity(0.099), radius: 3)
                                    }
                                    
                                    Button {
                                        withAnimation {
                                            ShowMedicineAllergy.toggle()
                                        }
                                    } label: {
                                        HStack{
                                            Text( medicalCreatedVM.PatientMedicineAllergiesName.isEmpty ? "Medicine Allergies" : medicalCreatedVM.PatientMedicineAllergiesName.joined(separator: ",")) .font(Font.SalamtechFonts.Reg14)
                                                .foregroundColor(medicalCreatedVM.PatientMedicineAllergiesName.isEmpty ? Color("lightGray"):Color("blueColor"))
                                            
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color("lightGray"))
                                        }
                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                        .frame(width: screenWidth, height: 30)
                                        .font(.system(size: 13))
                                        .padding(12)
                                        .disableAutocorrection(true)
                                        .background(
                                            Color.white
                                        ).foregroundColor(Color("blueColor"))
                                            .cornerRadius(5)
                                            .shadow(color: Color.black.opacity(0.099), radius: 3)
                                    }
                                    Spacer().frame(height: 20)
                                    Group{
                                        InputTextField(text: $medicalCreatedVM.OtherAllergies, title: "Other Allergies")
                                        
                                        Spacer().frame(height: 20)
                                        InputTextField(text: $medicalCreatedVM.Prescriptions, title: "Prescriptions")
                                        
                                        Spacer().frame(height: 20)
                                        InputTextField(text: $medicalCreatedVM.CurrentMedication, title: "CurrentMedication")
                                        
                                    }.focused($isfocused)
                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                        .autocapitalization(.none)
                                    
                                        .textInputAutocapitalization(.never)
                                    
                                }
                                VStack{
                                    Spacer().frame(height: 20)
                                    Group{
                                        InputTextField(text: $medicalCreatedVM.PastMedication, title: "PastMedication")
                                        
                                        Spacer().frame(height: 20)
                                        InputTextField(text: $medicalCreatedVM.ChronicDiseases, title: "ChronicDiseases")
                                        
                                        Spacer().frame(height: 20)
                                        InputTextField(text: $medicalCreatedVM.Iinjuries, title: "Iinjuries")
                                        
                                        Spacer().frame(height: 20)
                                        InputTextField(text: $medicalCreatedVM.Surgeries, title: "Surgeries")
                                        
                                    }.focused($isfocused)
                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                        .autocapitalization(.none)
                                        .textInputAutocapitalization(.never)
                                }
                                
                            }
                        }
                        .keyboardSpace()
                        Spacer().frame(height:75)
                    }
                    .padding(.horizontal)

                    InfoAppBarView(Maintext: "CompeleteProfile_Screen_title".localized(language), text: "Certificates_Screen_subtitle".localized(language),Nexttext: "CompeleteMedical_Screen_secondSubTitle".localized(language),image: "2-3",navBarHidden:true)
                        .offset(y: -10)
                    
//                    VStack{
//                        Spacer()
//                        Button(action: {
//                            DispatchQueue.main.async {
//
//                                if medicalCreatedVM.Pressure == "" {
//                                    medicalCreatedVM.Pressure = self.normalPressure
//                                }
//                                if medicalCreatedVM.SugarLevel == "" {
//                                    medicalCreatedVM.SugarLevel = self.normalSugar
//                                }
//                                print("pressure")
//                                print(medicalCreatedVM.Pressure)
//                                medicalCreatedVM.startCreateMedicalProfile()
//                            }
//
//                        }, label: {
//                            HStack {
//                                Text("Finish".localized(language))
//                                    .fontWeight(.semibold)
//                                    .font(.title3)
//                            }.frame(minWidth: 0, maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background((medicalCreatedVM.Height != 0 && medicalCreatedVM.Weight != 0  && medicalCreatedVM.BloodTypeId != 0) && (medicalCreatedVM.isLoading == false) ?  Color("blueColor"):Color("lightGray"))
//                                .cornerRadius(12)
//                                .padding(.horizontal, 20)
//                        }) .disabled((medicalCreatedVM.Height == 0 || medicalCreatedVM.Weight == 0 || medicalCreatedVM.BloodTypeId == 0) || (medicalCreatedVM.isLoading == true))
//                            .padding(.bottom)
//                            .padding(.horizontal)
//
//                    }
                    
                    CustomActionBottomSheet( ConfirmTitle: "CompeleteProfile_Screen_Next_Button".localized(language), CancelTitle: "CompeleteProfile_Screen_Previos_Button".localized(language), Confirmaction:   {
                        DispatchQueue.main.async {

                            if medicalCreatedVM.Pressure == "" {
                                medicalCreatedVM.Pressure = self.normalPressure
                            }
                            if medicalCreatedVM.SugarLevel == "" {
                                medicalCreatedVM.SugarLevel = self.normalSugar
                            }
                            medicalCreatedVM.startCreateMedicalProfile()
                        }

                    }, Cancelaction:  {
//                                                                self.presentationMode.wrappedValue.dismiss()
                    }, isValid: $isValid)
                    
                    
                    
                }
                .ignoresSafeArea()
                .background(Color("CLVBG"))
                .blur(radius: ShowOccupation || ShowFoodAllergy || ShowBloodType || ShowMedicineAllergy ? 10 : 0)
                .disabled(ShowOccupation || ShowFoodAllergy || ShowBloodType || ShowMedicineAllergy)
                if ShowBloodType {
                    ShowBloodTypeList( ShowBloodType: $ShowBloodType, bounds: $bounds, offset: $offset).environmentObject(BloodTypeVM)
                        .environmentObject(medicalCreatedVM)
                    
                } else if ShowFoodAllergy{
                    ShowFoodAllergyList( ShowFoodAllergy: $ShowFoodAllergy, bounds: $bounds, offset: $offset)
                        .environmentObject(medicalCreatedVM)
                } else if ShowMedicineAllergy{
                    ShowMedicineAllergyList( ShowMedicineAllergy: $ShowMedicineAllergy, bounds: $bounds, offset: $offset)                            .environmentObject(medicalCreatedVM)
                }
            }
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $medicalCreatedVM.isLoading)
        }
        .onAppear(perform: {
            BloodTypeVM.startFetchBloodTypes()
        })
        .toolbar{
            ToolbarItemGroup(placement: .keyboard ){
                Spacer()
                Button("Done"){
                    isfocused = false
                    if medicalCreatedVM.Height != 0 && medicalCreatedVM.Weight != 0  && medicalCreatedVM.BloodTypeId != 0 {
                        isValid = true
                    }else {
                        isValid = false
                    }
                }
            }
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
        NavigationLink(destination:TabBarView(),isActive: $medicalCreatedVM.UserCreated , label: {
        })
        
        // Alert with no internet connection
            .alert(isPresented: $medicalCreatedVM.isAlert, content: {
                Alert(title: Text(medicalCreatedVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    medicalCreatedVM.isAlert = false
                }))
            })
    }
}

struct MedicalStateView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            MedicalStateView()
        }
    }
}




