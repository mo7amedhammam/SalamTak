//
//  PatientMedicalInfoView.swift
//  SalamTak
//
//  Created by wecancity on 29/12/2022.
//

import SwiftUI

struct PatientMedicalInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var language = LocalizationService.shared.language
    var taskOP : profiletask

    @State var ShowBloodType = false
    @State var ShowFoodAllergy = false
    @State var ShowMedicineAllergy = false
    @State var ShowOccupation = false

    @State var isnormalPressure = false
    @State var normalPressure = "120"
    @State var isnormalSugar = false
    @State var normalSugar = "96"
    @StateObject var MedicalprofileVM = PatientMedicalInfoViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing:0){
                AppBarView(Title: "Patient_Medical_State".localized(language), imageName: "2/2", backColor: .clear, withbackButton: taskOP == .complete ? false : true  )
                    .frame(height:60)
                ScrollView(showsIndicators: false){
                    
                    //MARK: --- Name ----
                    Group{
                        
                        //MARK: --- English Name ----
                        HStack(spacing:15){
                            InputTextField(text: $MedicalprofileVM.Height.string(), textplacholder: "CM_".localized(language),errorMsg: .constant(""), title: "Height_".localized(language))
                            InputTextField(text: $MedicalprofileVM.Weight.string(), textplacholder: "KG_".localized(language), errorMsg: .constant(""), title: "Weight_".localized(language))
                        }
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    Group{
                        InputTextField(text: $MedicalprofileVM.BloodTypeName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_Blood_Group".localized(language),errorMsg: .constant(""), title: "Blood_Group".localized(language),isactive: false){
                            ShowBloodType = true
                        }
                        
                        HStack{
                            InputTextField(text:isnormalPressure ? $normalPressure: $MedicalprofileVM.Pressure, textplacholder: "MM/GG".localized(language),errorMsg: .constant(""), title: "Pressure(MM/HG)".localized(language),isactive: !isnormalPressure)
                                .keyboardType(.numberPad)

                            VStack(spacing:0) {
                                Text("Normal_")
                                    .font(.salamtakBold(of: 15))
                                    .foregroundColor(.salamtackBlue)
                                Toggle(isOn: $isnormalPressure) {
                                }
                                .toggleStyle(SwitchToggleStyle(tint: .salamtackWelcome))
                                .frame(width: 70)
                            .padding(.trailing,10)
                            }
                        }
                        
                        HStack{
                            InputTextField(text:isnormalSugar ? $normalSugar:$MedicalprofileVM.SugarLevel, textplacholder: "MG/DL".localized(language),errorMsg: .constant(""), title: "Sugar_Level(MG/DL)".localized(language),isactive: !isnormalSugar)
                                .disabled(!isnormalSugar)
                                .keyboardType(.numberPad)

                            VStack(spacing:0) {
                                Text("Normal_")
                                    .font(.salamtakBold(of: 15))
                                    .foregroundColor(.salamtackBlue)
                                Toggle(isOn: $isnormalSugar) {
                                }
                                .toggleStyle(SwitchToggleStyle(tint: .salamtackWelcome))
                                .frame(width: 70)
                            .padding(.trailing,10)
                            }
                        }
                        
                        InputTextField(text: .constant(MedicalprofileVM.PatientMedicineAllergiesName.joined(separator: ", ")),iconName: .DropList(icon: "newdown"), textplacholder: "Algerie1,Algeri2,...".localized(language),errorMsg: $MedicalprofileVM.errorFirstName, title: "Medicine_Aliergies".localized(language),isactive: false){
                            ShowMedicineAllergy = true
                        }
                        
                        InputTextField(text: .constant(MedicalprofileVM.PatientFoodAllergiesName.joined(separator: ", ")) ,iconName: .DropList(icon: "newdown") , textplacholder: "Algerie1,Algeri2,...".localized(language),errorMsg: .constant(""), title: "Food_Aliergies".localized(language),isactive: false){
                            ShowFoodAllergy = true
                        }
                        
                        InputTextField(text: $MedicalprofileVM.OtherAllergies,iconName: .normalinput , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "Other_Aliergies".localized(language))
                    
                        InputTextField(text: $MedicalprofileVM.Prescriptions,iconName: .normalinput , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "Prescriptions_".localized(language))
                        
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    
                    //MARK: --- Full address ----
                    Group{
                        InputTextField(text: $MedicalprofileVM.CurrentMedication,iconName: .normalinput , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "CurrentMedication_".localized(language))

                        InputTextField(text: $MedicalprofileVM.PastMedication,iconName: .normalinput , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "PastMedication_".localized(language))

                        InputTextField(text: $MedicalprofileVM.Iinjuries,iconName: .normalinput , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "Iinjuries_".localized(language))

                        InputTextField(text: $MedicalprofileVM.ChronicDiseases,iconName: .normalinput , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "ChronicDiseases_".localized(language))

                        InputTextField(text: $MedicalprofileVM.Surgeries,iconName: .normalinput , textplacholder: "Select_".localized(language),errorMsg: .constant(""), title: "Surgeries_".localized(language))
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    
                    HStack (spacing:0){
                        Group{
                        BorderedButton(text: "Previous_".localized(language), isActive: .constant(true)){
                            presentationMode.wrappedValue.dismiss()
                        }
                            BorderedButton(text: "Finish_".localized(language), isActive: $MedicalprofileVM.formIsValid){
                                MedicalprofileVM.execute(Operation: .CreatePatientMedicalInfo)
                            }
                        }
                        .padding(.top)
                    .padding(.horizontal)
                    }
//                    .padding(.horizontal)
                    Spacer()
                }
                .padding(.horizontal,10)
                .padding(.bottom,-10)
                .padding(.top,30)
                SupportCall()
                    .frame(height:55)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            .onTapGesture(perform: {
                hideKeyboard()
            })
            .onChange(of: isnormalPressure, perform: {newval in
                if newval == true{
    //                DispatchQueue.global(qos: .userInitiated).async(execute: {
                    MedicalprofileVM.Pressure = normalPressure
    //                })
                }else{
    //                MedicalprofileVM.FirstName = "15"
                }
            })
            .onChange(of: isnormalSugar, perform: {newval in
                if newval == true{
    //                DispatchQueue.global(qos: .userInitiated).async(execute: {
                    MedicalprofileVM.SugarLevel = normalSugar
    //                })
                }else{
    //                MedicalprofileVM.MiddelName = "12"
                }
            })

            .overlay(
                ActivityIndicatorView(isPresented: $MedicalprofileVM.isLoading)
            )
            
            .background(
                newBackImage(backgroundcolor: .white)
            )
            
            // Alert with no internet connection
            .alert(isPresented: $MedicalprofileVM.isAlert, content: {
                Alert(title: Text(MedicalprofileVM.message.localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    MedicalprofileVM.isAlert = false
                }))
        })
        }
        .overlay(
            ZStack{
            if ShowBloodType {
                ShowBloodTypeList(ShowBloodType: $ShowBloodType, SelectedBloodName: $MedicalprofileVM.BloodTypeName, SelectedBloodId: $MedicalprofileVM.BloodTypeId)
                
            } else if ShowMedicineAllergy{
                ShowMedicineAllergyList(ShowMedicineAllergy: $ShowMedicineAllergy, selectedMedicalAlgName: $MedicalprofileVM.PatientMedicineAllergiesName, selectedMedicalAlgId: $MedicalprofileVM.PatientMedicineAllergiesDto)
            }else if ShowFoodAllergy{
                ShowFoodAllergyList(ShowFoodAllergy: $ShowFoodAllergy, selectedFoodAlgName: $MedicalprofileVM.PatientFoodAllergiesName, selectedFoodAlgId: $MedicalprofileVM.PatientFoodAllergiesDto)
            }
                
            }

        )
        
        
        // go to verify account to resset
        //        NavigationLink(destination: ResetPasswordView(),isActive: $resetPassword) {
        //        }
        
    }
}

struct PatientMedicalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientMedicalInfoView( taskOP: .create)
    }
}
