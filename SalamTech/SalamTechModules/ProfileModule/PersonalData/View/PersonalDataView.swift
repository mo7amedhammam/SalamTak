//
//  PersonalDataView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import SwiftUI

struct PersonalDataView: View {
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
    @State var isValid = true
    @State var ShowingMap = false
    @State var ShowNationality = false
    @State var ShowCity = false
    @State var ShowArea = false
    
    @StateObject var patientCreatedVM = ViewModelCreatePatientProfile()
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var NationalityVM = ViewModelCountries()
    
    var body: some View {
        ZStack{
            GeometryReader{ bounds in
                ZStack{
                    VStack{
                        ZStack{
                            VStack{
                                InfoAppBarView(Maintext: "CompeleteProfile_Screen_title".localized(language), text: "CompeleteProfile_Screen_subtitle".localized(language), Nexttext: "CompeleteProfile_Screen_secondSubTitle".localized(language),image: "1-3")
                                    .offset(y: -10)
                                    
                                Spacer().frame(height: 90)
                                
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
                                                if !patientCreatedVM.errorFirstName.isEmpty{
                                                    Text(patientCreatedVM.errorFirstName)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                                if !patientCreatedVM.errorMiddelName.isEmpty{
                                                    Text(patientCreatedVM.errorMiddelName)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth ,alignment: .leading)
                                                }
                                                if !patientCreatedVM.errorLastName.isEmpty{
                                                    Text(patientCreatedVM.errorMiddelName)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                            }
                                            
                                            HStack (spacing: 10){
                                                InputTextFieldInfo( text: $patientCreatedVM.FirstName,title: "First Name(*)")
                                                    .focused($isfocused)
                                                InputTextFieldInfo( text: $patientCreatedVM.MiddelName,title: "Middle Name(*)")
                                                    .focused($isfocused)
                                                InputTextFieldInfo( text: $patientCreatedVM.FamilyName,title: "Last Name(*)")
                                                    .focused($isfocused)
                                            }
                                        }
                                        Spacer().frame(height: 20)
                                        
                                        VStack{
                                            HStack(spacing: 10){
                                                if !patientCreatedVM.errorFirstNameAr.isEmpty{
                                                    Text(patientCreatedVM.errorFirstNameAr)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                                if !patientCreatedVM.errorMiddelNameAr.isEmpty{
                                                    Text(patientCreatedVM.errorMiddelNameAr)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                                if !patientCreatedVM.errorLastNameAr.isEmpty{
                                                    Text(patientCreatedVM.errorLastNameAr)
                                                        .font(.system(size: 13))
                                                        .padding(.horizontal,20)
                                                        .foregroundColor(.red)
                                                        .frame(maxWidth:screenWidth, alignment: .leading)
                                                }
                                            }
                                            
                                            HStack (spacing: 10){
                                                InputTextFieldInfoArabic( text: $patientCreatedVM.FamilyNameAr,title: "الاسم الاخير(*)")
                                                    .focused($isfocused)
                                                    .autocapitalization(.none)
                                                InputTextFieldInfoArabic( text: $patientCreatedVM.MiddelNameAr,title: "الاسم الأوسط(*)")
                                                    .focused($isfocused)
                                                    .autocapitalization(.none)
                                                InputTextFieldInfoArabic( text: $patientCreatedVM.FirstNameAr,title: "الاسم الأول(*)")
                                                    .focused($isfocused)
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
                                                    Text(patientCreatedVM.NationalityName)
                                                        .foregroundColor(Color("lightGray"))
                                                    
                                                    Spacer()
                                                    Image(systemName: "staroflife.fill")
                                                        .font(.system(size: 10))
                                                        .foregroundColor(patientCreatedVM.NationalityName == "" ? Color.red : Color.white)
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
                                            Button {
                                                withAnimation {
                                                    ShowCity.toggle()
                                                }
                                                
                                            } label: {
                                                HStack{
                                                    Text(patientCreatedVM.cityName == "" ? "Clinic_Screen_city".localized(language): patientCreatedVM.cityName) // needs to handle get country by id
                                                        .foregroundColor(patientCreatedVM.cityName == "" ?  Color("lightGray") : Color("blueColor"))
                                                    
                                                    Spacer()
                                                    Image(systemName: "staroflife.fill")
                                                        .font(.system(size: 10))
                                                        .foregroundColor(patientCreatedVM.cityName == "" ? Color.red : Color.white)
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
                                        }
                                        GenderView(selection: $patientCreatedVM.GenderId)
                                        Spacer().frame(height: 20)
                                        TrackingView()
                                            .environmentObject(locationViewModel)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                            .onTapGesture(perform: {
                                                ShowingMap = true
                                                if patientCreatedVM.Longitude == 0.0 {
                                                    patientCreatedVM.Longitude = locationViewModel.lastSeenLocation?.coordinate.longitude ?? 5.5
                                                }
                                                if patientCreatedVM.Latitude == 0.0 {
                                                    patientCreatedVM.Latitude = locationViewModel.lastSeenLocation?.coordinate.latitude ?? 5.5
                                                }
    //                                            print(locationViewModel.lastSeenLoca0
                                            })
                                    }
                                }
                               
                                Spacer()
                                CustomActionBottomSheet( ConfirmTitle: "CompeleteProfile_Screen_Next_Button".localized(language), CancelTitle: "CompeleteProfile_Screen_Previos_Button".localized(language), Confirmaction:   {
//                                    patientCreatedVM.DoctorSubSpecialist = self.SubSpecIDArr
//                                    print(SubSpecIDArr)
//                                    print(patientCreatedVM.DoctorSubSpecialist)
//                                    DispatchQueue.main.async {
//
//
//                                        print("let's create profiles")
//
//                                        print(patientCreatedVM.FirstName)
//                                        print(patientCreatedVM.FirstNameAr)
//                                        print(patientCreatedVM.MiddelName)
//                                        print(patientCreatedVM.MiddelNameAr)
//                                        print(patientCreatedVM.LastName)
//                                        print(patientCreatedVM.LastNameAr)
//                                        print(patientCreatedVM.NationalityId)
//                                        print(patientCreatedVM.Birthday ?? Date())
//                                        print(datef.string(from: patientCreatedVM.Birthday ?? Date()) )
//                                        //                                    print(patientCreatedVM.Birthday?.dateformatter)
//
//                                        print(patientCreatedVM.GenderId ?? 0)
//                                        print(patientCreatedVM.SpecialistId)
//                                        print(patientCreatedVM.DoctorSubSpecialist)
//                                        print(patientCreatedVM.SeniorityLevelId)
//                                        print(patientCreatedVM.DoctorInfo )
//                                        print(patientCreatedVM.DoctorInfoAr )
//
////                                            patientCreatedVM.isLoading = true
//                                        patientCreatedVM.startFetchDoctorProfileCreation(profileImage:patientCreatedVM.profileImage )
//                                    }
//
                                }, Cancelaction:  {
                                    //                                        self.presentationMode.wrappedValue.dismiss()
                                }, isValid: $isValid)
                            }
                            
                        }
                    }
                    .ignoresSafeArea()
                    .background(Color("CLVBG"))
                    .blur(radius: ShowCity || ShowNationality || ShowArea ? 10 : 0)
                    .disabled(ShowCity || ShowNationality || ShowArea)
                    if ShowNationality {
                        ZStack {
                            ChooseNationality(NationalityVM: NationalityVM, IsPresented: $ShowNationality, SelectedNationalityName: $patientCreatedVM.NationalityName, SelectedNationalityId: $patientCreatedVM.NationalityId, width: bounds.size.width)
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

                            ChooseCity(IsPresented: $ShowCity , SelectedCityName: $patientCreatedVM.cityName , SelectedCityId: $patientCreatedVM.CityId ,SelectedCountryId: $patientCreatedVM.NationalityId , width: bounds.size.width )
                            
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
                            ChooseArea(IsPresented:$ShowArea,SelectedAreaName:$patientCreatedVM.areaName, SelectedAreaId: $patientCreatedVM.AreaId,SelectedCityId: $patientCreatedVM.CityId , width: bounds.size.width )
                        
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
                    }
                    
                   
                }
                .onAppear(perform: {
                    NationalityVM.startFetchCountries()
                    print(Helper.getAccessToken())
                })
                
            }
            .sheet(isPresented: $ShowingMap) {
//                    GoogleMapsView(long: clinicCreatedVM.Longitude, lat: clinicCreatedVM.Latitude)
                ViewMapWithPin(showmap: $ShowingMap, title: "", subtitle: "", longtude: $patientCreatedVM.Longitude   , latitude: $patientCreatedVM.Latitude  )
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
        }
    }
}

struct PersonalDataView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataView()
    }
}
