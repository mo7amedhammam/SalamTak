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
    @EnvironmentObject var environments:EnvironmentsVM
    @StateObject var MedicalprofileVM = PatientMedicalInfoViewModel()
    @Binding var index:Int // 0:profile 1:medical

    var body: some View {
        ZStack {
            VStack(spacing:0){
                AppBarView(Title: "Patient_Medical_State".localized(language), imageName: "2/2", backColor: .clear, withbackButton: taskOP == .create ? true : false  )
                    .frame(height:60)
                ScrollView(showsIndicators: false){
                    
                    //MARK: --- Name ----
                    Group{
                        //MARK: --- English Name ----
                        HStack(spacing:15){
                            InputTextField(text: $MedicalprofileVM.Height, textplacholder: "CM_".localized(language),errorMsg: .constant(""), title: "Height_".localized(language))
                            InputTextField(text: $MedicalprofileVM.Weight, textplacholder: "KG_".localized(language), errorMsg: .constant(""), title: "Weight_".localized(language))
                        }
                        .keyboardType(.asciiCapableNumberPad)
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    Group{
                        InputTextField(text: $MedicalprofileVM.BloodTypeName,iconName: .DropList(icon: "newdown") , textplacholder: "Select_Blood_Group".localized(language),errorMsg: .constant(""), title: "Blood_Group".localized(language),isactive: false){
                            hideKeyboard()
                            environments.SelectedBloodName = MedicalprofileVM.BloodTypeName
                            environments.SelectedBloodId = MedicalprofileVM.BloodTypeId
                            environments.ShowBloodType = true
                        }
                        .onChange(of: environments.SelectedBloodName, perform: {newval in
                            if newval != MedicalprofileVM.BloodTypeName{
                                MedicalprofileVM.BloodTypeName = newval
                                MedicalprofileVM.BloodTypeId = environments.SelectedBloodId

                            }
                        })
                        
                        HStack{
                            InputTextField(text:MedicalprofileVM.isnormalPressure ? $MedicalprofileVM.normalPressure: $MedicalprofileVM.Pressure, textplacholder: "MM/GG".localized(language),errorMsg: .constant(""), title: "Pressure(MM/HG)".localized(language))
                                .disabled(MedicalprofileVM.isnormalPressure)
                                .keyboardType(.numberPad)

                            VStack(spacing:0) {
                                Text("Normal_")
                                    .font(.salamtakBold(of: 15))
                                    .foregroundColor(.salamtackBlue)
                                Toggle(isOn: $MedicalprofileVM.isnormalPressure) {
                                }
                                .toggleStyle(SwitchToggleStyle(tint: .salamtackWelcome))
                                .frame(width: 70)
                            .padding(.trailing,10)
                            }
                        }
                        
                        HStack{
                            InputTextField(text:MedicalprofileVM.isnormalSugar ? $MedicalprofileVM.normalSugar:$MedicalprofileVM.SugarLevel, textplacholder: "MG/DL".localized(language),errorMsg: .constant(""), title: "Sugar_Level(MG/DL)".localized(language))
                                .disabled(MedicalprofileVM.isnormalSugar)
                                .keyboardType(.numberPad)

                            VStack(spacing:0) {
                                Text("Normal_")
                                    .font(.salamtakBold(of: 15))
                                    .foregroundColor(.salamtackBlue)
                                Toggle(isOn: $MedicalprofileVM.isnormalSugar) {
                                }
                                .toggleStyle(SwitchToggleStyle(tint: .salamtackWelcome))
                                .frame(width: 70)
                            .padding(.trailing,10)
                            }
                        }
                        
                        InputTextField(text: .constant(MedicalprofileVM.PatientMedicineAllergiesName.joined(separator: ", ")),iconName: .DropList(icon: "newdown"), textplacholder: "Algerie1,Algeri2,...".localized(language),errorMsg: $MedicalprofileVM.errorFirstName, title: "Medicine_Aliergies".localized(language),isactive: false){
                            hideKeyboard()
                            environments.selectedMedicalAlgId = MedicalprofileVM.PatientMedicineAllergiesDto
                            environments.selectedMedicalAlgName = MedicalprofileVM.PatientMedicineAllergiesName

                            environments.ShowMedicineAllergy = true
                        }
                        .onChange(of: environments.selectedMedicalAlgId, perform: {newval in
                            if newval != MedicalprofileVM.PatientMedicineAllergiesDto{
                                MedicalprofileVM.PatientMedicineAllergiesDto = newval
                                MedicalprofileVM.PatientMedicineAllergiesName = environments.selectedMedicalAlgName
                            }
                        })

                        
                        InputTextField(text: .constant(MedicalprofileVM.PatientFoodAllergiesName.joined(separator: ", ")) ,iconName: .DropList(icon: "newdown") , textplacholder: "Algerie1,Algeri2,...".localized(language),errorMsg: .constant(""), title: "Food_Aliergies".localized(language),isactive: false){
                            hideKeyboard()
                            environments.selectedFoodAlgId = MedicalprofileVM.PatientFoodAllergiesDto
                            environments.selectedFoodAlgName = MedicalprofileVM.PatientFoodAllergiesName

                            environments.ShowFoodAllergy = true
                        }
                        .onChange(of: environments.selectedFoodAlgId, perform: {newval in
                            if newval != MedicalprofileVM.PatientFoodAllergiesDto{
                                MedicalprofileVM.PatientFoodAllergiesDto = newval
                                MedicalprofileVM.PatientFoodAllergiesName = environments.selectedFoodAlgName
                            }
                        })
                        
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
                            if taskOP != .complete{
                        BorderedButton(text: "Previous_".localized(language), isActive: .constant(true)){
                            presentationMode.wrappedValue.dismiss()
                            if taskOP == .update{
                                index = 0
                            }
                        }
                            }
                            BorderedButton(text: "Finish_".localized(language), isActive:.constant(
                                MedicalprofileVM.formIsValid
                             )){
//                                 taskOP == .create{
                                     MedicalprofileVM.execute(Operation: taskOP == .create ? .CreatePatientMedicalInfo:.UpdatePatientMedicalInfo)
//                                 }else{
//                                     
//                                 }
                            }
                        }
                        .padding(.top)
                    .padding(.horizontal)
                    }
//                    .padding(.horizontal)
                    Spacer()
                }
                .padding(.horizontal,10)
//                .padding(.bottom,10)
                .padding(.top,30)
            }
            .padding(.bottom,hasNotch ? 10:50)
            // Alert with no internet connection
            .alert(isPresented: $MedicalprofileVM.isAlert, content: {
                Alert(title: Text(MedicalprofileVM.message.localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    MedicalprofileVM.isAlert = false
                }))
        })
            if taskOP != .update{
            SupportCall()
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarHidden(true)
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .disabled(environments.ShowBloodType||environments.ShowMedicineAllergy||environments.ShowFoodAllergy)
        .onAppear(perform: {
            if taskOP == .update{
                MedicalprofileVM.execute(Operation: .GetPatientMedicalInfo)
            }
        })
        
        .overlay(
            ZStack{
                if taskOP == .create{
                if environments.ShowBloodType {
                ShowBloodTypeList(ShowBloodType: $environments.ShowBloodType, SelectedBloodName: $environments.SelectedBloodName, SelectedBloodId: $environments.SelectedBloodId)
                
                } else if environments.ShowMedicineAllergy{
                    ShowMedicineAllergyList(ShowMedicineAllergy: $environments.ShowMedicineAllergy, selectedMedicalAlgName: $environments.selectedMedicalAlgName, selectedMedicalAlgId: $environments.selectedMedicalAlgId)
                    
                }else if environments.ShowFoodAllergy{
                    ShowFoodAllergyList(ShowFoodAllergy: $environments.ShowFoodAllergy, selectedFoodAlgName: $environments.selectedFoodAlgName, selectedFoodAlgId: $environments.selectedFoodAlgId)
            }
            }
            }
        )

        
        
//        .overlay(
//            ZStack{
//            if ShowBloodType {
//                ShowBloodTypeList(ShowBloodType: $ShowBloodType, SelectedBloodName: $MedicalprofileVM.BloodTypeName, SelectedBloodId: $MedicalprofileVM.BloodTypeId)
//                
//            } else if ShowMedicineAllergy{
//                ShowMedicineAllergyList(ShowMedicineAllergy: $ShowMedicineAllergy, selectedMedicalAlgName: $MedicalprofileVM.PatientMedicineAllergiesName, selectedMedicalAlgId: $MedicalprofileVM.PatientMedicineAllergiesDto)
//            }else if ShowFoodAllergy{
//                ShowFoodAllergyList(ShowFoodAllergy: $ShowFoodAllergy, selectedFoodAlgName: $MedicalprofileVM.PatientFoodAllergiesName, selectedFoodAlgId: $MedicalprofileVM.PatientFoodAllergiesDto)
//            }
//                
//            }
//        )
        .overlay(
            ActivityIndicatorView(isPresented: $MedicalprofileVM.isLoading)
        )
        
        .background(
            newBackImage(backgroundcolor: .white)
        )

        .onTapGesture(perform: {
            hideKeyboard()
        })

        .onChange(of: MedicalprofileVM.isnormalPressure, perform: {newval in
            if newval == true && MedicalprofileVM.Pressure != MedicalprofileVM.normalPressure{
//                DispatchQueue.global(qos: .userInitiated).async(execute: {
                MedicalprofileVM.Pressure = MedicalprofileVM.normalPressure
//                })
            }else{
//                MedicalprofileVM.FirstName = "15"
            }
        })
        .onChange(of: MedicalprofileVM.isnormalSugar, perform: {newval in
            if newval == true && MedicalprofileVM.SugarLevel != MedicalprofileVM.normalSugar{
//                DispatchQueue.global(qos: .userInitiated).async(execute: {
                MedicalprofileVM.SugarLevel = MedicalprofileVM.normalSugar
//                })
            }else{
//                MedicalprofileVM.MiddelName = "12"
            }
        })
        
        // go to verify account to resset
        //        NavigationLink(destination: ResetPasswordView(),isActive: $resetPassword) {
        //        }
        NavigationLink(destination:TabBarView()
//                        .environmentObject(PatientMedicalInfoViewModel())
                       ,isActive: $MedicalprofileVM.UserCreated , label: {
        })
    }
}

struct PatientMedicalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientMedicalInfoView( taskOP: .create, index: .constant(1))
            .environmentObject(EnvironmentsVM())
    }
}
