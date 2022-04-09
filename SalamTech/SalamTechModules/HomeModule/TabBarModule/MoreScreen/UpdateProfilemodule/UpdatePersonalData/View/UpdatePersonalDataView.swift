//
//  UpdatePersonalDataView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 07/04/2022.
//

import SwiftUI

struct UpdatePersonalDataView: View {
    var language = LocalizationService.shared.language
    @State var showNationailty = false
    @State var showCity = false
    @State var showArea = false
    
    @State private var image = UIImage()
    @State private var showImageSheet = false
    @State private var startPicking = false
    @State private var imgsource = ""
    
    @State var offset = CGSize.zero
    @FocusState private var isfocused : Bool
    let screenWidth = UIScreen.main.bounds.size.width - 55
    @State var isValid = false
    @State var ShowingMap = false
    @State var ShowNationality = false
    @State var ShowCity = false
    @State var ShowArea = false
    @State var ShowOccupation = false
    
    @StateObject var patientUpdatedVM = ViewModelUpdatePatientProfile()
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var NationalityVM = ViewModelCountries()
    @StateObject var OccupationVM = ViewModelOccupation()
    var body: some View {
        ZStack{
            GeometryReader{ bounds in
                ZStack{
                    VStack{
                        ZStack{
                            VStack{
//                                InfoAppBarView(Maintext: "CompeleteProfile_Screen_title".localized(language), text: "CompeleteProfile_Screen_subtitle".localized(language), Nexttext: "CompeleteProfile_Screen_secondSubTitle".localized(language),image: "1-3")
//                                    .offset(y: -10)
                                    
                                Spacer().frame(height: 90)
                                
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack{
                                        ZStack {
                                            ZStack {
                                                Button(action: {
            
                                                }, label: {
                                                    

                                                    Image(uiImage: patientUpdatedVM.profileImage )
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
                                                if !patientUpdatedVM.errorFirstName.isEmpty{
                                                    Text(patientUpdatedVM.errorFirstName)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                                if !patientUpdatedVM.errorMiddelName.isEmpty{
                                                    Text(patientUpdatedVM.errorMiddelName)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth ,alignment: .leading)
                                                }
                                                if !patientUpdatedVM.errorLastName.isEmpty{
                                                    Text(patientUpdatedVM.errorMiddelName)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                            }
                                            
                                            HStack (spacing: 10){
                                                InputTextFieldInfo( text: $patientUpdatedVM.FirstName,title: "First Name(*)")
                                                    .focused($isfocused)
                                                InputTextFieldInfo( text: $patientUpdatedVM.MiddelName,title: "Middle Name(*)")
                                                    .focused($isfocused)
                                                InputTextFieldInfo( text: $patientUpdatedVM.FamilyName,title: "Last Name(*)")
                                                    .focused($isfocused)
                                            }
                                        }
                                        Spacer().frame(height: 20)
                                        
                                        VStack{
                                            HStack(spacing: 10){
                                                if !patientUpdatedVM.errorFirstNameAr.isEmpty{
                                                    Text(patientUpdatedVM.errorFirstNameAr)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                                if !patientUpdatedVM.errorMiddelNameAr.isEmpty{
                                                    Text(patientUpdatedVM.errorMiddelNameAr)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                                if !patientUpdatedVM.errorLastNameAr.isEmpty{
                                                    Text(patientUpdatedVM.errorLastNameAr)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                            }
                                            
                                            HStack (spacing: 10){
                                                InputTextFieldInfoArabic( text: $patientUpdatedVM.FamilyNameAr,title: "الاسم الاخير(*)")
                                                    .focused($isfocused)
                                                    .autocapitalization(.none)
                                                InputTextFieldInfoArabic( text: $patientUpdatedVM.MiddelNameAr,title: "الاسم الأوسط(*)")
                                                    .focused($isfocused)
                                                    .autocapitalization(.none)
                                                InputTextFieldInfoArabic( text: $patientUpdatedVM.FirstNameAr,title: "الاسم الأول(*)")
                                                    .focused($isfocused)
                                                    .autocapitalization(.none)
                                                
                                                
                                            }
                                        }
                                    }
                                    Spacer().frame(height: 20)
                                    VStack{
                                        DateOfBirthView(date: $patientUpdatedVM.Birthday)
                                        
                                        Spacer().frame(height: 20)
                                        
//                                        VStack{
//                                            Button {
//
//                                                withAnimation {
//                                                    ShowNationality.toggle()
//
//                                                }
//
//                                            } label: {
//                                                HStack{
//                                                    Text(patientUpdatedVM.NationalityName)
//                                                        .foregroundColor(Color("lightGray"))
//
//                                                    Spacer()
//                                                    Image(systemName: "staroflife.fill")
//                                                        .font(.system(size: 10))
//                                                        .foregroundColor(patientUpdatedVM.NationalityName == "" ? Color.red : Color.white)
//                                                    Image(systemName: "chevron.forward")
//                                                        .foregroundColor(Color("lightGray"))
//                                                }
//                                                .animation(.default)
//                                                .frame(width: screenWidth, height: 30)
//                                                .font(.system(size: 13))
//                                                .padding(12)
//                                                .disableAutocorrection(true)
//                                                .background(
//                                                    Color.white
//                                                ).foregroundColor(Color("blueColor"))
//                                                    .cornerRadius(5)
//                                                    .shadow(color: Color.black.opacity(0.099), radius: 3)
//                                            }
//                                            Button {
//                                                withAnimation {
//                                                    ShowCity.toggle()
//                                                }
//
//                                            } label: {
//                                                HStack{
//                                                    Text(patientUpdatedVM.cityName == "" ? "Clinic_Screen_city".localized(language): patientUpdatedVM.cityName) // needs to handle get country by id
//                                                        .foregroundColor(patientUpdatedVM.cityName == "" ?  Color("lightGray") : Color("blueColor"))
//
//                                                    Spacer()
//                                                    Image(systemName: "staroflife.fill")
//                                                        .font(.system(size: 10))
//                                                        .foregroundColor(patientUpdatedVM.cityName == "" ? Color.red : Color.white)
//                                                    Image(systemName: "chevron.forward")
//                                                        .foregroundColor(Color("lightGray"))
//                                                }
//                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//    //                                            .animation(.default)
//                                                .animation(.default)
//                                                .frame(width: screenWidth, height: 30)
//                                                .font(.system(size: 13))
//                                                .padding(12)
//                                                .disableAutocorrection(true)
//                                                .background(
//                                                    Color.white
//                                                ).foregroundColor(Color("blueColor"))
//                                                    .cornerRadius(5)
//                                                    .shadow(color: Color.black.opacity(0.099), radius: 3)
//                                            }
//
//                                            Button {
//
//                                                withAnimation {
//                                                    ShowArea.toggle()
//                                                }
//
//
//                                            } label: {
//                                                HStack{
//                                                    Text(patientUpdatedVM.areaName == "" ? "Clinic_Screen_area".localized(language):patientUpdatedVM.areaName) // needs to handle get country by id
//                                                        .foregroundColor(patientUpdatedVM.areaName == "" ? Color("lightGray"):Color("blueColor"))
//
//                                                    Spacer()
//                                                    Image(systemName: "staroflife.fill")
//                                                        .font(.system(size: 10))
//                                                        .foregroundColor(patientUpdatedVM.areaName == "" ? Color.red : Color.white)
//                                                    Image(systemName: "chevron.forward")
//                                                        .foregroundColor(Color("lightGray"))
//                                                }
//                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//    //                                            .animation(.default)
//                                                .animation(.default)
//                                                .frame(width: screenWidth, height: 30)
//                                                .font(.system(size: 13))
//                                                .padding(12)
//                                                .disableAutocorrection(true)
//                                                .background(
//                                                    Color.white
//                                                ).foregroundColor(Color("blueColor"))
//                                                    .cornerRadius(5)
//                                                    .shadow(color: Color.black.opacity(0.099), radius: 3)
//                                            }
//                                        }
//                                        Spacer().frame(height: 20)
//                                        InputTextField(text: $patientUpdatedVM.EmergencyContact, title: "Emergency Contact (Required)")
//                                            .focused($isfocused)
//                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                            .autocapitalization(.none)
//                                            .keyboardType(.numberPad)
//                                            .textInputAutocapitalization(.never)
//                                        Spacer().frame(height: 20)
//                                        GenderView(selection: $patientUpdatedVM.GenderId)
//                                        Spacer().frame(height: 20)
//                                        TrackingView()
//                                            .environmentObject(locationViewModel)
//                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                            .onTapGesture(perform: {
//                                                ShowingMap = true
//                                                if patientUpdatedVM.Longitude == 0.0 {
//                                                    patientUpdatedVM.Longitude = locationViewModel.lastSeenLocation?.coordinate.longitude ?? 5.5
//                                                }
//                                                if patientUpdatedVM.Latitude == 0.0 {
//                                                    patientUpdatedVM.Latitude = locationViewModel.lastSeenLocation?.coordinate.latitude ?? 5.5
//                                                }
//    //                                            print(locationViewModel.lastSeenLoca0
//                                            })
//                                        VStack{
//                                            Button {
//
//                                                withAnimation {
//                                                    ShowOccupation.toggle()
//
//                                                }
//
//                                            } label: {
//                                                HStack{
//                                                    Text(patientUpdatedVM.occupationName)
//                                                        .foregroundColor(Color("lightGray"))
//
//                                                    Spacer()
//                                                    Image(systemName: "staroflife.fill")
//                                                        .font(.system(size: 10))
//                                                        .foregroundColor(patientUpdatedVM.occupationName == "" ? Color.red : Color.white)
//                                                    Image(systemName: "chevron.forward")
//                                                        .foregroundColor(Color("lightGray"))
//                                                }
//                                                .animation(.default)
//                                                .frame(width: screenWidth, height: 30)
//                                                .font(.system(size: 13))
//                                                .padding(12)
//                                                .disableAutocorrection(true)
//                                                .background(
//                                                    Color.white
//                                                ).foregroundColor(Color("blueColor"))
//                                                    .cornerRadius(5)
//                                                    .shadow(color: Color.black.opacity(0.099), radius: 3)
//                                            }
//                                            InputTextField(text: $patientUpdatedVM.Address, title: "Clinic_Screen_street".localized(language))
//                                                .focused($isfocused).autocapitalization(.none)
//                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//
//
//                                            InputTextField(text: $patientUpdatedVM.BlockNo, title: "Clinic_Screen_building".localized(language))
//                                                .focused($isfocused)
//                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                                .autocapitalization(.none)
//    //                                            .keyboardType(.numberPad)
//                                                .textInputAutocapitalization(.never)
//                                            InputTextField(text: $patientUpdatedVM.FloorNo.string(), title: "Clinic_Screen_floor".localized(language))
//                                                .focused($isfocused)
//                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                                .autocapitalization(.none)
//                                                .keyboardType(.numberPad)
//                                                .textInputAutocapitalization(.never)
//
//                                            InputTextField(text: $patientUpdatedVM.ApartmentNo, title: "Apartment Number".localized(language))
//                                                .focused($isfocused)
//                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                                .autocapitalization(.none)
//    //                                            .keyboardType(.numberPad)
//                                                .textInputAutocapitalization(.never)
//                                        }
                                    }
                                }
                               
                                Spacer()
//                                CustomActionBottomSheet( ConfirmTitle: "CompeleteProfile_Screen_Next_Button".localized(language), CancelTitle: "CompeleteProfile_Screen_Previos_Button".localized(language), Confirmaction:   {
////                                    patientUpdatedVM.DoctorSubSpecialist = self.SubSpecIDArr
////                                    print(SubSpecIDArr)
////                                    print(patientUpdatedVM.DoctorSubSpecialist)
//                                    DispatchQueue.main.async {
//
//
//                                        print("let's create profiles")
//
//                                        print(patientUpdatedVM.FirstName)
//                                        print(patientUpdatedVM.FirstNameAr)
//                                        print(patientUpdatedVM.MiddelName)
//                                        print(patientUpdatedVM.MiddelNameAr)
//                                        print(patientUpdatedVM.FamilyName)
//                                        print(patientUpdatedVM.FamilyNameAr)
//                                        print(patientUpdatedVM.NationalityId)
//                                        print(patientUpdatedVM.Birthday ?? Date())
//                                        print(datef.string(from: patientUpdatedVM.Birthday ?? Date()) )
//                                        //                                    print(patientUpdatedVM.Birthday?.dateformatter)
//
//                                        print(patientUpdatedVM.GenderId ?? 0)
//                                        print(patientUpdatedVM.CityId)
//                                        print(patientUpdatedVM.AreaId)
//                                        print(patientUpdatedVM.OccupationId)
//                                        print(patientUpdatedVM.Latitude )
//                                        print(patientUpdatedVM.Longitude )
//                                        print(patientUpdatedVM.BlockNo )
//                                        print(patientUpdatedVM.Address )
//                                        print(patientUpdatedVM.FloorNo )
//                                        print(patientUpdatedVM.ApartmentNo )
//                                        print(patientUpdatedVM.EmergencyContact )
//
////                                            patientUpdatedVM.isLoading = true
////                                        patientUpdatedVM.startCreatePatientProfile(profileImage: patientUpdatedVM.profileImage)
//                                    }
////
//                                }, Cancelaction:  {
//                                    //                                        self.presentationMode.wrappedValue.dismiss()
//                                }, isValid: $isValid)
                            }
                            
                        }
                    }
                    .ignoresSafeArea()
                    .background(Color("CLVBG"))
                    .blur(radius: ShowOccupation || ShowCity || ShowNationality || ShowArea ? 10 : 0)
                    .disabled(ShowOccupation || ShowCity || ShowNationality || ShowArea)
                    if ShowNationality {
                        ZStack {
                            ChooseNationality(NationalityVM: NationalityVM, IsPresented: $ShowNationality, SelectedNationalityName: $patientUpdatedVM.NationalityName, SelectedNationalityId: $patientUpdatedVM.NationalityId, width: bounds.size.width)
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
                                            ShowNationality.toggle()
                                        }
                                        self.offset = .zero
                                    } else {
                                        self.offset = .zero
                                    }
                                }
                        )
                    } else if ShowCity{
                        ZStack {
                            // needs to handle get country by id

                            ChooseCity(IsPresented: $ShowCity , SelectedCityName: $patientUpdatedVM.cityName , SelectedCityId: $patientUpdatedVM.CityId ,SelectedCountryId: $patientUpdatedVM.NationalityId , width: bounds.size.width )
                            
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
                                            ShowCity = false
                                        }
                                        self.offset = .zero
                                    } else {
                                        self.offset = .zero
                                    }
                                }

                        )
                    } else if ShowArea {
                        ZStack {
                            // needs to handle get country by id
                            ChooseArea(IsPresented:$ShowArea,SelectedAreaName:$patientUpdatedVM.areaName, SelectedAreaId: $patientUpdatedVM.AreaId,SelectedCityId: $patientUpdatedVM.CityId , width: bounds.size.width )
                        
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
                                            ShowArea = false
                                        }
                                        self.offset = .zero
                                    } else {
                                        self.offset = .zero
                                    }
                                }

                        )
                    }  else if ShowOccupation {
                        ZStack {
                            // needs to handle get country by id
                            ChooseOccupation( OccupationVM: OccupationVM, IsPresented: $ShowOccupation, SelectedOccupationName: $patientUpdatedVM.occupationName, SelectedOccupationId: $patientUpdatedVM.OccupationId, width: bounds.size.width)
                        
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
                                            ShowOccupation = false
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
                    NationalityVM.startFetchCountries()
                    OccupationVM.startFetchOccupation()
                    patientUpdatedVM.startFetchPatientProfile()
                    print(Helper.getAccessToken())
                })
                
            }
            .toolbar{
                ToolbarItemGroup(placement: .keyboard ){
                    Spacer()
                    Button("Done"){
                        isfocused = false
                        if patientUpdatedVM.FirstName != "" && patientUpdatedVM.FirstNameAr != "" && patientUpdatedVM.MiddelName != "" && patientUpdatedVM.MiddelNameAr != "" && patientUpdatedVM.FamilyName != "" && patientUpdatedVM.FamilyNameAr != "" &&  patientUpdatedVM.NationalityId != 0 && patientUpdatedVM.CityId != 0 && patientUpdatedVM.AreaId != 0 && patientUpdatedVM.EmergencyContact != "" && patientUpdatedVM.OccupationId != 0 && patientUpdatedVM.Address != "" && patientUpdatedVM.GenderId != 0{
                            isValid = true
                        }
                    }
                }
            }
            .sheet(isPresented: $ShowingMap) {
//                    GoogleMapsView(long: clinicCreatedVM.Longitude, lat: clinicCreatedVM.Latitude)
                ViewMapWithPin(showmap: $ShowingMap, title: "", subtitle: "", longtude: $patientUpdatedVM.Longitude   , latitude: $patientUpdatedVM.Latitude  )
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
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$patientUpdatedVM.profileImage)
                }else{
                    //  If you wish to take a photo from camera instead:
                    ImagePicker(sourceType: .camera, selectedImage: self.$patientUpdatedVM.profileImage)
                }
            }
            // Alert with no internet connection
            .alert(isPresented: $patientUpdatedVM.isNetworkError, content: {
                Alert(title: Text("Check Your Internet Connection"), message: nil, dismissButton: .cancel())
            })
            
            // alert with no ierror message
            .alert(patientUpdatedVM.errorMsg, isPresented: $patientUpdatedVM.isError) {
                Button("OK", role: .cancel) { }
            }
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $patientUpdatedVM.isLoading)
        }
//        NavigationLink(destination:MedicalStateView(),isActive: $patientUpdatedVM.UserCreated , label: {
//        })
    }
}

struct UpdatePersonalDataView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePersonalDataView()
    }
}
