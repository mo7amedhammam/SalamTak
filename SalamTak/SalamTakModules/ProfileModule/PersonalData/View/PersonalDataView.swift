//
//  PersonalDataView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import SwiftUI
import Foundation
import UIKit
import CoreLocation

struct PersonalDataView: View {
    
    @State private var keyboardHeight: CGFloat = 0
    
    var language = LocalizationService.shared.language
    
    @State private var image = UIImage()
    @State private var showImageSheet = false
    @State private var startPicking = false
    @State private var imgsource = ""
    @State var bounds = UIScreen.main.bounds
    @State var offset = CGSize.zero
    @FocusState private var focusedInput: Field?
    let screenWidth = UIScreen.main.bounds.size.width - 55
    @State var isValid = false
    @State var ShowingMap = false
    @State var ShowNationality = false
    @State var  buttonSelected = 0
    
    @State var ShowCity = false
    @State var ShowArea = false
    @State var ShowOccupation = false
    
    @StateObject var patientCreatedVM = ViewModelCreatePatientProfile()
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var NationalityVM = ViewModelCountries()
    @StateObject var OccupationVM = ViewModelOccupation()
    
    var body: some View {
        ZStack{
            ZStack{
                VStack {
                    Spacer().frame(height:180)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            ZStack {
                                ZStack {
                                    Button(action: {
                                        
                                    }, label: {
                                        Image(uiImage: patientCreatedVM.profileImage )
                                            .resizable()
                                            .foregroundColor(Color("blueColor"))
                                            .clipShape(Rectangle())
                                    })
                                }
                                .frame(width: 70, height: 70, alignment: .center)
                                .background(Image(systemName: "camera")
                                                .resizable()
                                                .foregroundColor(Color("blueColor").opacity(0.4))
                                                .frame(width: 25, height: 25)
                                                .background(Rectangle()
                                                                .frame(width:70,height:70)
                                                                .foregroundColor(Color("lightGray")).opacity(0.3)
                                                                .cornerRadius(4))
                                )
                                .cornerRadius(10)
                                
                                CircularButton(ButtonImage:Image(systemName: "pencil" ) , forgroundColor: Color.gray, backgroundColor: Color.white.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
                                    self.showImageSheet = true
                                    
                                }.padding(.top,70)
                            } .frame(width: 90, height: 90, alignment: .center)
                                .background(Color.clear)
                            Spacer().frame(height: 20)
                            
                            VStack{
                                HStack(spacing: 10){
                                    Group{
                                        if !patientCreatedVM.errorFirstName.isEmpty{
                                            Text(patientCreatedVM.errorFirstName)
                                        }
                                        if !patientCreatedVM.errorMiddelName.isEmpty{
                                            Text(patientCreatedVM.errorMiddelName)
                                        }
                                        if !patientCreatedVM.errorLastName.isEmpty{
                                            Text(patientCreatedVM.errorMiddelName)
                                        }
                                    }
                                    .font(.system(size: 13))
                                    .padding(.horizontal,20)
                                    .foregroundColor(.red)
                                    .frame(maxWidth:screenWidth ,alignment: .leading)
                                    
                                }
                                
                                HStack (spacing: 10){
                                    Group{
                                        InputTextFieldInfo( text: $patientCreatedVM.FirstName,title: "First Name(*)")
                                            .focused($focusedInput, equals: .firstName)
                                        InputTextFieldInfo( text: $patientCreatedVM.MiddelName,title: "Middle Name(*)")
                                            .focused($focusedInput, equals: .middleName)
                                        InputTextFieldInfo( text: $patientCreatedVM.FamilyName,title: "Last Name(*)")
                                            .focused($focusedInput, equals: .lastName)

                                    }
                                    
                                }
                            }
                            Spacer().frame(height: 20)
                            
                            VStack{
                                HStack(spacing: 10){
                                    Group{
                                        if !patientCreatedVM.errorFirstNameAr.isEmpty{
                                            Text(patientCreatedVM.errorFirstNameAr)
                                        }
                                        if !patientCreatedVM.errorMiddelNameAr.isEmpty{
                                            Text(patientCreatedVM.errorMiddelNameAr)
                                        }
                                        if !patientCreatedVM.errorLastNameAr.isEmpty{
                                            Text(patientCreatedVM.errorLastNameAr)
                                        }
                                    }.font(.system(size: 13))
                                        .padding(.horizontal,20)
                                        .foregroundColor(.red)
                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                }
                                
                                HStack (spacing: 10){
                                    Group{
                                        InputTextFieldInfoArabic( text: $patientCreatedVM.FamilyNameAr,title: "الاسم الاخير(*)")
                                            .focused($focusedInput, equals: .lastNameAr)

                                        InputTextFieldInfoArabic( text: $patientCreatedVM.MiddelNameAr,title: "الاسم الأوسط(*)")
                                            .focused($focusedInput, equals: .middleNameAr)

                                        InputTextFieldInfoArabic( text: $patientCreatedVM.FirstNameAr,title: "الاسم الأول(*)")
                                            .focused($focusedInput, equals: .firstNameAr)

                                    }
                                        .autocapitalization(.none)
                                    
                                }
                            }
                        }
                        Spacer().frame(height: 20)
                        VStack{
                            DateOfBirthView(date: $patientCreatedVM.Birthday)
                            Spacer().frame(height: 20)
                            VStack{
                                Button {
                                    withAnimation {
                                        ShowNationality.toggle()
                                    }
                                } label: {
                                    HStack{
                                        Text(patientCreatedVM.NationalityName == "" ? "Clinic_Screen_country".localized(language): patientCreatedVM.NationalityName)
                                            .foregroundColor(patientCreatedVM.NationalityName == "" ?  Color("lightGray") : Color("blueColor"))
                                        
                                        Spacer()
                                        Image(systemName: "staroflife.fill")
                                            .font(.system(size: 10))
                                            .foregroundColor(patientCreatedVM.NationalityName == "" ? Color.red : Color.white)
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color("lightGray"))
                                    }
                                    .frame(width: screenWidth, height: 30)
                                    .font(.system(size: 13))
                                    .padding(12)
                                    .disableAutocorrection(true)
                                    .background(
                                        Color.white
                                    )                                                .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.099), radius: 3)
                                }
                                Button {
                                    withAnimation {
                                        ShowCity.toggle()
                                    }
                                } label: {
                                    HStack{
                                        Text(patientCreatedVM.cityName == "" ? "Clinic_Screen_city".localized(language): patientCreatedVM.cityName)
                                            .foregroundColor(patientCreatedVM.cityName == "" ?  Color("lightGray") : Color("blueColor"))
                                        
                                        Spacer()
                                        Image(systemName: "staroflife.fill")
                                            .font(.system(size: 10))
                                            .foregroundColor(patientCreatedVM.cityName == "" ? Color.red : Color.white)
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
                                        ShowArea.toggle()
                                    }
                                } label: {
                                    HStack{
                                        Text(patientCreatedVM.areaName == "" ? "Clinic_Screen_area".localized(language):patientCreatedVM.areaName) // needs to handle get country by id
                                            .foregroundColor(patientCreatedVM.areaName == "" ? Color("lightGray"):Color("blueColor"))
                                        
                                        Spacer()
                                        Image(systemName: "staroflife.fill")
                                            .font(.system(size: 10))
                                            .foregroundColor(patientCreatedVM.areaName == "" ? Color.red : Color.white)
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
                            }
                            Spacer().frame(height: 20)
                            InputTextField(text: $patientCreatedVM.EmergencyContact, title: "Emergency Contact (Required)")
                                .focused($focusedInput, equals: .emergancyContact)
                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad)
                                .textInputAutocapitalization(.never)
                            Spacer().frame(height: 20)
                            GenderView(selection: $patientCreatedVM.GenderId)
                            Spacer().frame(height: 20)
                            PickLocationView(longtiude: $patientCreatedVM.Longitude, latitiude: $patientCreatedVM.Latitude)
                                .environmentObject(locationViewModel)
                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                .onTapGesture(perform: {
                                    ShowingMap = true
//                                    if patientCreatedVM.Longitude == 0.0 {
//                                        patientCreatedVM.Longitude = locationViewModel.lastSeenLocation?.coordinate.longitude ?? 5.5
//                                    }
//                                    if patientCreatedVM.Latitude == 0.0 {
//                                        patientCreatedVM.Latitude = locationViewModel.lastSeenLocation?.coordinate.latitude ?? 5.5
//                                    }
                                })
                            VStack{
                                Button {
                                    withAnimation {
                                        ShowOccupation.toggle()
                                    }
                                    
                                } label: {
                                    HStack{
                                        Text(patientCreatedVM.occupationName == "" ? "Clinic_Screen_occupation".localized(language): patientCreatedVM.occupationName)
                                            .foregroundColor(patientCreatedVM.occupationName == "" ? Color("lightGray"):Color("blueColor"))
                                        
                                        Spacer()
                                        Image(systemName: "staroflife.fill")
                                            .font(.system(size: 10))
                                            .foregroundColor(patientCreatedVM.occupationName == "" ? Color.red : Color.white)
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
                                
                                Group{
                                    InputTextField(text: $patientCreatedVM.Address, title: "Clinic_Screen_street".localized(language))
                                        .focused($focusedInput, equals: .streetName)

                                    InputTextField(text: $patientCreatedVM.BlockNo, title: "Clinic_Screen_building".localized(language))
                                        .focused($focusedInput, equals: .buildingNumber)

                                    InputTextField(text: $patientCreatedVM.FloorNo.string(), title: "Clinic_Screen_floor".localized(language))
                                        .keyboardType(.numberPad)
                                        .focused($focusedInput, equals: .floorNumber)

                                    InputTextField(text: $patientCreatedVM.ApartmentNo, title: "Apartment Number".localized(language))
                                        .focused($focusedInput, equals: .apartmentNumber)
                                }
                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                    .autocapitalization(.none)
                                    .textInputAutocapitalization(.never)
                            }
                        }
                    }
                    .keyboardSpace()
                    Spacer().frame(height:120)
                }
                InfoAppBarView(Maintext: "CompeleteProfile_Screen_title".localized(language), text: "CompeleteProfile_Screen_subtitle".localized(language), Nexttext: "CompeleteProfile_Screen_secondSubTitle".localized(language),image: "1-3",navBarHidden:true)
                    .offset(y: -10)
                    .edgesIgnoringSafeArea(.top)

                CustomActionBottomSheet( ConfirmTitle: "CompeleteProfile_Screen_Next_Button".localized(language), CancelTitle: "CompeleteProfile_Screen_Previos_Button".localized(language), Confirmaction:   {
                    DispatchQueue.main.async {
                        patientCreatedVM.startCreatePatientProfile(profileImage: patientCreatedVM.profileImage)
                    }
                }, Cancelaction:  {
                    //                                        self.presentationMode.wrappedValue.dismiss()
                }, isValid: $isValid)
                
            }
            
            
            //                }
            .ignoresSafeArea()
            .blur(radius: ShowOccupation || ShowCity || ShowNationality || ShowArea ? 5 : 0)
            .disabled(ShowOccupation || ShowCity || ShowNationality || ShowArea)
            if ShowNationality {
                ShowNationalityList( ShowNationality: $ShowNationality, bounds: $bounds, offset: $offset)
                    .environmentObject(patientCreatedVM)
                    .environmentObject(NationalityVM)
            }
            else if ShowCity{
                ShowCityList( ShowCity: $ShowCity, bounds: $bounds, offset: $offset).environmentObject(patientCreatedVM)
                
            }
            else if ShowArea {
                ShowAreaList( ShowArea: $ShowArea, bounds: $bounds, offset: $offset).environmentObject(patientCreatedVM)
                
            }
            else if ShowOccupation {
                ShowOccupationList( ShowOccupation: $ShowOccupation, bounds: $bounds, offset: $offset).environmentObject(patientCreatedVM)
                    .environmentObject(OccupationVM)
            }
            // showing loading indicator
            ActivityIndicatorView(isPresented: $patientCreatedVM.isLoading)

        }
        .navigationViewStyle(StackNavigationViewStyle())

        .onAppear(perform: {
            NationalityVM.startFetchCountries()
            OccupationVM.startFetchOccupation()
            
           
            DispatchQueue.main.async {
                locationViewModel.requestPermission()

                if patientCreatedVM.Longitude == 0.0 {
                    patientCreatedVM.Longitude = locationViewModel.lastSeenLocation?.coordinate.longitude ?? 5.5
                }
                if patientCreatedVM.Latitude == 0.0 {
                    patientCreatedVM.Latitude = locationViewModel.lastSeenLocation?.coordinate.latitude ?? 5.5
                }
                getAddressFromLatLon(pdblLatitude: "\(locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0.0)", withLongitude: "\(locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0.0)")
            }
        })
        .onChange(of: focusedInput) {_ in
            readyToGo()
        }
        .onChange(of: patientCreatedVM.Address) {_ in
            readyToGo()
        }
        .onChange(of: patientCreatedVM.FamilyNameAr) {_ in
            readyToGo()
        }
        .onChange(of: patientCreatedVM.AreaId) {_ in
            readyToGo()
        }
        .onChange(of: patientCreatedVM.OccupationId) {_ in
            readyToGo()
        }
        .toolbar{
            ToolbarItemGroup(placement: .keyboard ){
                Button("Done"){
                    dismissKeyboard()
                    readyToGo()
                }
                
                Spacer()
                
                Button(action: previous) {
                    Image(systemName: "chevron.up")
                    
                }
                .disabled(hasReachedStart)
                
                Button(action: next) {
                    Image(systemName: "chevron.down")
                    
                }
                .disabled(hasReachedEnd)
                
                
            }
        }
        .sheet(isPresented: $ShowingMap) {
            ViewMapWithPin(showmap: $ShowingMap, title: "", subtitle: "", longtude: $patientCreatedVM.Longitude , latitude: $patientCreatedVM.Latitude ).environmentObject(locationViewModel)
        }
        //MARK: -------- imagePicker From Camera and Library ------
        .confirmationDialog("Choose Image From ?", isPresented: $showImageSheet) {
            Button("photo Library") { self.imgsource = "Library";   self.showImageSheet = false; self.startPicking = true }
            Button("Camera") {self.imgsource = "Cam" ;    self.showImageSheet = false; self.startPicking = true}
            Button("Cancel", role: .cancel) { }
        } message: {Text("Select Image From")}
        
        .sheet(isPresented: $startPicking) {
            if imgsource == "Library"{
                // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$patientCreatedVM.profileImage)
            }else{
                //  If you wish to take a photo from camera instead:
                ImagePicker(sourceType: .camera, selectedImage: self.$patientCreatedVM.profileImage)
            }
        }
        
        //            // alert with no ierror message
        .alert(patientCreatedVM.message, isPresented: $patientCreatedVM.isAlert) {
            Button("OK".localized(language), role: .cancel) { }
        }
        
        NavigationLink(destination:MedicalStateView(),isActive: $patientCreatedVM.UserCreated , label: {
        })
    }
    
}

struct PersonalDataView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PersonalDataView()
        }
    }
}

extension Binding where Value == Int {
    public func string() -> Binding<String> {
        return Binding<String>(get:{ "\(self.wrappedValue)" },
                               set: {
            guard $0.count > 0 else { return }
            self.wrappedValue = Int(Double($0) ?? 0)
        })
    }
}





extension PersonalDataView{
    enum Field: Int, Hashable, CaseIterable {
        case firstName
        case middleName
        case lastName
        case firstNameAr
        case middleNameAr
        case lastNameAr
        case emergancyContact
        case streetName
        case buildingNumber
        case floorNumber
        case apartmentNumber
    }
    
    var hasReachedEnd: Bool {
        focusedInput == Field.allCases.last
    }
    
    var hasReachedStart: Bool {
        focusedInput == Field.allCases.first
    }
    
    func dismissKeyboard() {
        focusedInput = nil
    }
    
    func next() {
        
        guard let currentInput = focusedInput,
              let lastIndex = Field.allCases.last?.rawValue else { return }
        
        let index = min(currentInput.rawValue + 1, lastIndex)
        focusedInput = Field(rawValue: index)
    }
    
    func previous() {
        
        guard let currentInput = focusedInput,
              let firstIndex = Field.allCases.first?.rawValue else { return }
        
        let index = max(currentInput.rawValue - 1, firstIndex)
        focusedInput = Field(rawValue: index)
    }
    
    func readyToGo(){
        if patientCreatedVM.FirstName != "" && patientCreatedVM.FirstNameAr != "" && patientCreatedVM.MiddelName != "" && patientCreatedVM.MiddelNameAr != "" && patientCreatedVM.FamilyName != "" && patientCreatedVM.FamilyNameAr != "" &&  patientCreatedVM.NationalityId != 0 && patientCreatedVM.CityId != 0 && patientCreatedVM.AreaId != 0 && patientCreatedVM.EmergencyContact != "" && patientCreatedVM.OccupationId != 0 && patientCreatedVM.Address != "" && patientCreatedVM.GenderId != 0{
            isValid = true
        }else{
            isValid = false
        }
    }
}

