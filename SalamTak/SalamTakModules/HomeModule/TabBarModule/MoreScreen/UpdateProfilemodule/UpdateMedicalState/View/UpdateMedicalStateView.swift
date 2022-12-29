//
//  UpdateMedicalStateView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 07/04/2022.
//

import SwiftUI

struct UpdateMedicalStateView: View {
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
    
    @StateObject var medicalUpdatedVM = ViewModelUpdateMedicalProfile()
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var NationalityVM = ViewModelCountries()
    @StateObject var OccupationVM = ViewModelOccupation()
    @StateObject var BloodTypeVM = ViewModelBloodType()
    
    
    var body: some View {
        ZStack{
            GeometryReader{ bounds in
                ZStack{
                    VStack{
                        ZStack{
                            VStack{
                                
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack{
                                        Spacer().frame(height: 30)
                                        HStack(spacing: 40){
                                            Group{
                                            InputTextFieldMedicalInfo(text: $medicalUpdatedVM.Height.string(), title: "Height")
                                                
                                            InputTextFieldMedicalInfo(text: $medicalUpdatedVM.Weight.string(), title: "Weight")
                                             
                                        }.focused($isfocused)
                                                .keyboardType(.numberPad)
                                        }
                                        Spacer().frame(height: 20)
                                        
                                        Group{
                                        MedicalTextFieldInfo(text: $medicalUpdatedVM.Pressure, text1: $normalPressure, title: "Pressure(MM/HG)")
                                            
                                        MedicalTextFieldInfo(text: $medicalUpdatedVM.SugarLevel, text1: $normalSugar, title: "Sugar Level(MG/DL)")
                                           
                                        }.focused($isfocused)
                                            .keyboardType(.numberPad)
                                        
                                        Spacer().frame(height: 20)
                                            Spacer().frame(height: 20)

                                        VStack{
                                            Button {
                                                withAnimation {
                                                    ShowBloodType.toggle()
                                                }
                                            } label: {
                                                HStack{
                                                    Text(medicalUpdatedVM.BloodTypeName)
                                                        .foregroundColor(medicalUpdatedVM.BloodTypeName == "" ? Color("lightGray"):Color("blueColor"))
                                                    
                                                    Spacer()
                                                    Image(systemName: "staroflife.fill")
                                                        .font(.system(size: 10))
                                                        .foregroundColor(medicalUpdatedVM.BloodTypeName == "" ? Color.red : Color.white)
                                                    Image(systemName: "chevron.forward")
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
                                            }
                                            Spacer().frame(height: 20)
                                        }
                                        VStack{
                                            Button {
                                                withAnimation {
                                                    ShowFoodAllergy.toggle()
                                                }
                                                
                                            } label: {
                                                HStack{
                                                    Text( medicalUpdatedVM.PatientFoodAllergiesName.isEmpty ? "Food Allergies" : medicalUpdatedVM.PatientFoodAllergiesName.joined(separator: ",")) .font(Font.SalamtechFonts.Reg14)
                                                        .foregroundColor(medicalUpdatedVM.PatientFoodAllergiesName.isEmpty ? Color("lightGray"):Color("blueColor"))

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
                                                if medicalUpdatedVM.Height != 0 && medicalUpdatedVM.Weight != 0 && medicalUpdatedVM.BloodTypeId != 0 && medicalUpdatedVM.PatientFoodAllergiesDto != [] {
                                                    isValid = true
                                                }
                                                withAnimation {
                                                    ShowMedicineAllergy.toggle()
                                                }
                                                
                                            } label: {
                                                HStack{
                                                    Text( medicalUpdatedVM.PatientMedicineAllergiesName.isEmpty ? "Medicine Allergies" : medicalUpdatedVM.PatientMedicineAllergiesName.joined(separator: ",")) .font(Font.SalamtechFonts.Reg14)
                                                        .foregroundColor(medicalUpdatedVM.PatientMedicineAllergiesName.isEmpty ? Color("lightGray"):Color("blueColor"))

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
                                                InputTextField(text: $medicalUpdatedVM.OtherAllergies, errorMsg: "", title: "Other Allergies")
                                            
                                            Spacer().frame(height: 20)
                                                InputTextField(text: $medicalUpdatedVM.Prescriptions, errorMsg: "", title: "Prescriptions")
                                            
                                            Spacer().frame(height: 20)
                                                InputTextField(text: $medicalUpdatedVM.CurrentMedication, errorMsg: "", title: "CurrentMedication")
                                                
                                            }.focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                               
                                                .textInputAutocapitalization(.never)
                                            
                                        }
                                        VStack{
                                            Group{
                                            Spacer().frame(height: 20)
                                                InputTextField(text: $medicalUpdatedVM.PastMedication, errorMsg: "", title: "PastMedication")
                                            Spacer().frame(height: 20)
                                                
                                                InputTextField(text: $medicalUpdatedVM.ChronicDiseases, errorMsg: "", title: "ChronicDiseases")
                                            Spacer().frame(height: 20)
                                                
                                                InputTextField(text: $medicalUpdatedVM.Iinjuries, errorMsg: "", title: "Iinjuries")
                                            Spacer().frame(height: 20)
                                                
                                                InputTextField(text: $medicalUpdatedVM.Surgeries, errorMsg: "", title: "Surgeries")
                                        }.focused($isfocused)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                            .autocapitalization(.none)
                                            .textInputAutocapitalization(.never)

                                        }
                                    }
                                }
                                .keyboardSpace()
                                Spacer()
                                ButtonView(text: "Update Profile", action: {
                                    medicalUpdatedVM.updateMedicalInfo(operation: .updateMedicalInfo)
                                })
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .background(Color("CLVBG"))
                    .blur(radius: ShowOccupation || ShowFoodAllergy || ShowBloodType || ShowMedicineAllergy ? 10 : 0)
                    .disabled(ShowOccupation || ShowFoodAllergy || ShowBloodType || ShowMedicineAllergy)
                    if ShowBloodType {
                        ShowUpdateBloodTypeList(ShowBloodType: $ShowBloodType, bounds: $bounds, offset: $offset).environmentObject(medicalUpdatedVM)
                            .environmentObject(BloodTypeVM)
                        
                    } else if ShowFoodAllergy{
                        ShowUpdateFoodAllergyList(ShowFoodAllergy: $ShowFoodAllergy, bounds: $bounds, offset: $offset).environmentObject(medicalUpdatedVM)
                      
                    } else if ShowMedicineAllergy{
                        ShowUpdateMedicineAllergyList( ShowMedicineAllergy: $ShowMedicineAllergy, bounds: $bounds, offset: $offset).environmentObject(medicalUpdatedVM)
                    }
                }
                .onAppear(perform: {
                    medicalUpdatedVM.updateMedicalInfo(operation: .getMedicalInfo)
                    BloodTypeVM.startFetchBloodTypes()
                })
                
            }
            .toolbar{
                ToolbarItemGroup(placement: .keyboard ){
                    Spacer()
                    Button("Done"){
                        isfocused = false
                    }
                }
            }
            // showing loading indicator
            ActivityIndicatorView(isPresented: $medicalUpdatedVM.isLoading)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        // Alert with no internet connection
        .alert(isPresented: $medicalUpdatedVM.isAlert, content: {
            Alert(title: Text(medicalUpdatedVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                medicalUpdatedVM.isAlert = false
                
            }))
        })

    }
}

struct UpdateMedicalStateView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            UpdateMedicalStateView()
        }
    }
}





