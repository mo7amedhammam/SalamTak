//
//  UpdateMedicalStateView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 07/04/2022.
//

import SwiftUI

struct UpdateMedicalStateView: View {
    var language = LocalizationService.shared.language
   
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
//                                InfoAppBarView(Maintext: "CompeleteProfile_Screen_title".localized(language), text: "Certificates_Screen_subtitle".localized(language),image: "2-3")
//                                    .offset(y: -10)
//                                    
//                                Spacer().frame(height: 90)
                                
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack{
                                        Spacer().frame(height: 30)
                                        HStack(spacing: 40){
                                            InputTextFieldMedicalInfo(text: $medicalUpdatedVM.Height.string(), title: "Height")
                                                .focused($isfocused)
                                                .keyboardType(.numberPad)
                                            InputTextFieldMedicalInfo(text: $medicalUpdatedVM.Weight.string(), title: "Weight")
                                                .focused($isfocused)
                                                .keyboardType(.numberPad)
                                        }
                                        Spacer().frame(height: 20)
                                        
                                        MedicalTextFieldInfo(text: $medicalUpdatedVM.Pressure, text1: $normalPressure, title: "Pressure(MM/HG)")
                                            .focused($isfocused)
                                            .keyboardType(.numberPad)
                                        Spacer().frame(height: 20)
                                        MedicalTextFieldInfo(text: $medicalUpdatedVM.SugarLevel, text1: $normalSugar, title: "Sugar Level(MG/DL)")
                                            .focused($isfocused)
                                            .keyboardType(.numberPad)
                                        
                                        Spacer().frame(height: 20)
                                        VStack{
                                            Button {
                                                
                                                withAnimation {
                                                    ShowBloodType.toggle()
                                                    
                                                }
                                                
                                            } label: {
                                                HStack{
                                                    Text(medicalUpdatedVM.BloodTypeName)
                                                        .foregroundColor(Color("lightGray"))
                                                    
                                                    Spacer()
                                                    Image(systemName: "staroflife.fill")
                                                        .font(.system(size: 10))
                                                        .foregroundColor(medicalUpdatedVM.BloodTypeName == "" ? Color.red : Color.white)
                                                    Image(systemName: "chevron.forward")
                                                        .foregroundColor(Color("lightGray"))
                                                }
                                                .animation(.default)
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
    //                                            .animation(.default)
                                                .animation(.default)
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
    //                                            .animation(.default)
                                                .animation(.default)
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
                                            InputTextField(text: $medicalUpdatedVM.OtherAllergies, title: "Other Allergies")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalUpdatedVM.Prescriptions, title: "Prescriptions")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalUpdatedVM.CurrentMedication, title: "CurrentMedication")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                               
                                                .textInputAutocapitalization(.never)
                                            
                                            
                                        }
                                        VStack{
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalUpdatedVM.PastMedication, title: "PastMedication")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalUpdatedVM.ChronicDiseases, title: "ChronicDiseases")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalUpdatedVM.Iinjuries, title: "Iinjuries")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalUpdatedVM.Surgeries, title: "Surgeries")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                               
                                                .textInputAutocapitalization(.never)
                                        }
                                        
                                        
                                       
                                    }
                                }
                               
                                Spacer()
                                ButtonView(text: "Update Profile", action: {
                                    medicalUpdatedVM.startUpdateMedicalProfile()
                                })
//                                CustomActionBottomSheet( ConfirmTitle: "CompeleteProfile_Screen_Next_Button".localized(language), CancelTitle: "CompeleteProfile_Screen_Previos_Button".localized(language), Confirmaction:   {
////                                    patientCreatedVM.DoctorSubSpecialist = self.SubSpecIDArr
////                                    print(SubSpecIDArr)
////                                    print(patientCreatedVM.DoctorSubSpecialist)
//                                    DispatchQueue.main.async {
//
//
//                                        print("let's create profiles")
//
//                                        print(medicalUpdatedVM.Height)
//                                        print(medicalUpdatedVM.Weight)
//                                        print(medicalUpdatedVM.Pressure)
//                                        print(medicalUpdatedVM.SugarLevel)
//                                        print(medicalUpdatedVM.PatientFoodAllergiesDto)
//                                        print(medicalUpdatedVM.PatientMedicineAllergiesDto)
////                                        print(medicalUpdatedVM.NationalityId)
//////                                        print(medicalUpdatedVM.Birthday ?? Date())
//////                                        print(datef.string(from: patientCreatedVM.Birthday ?? Date()) )
////                                        //                                    print(patientCreatedVM.Birthday?.dateformatter)
////
////                                        print(patientCreatedVM.GenderId ?? 0)
////                                        print(patientCreatedVM.CityId)
////                                        print(patientCreatedVM.AreaId)
////                                        print(patientCreatedVM.OccupationId)
////                                        print(patientCreatedVM.Latitude )
////                                        print(patientCreatedVM.Longitude )
////                                        print(patientCreatedVM.BlockNo )
////                                        print(patientCreatedVM.Address )
////                                        print(patientCreatedVM.FloorNo )
////                                        print(patientCreatedVM.ApartmentNo )
////                                        print(patientCreatedVM.EmergencyContact )
//
////                                            patientCreatedVM.isLoading = true
////                                        patientCreatedVM.startCreatePatientProfile(profileImage: patientCreatedVM.profileImage)
//
//                                        if medicalUpdatedVM.Pressure == "" {
//                                            medicalUpdatedVM.Pressure = self.normalPressure
//                                        }
//                                        if medicalUpdatedVM.SugarLevel == "" {
//                                            medicalUpdatedVM.SugarLevel = self.normalSugar
//                                        }
//                                        print("pressure")
//                                        print(medicalUpdatedVM.Pressure)
//                                        medicalUpdatedVM.startCreateMedicalProfile()
//                                    }
//
//                                }, Cancelaction:  {
//                                    //                                        self.presentationMode.wrappedValue.dismiss()
//                                }, isValid: $isValid)
                            }
                            
                        }
                    }
                    .ignoresSafeArea()
                    .background(Color("CLVBG"))
                    .blur(radius: ShowOccupation || ShowFoodAllergy || ShowBloodType || ShowMedicineAllergy ? 10 : 0)
                    .disabled(ShowOccupation || ShowFoodAllergy || ShowBloodType || ShowMedicineAllergy)
                    if ShowBloodType {
                        ZStack {
                            
                            ChooseBloodType( BloodTypeVM: BloodTypeVM, IsPresented:$ShowBloodType ,  SelectedBloodName: $medicalUpdatedVM.BloodTypeName, SelectedBloodId: $medicalUpdatedVM.BloodTypeId, width: bounds.size.width)
                        }
                        .animation(.easeInOut)
                        .transition(.move(edge: .bottom))
                        .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    self.offset.height = gesture.translation.height
                                }
                                .onEnded { _ in
                                    if self.offset.height > bounds.size.height / 2 {
                                        withAnimation {
                                            ShowBloodType.toggle()
                                        }
                                        self.offset = .zero
                                    } else {
                                        self.offset = .zero
                                    }
                                }
                        )
                    } else if ShowFoodAllergy{
                        ZStack {
                            ChooseFoodAllergy(IsPresented: $ShowFoodAllergy, selectedServiceName: $medicalUpdatedVM.PatientFoodAllergiesName, selectedServiceId: $medicalUpdatedVM.PatientFoodAllergiesDto,  width: UIScreen.main.bounds.size.width)
                        }
//                                .animation(.easeInOut)
                        .transition(.move(edge: .bottom))
                        .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    self.offset.height = gesture.translation.height

                                }
                                .onEnded { _ in
                                    if self.offset.height > bounds.size.height / 2 {
                                        withAnimation {
                                            ShowFoodAllergy = false
                                        }
                                        self.offset = .zero
                                    } else {
                                        self.offset = .zero
                                    }
                                }

                        )
                    } else if ShowMedicineAllergy{
                        ZStack {
                            ChooseMedicineAllergy(IsPresented: $ShowMedicineAllergy, selectedServiceName: $medicalUpdatedVM.PatientMedicineAllergiesName, selectedServiceId: $medicalUpdatedVM.PatientMedicineAllergiesDto,  width: UIScreen.main.bounds.size.width)
                        }
//                                .animation(.easeInOut)
                        .transition(.move(edge: .bottom))
                        .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    self.offset.height = gesture.translation.height

                                }
                                .onEnded { _ in
                                    if self.offset.height > bounds.size.height / 2 {
                                        withAnimation {
                                            ShowFoodAllergy = false
                                        }
                                        self.offset = .zero
                                    } else {
                                        self.offset = .zero
                                    }
                                }

                        )
                    }
                    
                   
                }
                .onAppear(perform: {
                    medicalUpdatedVM.startFetchPatientMedicalState()
//                    NationalityVM.startFetchCountries()
//                    OccupationVM.startFetchOccupation()
                    BloodTypeVM.startFetchBloodTypes()
                    print(Helper.getAccessToken())
                })
                
            }
            .toolbar{
                ToolbarItemGroup(placement: .keyboard ){
                    Spacer()
                    Button("Done"){
                        isfocused = false
//                        if medicalUpdatedVM.Height != 0 && medicalUpdatedVM.Weight != 0 && medicalUpdatedVM.BloodTypeId != 0 && medicalUpdatedVM.PatientMedicineAllergiesDto != [] && medicalUpdatedVM.PatientMedicineAllergiesDto != []{
//                            isValid = true
//                        }
                    }
                }
            }
            
            // Alert with no internet connection
            .alert(isPresented: $medicalUpdatedVM.isNetworkError, content: {
                Alert(title: Text("Check Your Internet Connection"), message: nil, dismissButton: .cancel())
            })
            
            // alert with no ierror message
            .alert(medicalUpdatedVM.errorMsg, isPresented: $medicalUpdatedVM.isError) {
                Button("OK", role: .cancel) { }
            }
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $medicalUpdatedVM.isLoading)
        }
//        NavigationLink(destination:TabBarView(),isActive: $medicalUpdatedVM.UserCreated , label: {
//        })
    }
}

struct UpdateMedicalStateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateMedicalStateView()
    }
}
