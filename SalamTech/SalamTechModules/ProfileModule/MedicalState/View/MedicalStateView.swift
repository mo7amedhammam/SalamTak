//
//  MedicalStateView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import SwiftUI

struct MedicalStateView: View {
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
    
    @StateObject var medicalCreatedVM = ViewModelCreateMedicalProfile()
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
                                InfoAppBarView(Maintext: "CompeleteProfile_Screen_title".localized(language), text: "Certificates_Screen_subtitle".localized(language),image: "2-3")
                                    .offset(y: -10)
                                    
                                Spacer().frame(height: 90)
                                
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack{
                                        Spacer().frame(height: 30)
                                        HStack(spacing: 40){
                                            InputTextFieldMedicalInfo(text: $medicalCreatedVM.Height.string(), title: "Height")
                                                .focused($isfocused)
                                                .keyboardType(.numberPad)
                                            InputTextFieldMedicalInfo(text: $medicalCreatedVM.Weight.string(), title: "Weight")
                                                .focused($isfocused)
                                                .keyboardType(.numberPad)
                                        }
                                        Spacer().frame(height: 20)
                                        
                                        MedicalTextFieldInfo(text: $medicalCreatedVM.Pressure, text1: $normalPressure, title: "Pressure(MM/HG)")
                                            .focused($isfocused)
                                            .keyboardType(.numberPad)
                                        Spacer().frame(height: 20)
                                        MedicalTextFieldInfo(text: $medicalCreatedVM.SugarLevel, text1: $normalSugar, title: "Sugar Level(MG/DL)")
                                            .focused($isfocused)
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
                                                    Text(medicalCreatedVM.BloodTypeName)
                                                        .foregroundColor(Color("lightGray"))
                                                    
                                                    Spacer()
                                                    Image(systemName: "staroflife.fill")
                                                        .font(.system(size: 10))
                                                        .foregroundColor(medicalCreatedVM.BloodTypeName == "" ? Color.red : Color.white)
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
                                            InputTextField(text: $medicalCreatedVM.OtherAllergies, title: "Other Allergies")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalCreatedVM.Prescriptions, title: "Prescriptions")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalCreatedVM.CurrentMedication, title: "CurrentMedication")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                               
                                                .textInputAutocapitalization(.never)
                                            
                                            
                                        }
                                        VStack{
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalCreatedVM.PastMedication, title: "PastMedication")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalCreatedVM.ChronicDiseases, title: "ChronicDiseases")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalCreatedVM.Iinjuries, title: "Iinjuries")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                                
                                                .textInputAutocapitalization(.never)
                                            Spacer().frame(height: 20)
                                            InputTextField(text: $medicalCreatedVM.Surgeries, title: "Surgeries")
                                                .focused($isfocused)
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                                .autocapitalization(.none)
                                               
                                                .textInputAutocapitalization(.never)
                                        }
                                        
                                        
                                       
                                    }
                                }
                               
                                Spacer()
                                CustomActionBottomSheet( ConfirmTitle: "CompeleteProfile_Screen_Next_Button".localized(language), CancelTitle: "CompeleteProfile_Screen_Previos_Button".localized(language), Confirmaction:   {
//                                    patientCreatedVM.DoctorSubSpecialist = self.SubSpecIDArr
//                                    print(SubSpecIDArr)
//                                    print(patientCreatedVM.DoctorSubSpecialist)
                                    DispatchQueue.main.async {


                                        print("let's create profiles")

                                        print(medicalCreatedVM.Height)
                                        print(medicalCreatedVM.Weight)
                                        print(medicalCreatedVM.Pressure)
                                        print(medicalCreatedVM.SugarLevel)
                                        print(medicalCreatedVM.PatientFoodAllergiesDto)
                                        print(medicalCreatedVM.PatientMedicineAllergiesDto)
//                                        print(medicalCreatedVM.NationalityId)
////                                        print(medicalCreatedVM.Birthday ?? Date())
////                                        print(datef.string(from: patientCreatedVM.Birthday ?? Date()) )
//                                        //                                    print(patientCreatedVM.Birthday?.dateformatter)
//
//                                        print(patientCreatedVM.GenderId ?? 0)
//                                        print(patientCreatedVM.CityId)
//                                        print(patientCreatedVM.AreaId)
//                                        print(patientCreatedVM.OccupationId)
//                                        print(patientCreatedVM.Latitude )
//                                        print(patientCreatedVM.Longitude )
//                                        print(patientCreatedVM.BlockNo )
//                                        print(patientCreatedVM.Address )
//                                        print(patientCreatedVM.FloorNo )
//                                        print(patientCreatedVM.ApartmentNo )
//                                        print(patientCreatedVM.EmergencyContact )

//                                            patientCreatedVM.isLoading = true
//                                        patientCreatedVM.startCreatePatientProfile(profileImage: patientCreatedVM.profileImage)
                                        
                                        if medicalCreatedVM.Pressure == "" {
                                            medicalCreatedVM.Pressure = self.normalPressure
                                        }
                                        if medicalCreatedVM.SugarLevel == "" {
                                            medicalCreatedVM.SugarLevel = self.normalSugar
                                        }
                                        print("pressure")
                                        print(medicalCreatedVM.Pressure)
                                        medicalCreatedVM.startCreateMedicalProfile()
                                    }

                                }, Cancelaction:  {
                                    //                                        self.presentationMode.wrappedValue.dismiss()
                                }, isValid: $isValid)
                            }
                            
                        }
                    }
                    .ignoresSafeArea()
                    .background(Color("CLVBG"))
                    .blur(radius: ShowOccupation || ShowFoodAllergy || ShowBloodType || ShowMedicineAllergy ? 10 : 0)
                    .disabled(ShowOccupation || ShowFoodAllergy || ShowBloodType || ShowMedicineAllergy)
                    if ShowBloodType {
                        ZStack {
                            
                            ChooseBloodType( BloodTypeVM: BloodTypeVM, IsPresented:$ShowBloodType ,  SelectedBloodName: $medicalCreatedVM.BloodTypeName, SelectedBloodId: $medicalCreatedVM.BloodTypeId, width: bounds.size.width)
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
                            ChooseFoodAllergy(IsPresented: $ShowFoodAllergy, selectedServiceName: $medicalCreatedVM.PatientFoodAllergiesName, selectedServiceId: $medicalCreatedVM.PatientFoodAllergiesDto,  width: UIScreen.main.bounds.size.width)
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
                            ChooseMedicineAllergy(IsPresented: $ShowMedicineAllergy, selectedServiceName: $medicalCreatedVM.PatientMedicineAllergiesName, selectedServiceId: $medicalCreatedVM.PatientMedicineAllergiesDto,  width: UIScreen.main.bounds.size.width)
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
                        if medicalCreatedVM.Height != 0 && medicalCreatedVM.Weight != 0  && medicalCreatedVM.BloodTypeId != 0 {
                            isValid = true
                        }else {
                            isValid = false
                        }
//                        if medicalCreatedVM.Height != 0 && medicalCreatedVM.Weight != 0 && medicalCreatedVM.BloodTypeId != 0 && medicalCreatedVM.PatientMedicineAllergiesDto != [] && medicalCreatedVM.PatientMedicineAllergiesDto != []{
//                            isValid = true
//                        }
                    }
                }
            }
            
            // Alert with no internet connection
            .alert(isPresented: $medicalCreatedVM.isNetworkError, content: {
                Alert(title: Text("Check Your Internet Connection"), message: nil, dismissButton: .cancel())
            })
            
            // alert with no ierror message
            .alert(medicalCreatedVM.errorMsg, isPresented: $medicalCreatedVM.isError) {
                Button("OK", role: .cancel) { }
            }
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $medicalCreatedVM.isLoading)
        }
        NavigationLink(destination:TabBarView(),isActive: $medicalCreatedVM.UserCreated , label: {
        })
    }
}

struct MedicalStateView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalStateView()
    }
}
