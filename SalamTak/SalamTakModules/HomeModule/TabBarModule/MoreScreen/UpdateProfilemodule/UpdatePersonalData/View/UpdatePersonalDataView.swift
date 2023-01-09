////
////  UpdatePersonalDataView.swift
////  SalamTech
////
////  Created by Mostafa Morsy on 07/04/2022.
////
//
//import SwiftUI
//import Kingfisher
//extension DateFormatter {
//    static var formate: DateFormatter {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        return dateFormatter
//    }
//}
//
//struct UpdatePersonalDataView: View {
//    var language = LocalizationService.shared.language
//    
//    @State private var image = UIImage()
//    @State private var showImageSheet = false
//    @State private var startPicking = false
//    @State private var imgsource = ""
//    
//    @State var bounds = UIScreen.main.bounds
//    @State var offset = CGSize.zero
//    @FocusState private var isfocused : Bool
//    let screenWidth = UIScreen.main.bounds.size.width - 55
//    @State var isValid = false
//    @State var ShowingMap = false
//    @State var ShowNationality = false
//    @State var ShowCity = false
//    @State var ShowArea = false
//    @State var ShowOccupation = false
//    
//    @StateObject var patientUpdatedVM = ViewModelUpdatePatientProfile()
//    @StateObject var locationViewModel = LocationViewModel()
//    @StateObject var NationalityVM = ViewModelCountries()
//    @StateObject var OccupationVM = ViewModelOccupation()
//    func getOcupationNameById(id:Int)->String{
//        var occname = ""
//        for occupation in OccupationVM.publishedCountryModel{
//            if occupation.Id == id{
//                occname = occupation.Name ?? ""
//            }
//        }
//        return occname
//    }
//    
//    var body: some View {
//        ZStack{
//            ZStack{
//                VStack{
//                    ZStack{
//                        VStack{
//                            
//                            ScrollView(.vertical, showsIndicators: false) {
//                                VStack{
//                                    ZStack {
//                                        ZStack {
//                                            Button(action: {
//                                                
//                                            }, label: {
//                                                if patientUpdatedVM.ImageUrl != "" {
//                                                    KFImage(URL(string: URLs.BaseUrl + "\(patientUpdatedVM.ImageUrl)"))
//                                                        .resizable()
//                                                        .scaledToFill()
//                                                        .background(Color.clear)
//                                                } else {
//                                                    Image(uiImage: patientUpdatedVM.profileImage )
//                                                        .resizable()
//                                                        .foregroundColor(Color("blueColor"))
//                                                        .clipShape(Rectangle())
//                                                }
//                                            })
//                                        }
//                                        .frame(width: 70, height: 70, alignment: .center)
//                                        .background(Image(systemName: "camera")
//                                                        .resizable()
//                                                        .foregroundColor(Color("blueColor").opacity(0.4))
//                                                        .frame(width: 25, height: 25)
//                                                        .background(Rectangle()
//                                                                        .frame(width:70,height:70)
//                                                                        .foregroundColor(Color("lightGray")).opacity(0.3)
//                                                                        .cornerRadius(4))
//                                        )
//                                        .cornerRadius(10)
//                                        
//                                    } .frame(width: 90, height: 90, alignment: .center)
//                                        .background(Color.clear)
//                                    Spacer().frame(height: 20)
//                                    
//                                    VStack{
//                                        HStack(spacing: 10){
//                                            Group{
//                                                if !patientUpdatedVM.errorFirstName.isEmpty{
//                                                    Text(patientUpdatedVM.errorFirstName)
//                                                }
//                                                if !patientUpdatedVM.errorMiddelName.isEmpty{
//                                                    Text(patientUpdatedVM.errorMiddelName)
//                                                }
//                                                if !patientUpdatedVM.errorLastName.isEmpty{
//                                                    Text(patientUpdatedVM.errorMiddelName)
//                                                }
//                                                
//                                            }    .font(.system(size: 13))
//                                                .padding(.horizontal,20)
//                                                .foregroundColor(.red)
//                                                .frame(maxWidth:screenWidth, alignment: .leading)
//                                            
//                                        }
//                                        
//                                        HStack (spacing: 10){
//                                                                                        Group{
//                                            InputTextFieldInfo( text: $patientUpdatedVM.FirstName,title: "First Name(*)")
//                                            InputTextFieldInfo( text: $patientUpdatedVM.MiddelName,title: "Middle Name(*)")
//                                            InputTextFieldInfo( text: $patientUpdatedVM.FamilyName,title: "Last Name(*)")
//                                                                                        }
//                                                                                        .focused($isfocused)
//                                        }
//                                    }
//                                    Spacer().frame(height: 20)
//                                    
//                                    VStack{
//                                        HStack(spacing: 10){
//                                            Group{
//                                                if !patientUpdatedVM.errorFirstNameAr.isEmpty{
//                                                    Text(patientUpdatedVM.errorFirstNameAr)
//                                                }
//                                                
//                                                if !patientUpdatedVM.errorMiddelNameAr.isEmpty{
//                                                    Text(patientUpdatedVM.errorMiddelNameAr)
//                                                }
//                                                
//                                                if !patientUpdatedVM.errorLastNameAr.isEmpty{
//                                                    Text(patientUpdatedVM.errorLastNameAr)
//                                                }
//                                                
//                                            }.font(.system(size: 13))
//                                                .padding(.horizontal,20)
//                                                .foregroundColor(.red)
//                                                .frame(maxWidth:screenWidth, alignment: .leading)
//                                        }
//                                        
//                                        HStack (spacing: 10){
//                                            Group{
//                                                InputTextFieldInfoArabic( text: $patientUpdatedVM.FamilyNameAr,title: "الاسم الاخير(*)")
//                                                
//                                                InputTextFieldInfoArabic( text: $patientUpdatedVM.MiddelNameAr,title: "الاسم الأوسط(*)")
//                                                
//                                                InputTextFieldInfoArabic( text: $patientUpdatedVM.FirstNameAr,title: "الاسم الأول(*)")
//                                                
//                                            }   .focused($isfocused)
//                                                .autocapitalization(.none)
//                                            
//                                        }
//                                    }
//                                }
//                                Spacer().frame(height: 20)
//                                VStack{
//                                    DateOfBirthView(date: $patientUpdatedVM.date)
//                                    
//                                    Spacer().frame(height: 20)
//                                    
//                                    VStack{
//                                        Button {
//                                            withAnimation {
//                                                ShowNationality.toggle()
//                                            }
//                                        } label: {
//                                            HStack{
//                                                Text(patientUpdatedVM.NationalityName)
//                                                    .foregroundColor(patientUpdatedVM.NationalityName == "" ?  Color("lightGray") : Color("blueColor"))
//                                                
//                                                Spacer()
//                                                Image(systemName: "staroflife.fill")
//                                                    .font(.system(size: 10))
//                                                    .foregroundColor(patientUpdatedVM.NationalityName == "" ? Color.red : Color.white)
//                                                Image(systemName: "chevron.forward")
//                                                    .foregroundColor(Color("lightGray"))
//                                            }
//                                            .frame(width: screenWidth, height: 30)
//                                            .font(.system(size: 13))
//                                            .padding(12)
//                                            .disableAutocorrection(true)
//                                            .background(
//                                                Color.white
//                                            ).foregroundColor(Color("blueColor"))
//                                                .cornerRadius(5)
//                                                .shadow(color: Color.black.opacity(0.099), radius: 3)
//                                        }
//                                        Button {
//                                            withAnimation {
//                                                ShowCity.toggle()
//                                            }
//                                            
//                                        } label: {
//                                            HStack{
//                                                Text(patientUpdatedVM.cityName == "" ? "Clinic_Screen_city".localized(language): patientUpdatedVM.cityName) // needs to handle get country by id
//                                                    .foregroundColor(patientUpdatedVM.cityName == "" ?  Color("lightGray") : Color("blueColor"))
//                                                
//                                                Spacer()
//                                                Image(systemName: "staroflife.fill")
//                                                    .font(.system(size: 10))
//                                                    .foregroundColor(patientUpdatedVM.cityName == "" ? Color.red : Color.white)
//                                                Image(systemName: "chevron.forward")
//                                                    .foregroundColor(Color("lightGray"))
//                                            }
//                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                            .frame(width: screenWidth, height: 30)
//                                            .font(.system(size: 13))
//                                            .padding(12)
//                                            .disableAutocorrection(true)
//                                            .background(
//                                                Color.white
//                                            ).foregroundColor(Color("blueColor"))
//                                                .cornerRadius(5)
//                                                .shadow(color: Color.black.opacity(0.099), radius: 3)
//                                        }
//                                        
//                                        Button {
//                                            withAnimation {
//                                                ShowArea.toggle()
//                                            }
//                                        } label: {
//                                            HStack{
//                                                Text(patientUpdatedVM.areaName == "" ? "Clinic_Screen_area".localized(language):patientUpdatedVM.areaName) // needs to handle get country by id
//                                                    .foregroundColor(patientUpdatedVM.areaName == "" ? Color("lightGray"):Color("blueColor"))
//                                                
//                                                Spacer()
//                                                Image(systemName: "staroflife.fill")
//                                                    .font(.system(size: 10))
//                                                    .foregroundColor(patientUpdatedVM.areaName == "" ? Color.red : Color.white)
//                                                Image(systemName: "chevron.forward")
//                                                    .foregroundColor(Color("lightGray"))
//                                            }
//                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                            .frame(width: screenWidth, height: 30)
//                                            .font(.system(size: 13))
//                                            .padding(12)
//                                            .disableAutocorrection(true)
//                                            .background(
//                                                Color.white
//                                            ).foregroundColor(Color("blueColor"))
//                                                .cornerRadius(5)
//                                                .shadow(color: Color.black.opacity(0.099), radius: 3)
//                                        }
//                                    }
//                                    Spacer().frame(height: 20)
//                                    InputTextField(text: $patientUpdatedVM.EmergencyContact, errorMsg: .constant(""), title: "Emergency Contact (Required)")
//                                        .focused($isfocused)
//                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                        .autocapitalization(.none)
//                                        .keyboardType(.numberPad)
//                                        .textInputAutocapitalization(.never)
//                                    Spacer().frame(height: 20)
//                                    GenderView(GenderId: $patientUpdatedVM.GenderId,GenderName:$patientUpdatedVM.GenderName)
//                                    Spacer().frame(height: 20)
//                                    PickLocationView(longtiude: $patientUpdatedVM.Longitude, latitiude: $patientUpdatedVM.Latitude)
//                                        .environmentObject(locationViewModel)
//                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                        .onTapGesture(perform: {
//                                            ShowingMap = true
//                                            if patientUpdatedVM.Longitude == 0.0 {
//                                                patientUpdatedVM.Longitude = locationViewModel.lastSeenLocation?.coordinate.longitude ?? 5.5
//                                            }
//                                            if patientUpdatedVM.Latitude == 0.0 {
//                                                patientUpdatedVM.Latitude = locationViewModel.lastSeenLocation?.coordinate.latitude ?? 5.5
//                                            }
//                                        })
//                                    VStack{
//                                        Button {
//                                            withAnimation {
//                                                ShowOccupation.toggle()
//                                            }
//                                            
//                                        } label: {
//                                            HStack{
//                                                Text(patientUpdatedVM.occupationName)
//                                                    .foregroundColor(patientUpdatedVM.occupationName == "" ?  Color("lightGray") : Color("blueColor"))
//                                                
//                                                Spacer()
//                                                Image(systemName: "staroflife.fill")
//                                                    .font(.system(size: 10))
//                                                    .foregroundColor(patientUpdatedVM.occupationName == "" ? Color.red : Color.white)
//                                                Image(systemName: "chevron.forward")
//                                                    .foregroundColor(Color("lightGray"))
//                                            }
//                                            .frame(width: screenWidth, height: 30)
//                                            .font(.system(size: 13))
//                                            .padding(12)
//                                            .disableAutocorrection(true)
//                                            .background(
//                                                Color.white
//                                            ).foregroundColor(Color("blueColor"))
//                                                .cornerRadius(5)
//                                                .shadow(color: Color.black.opacity(0.099), radius: 3)
//                                        }
//                                        
//                                        Group{
//                                            InputTextField(text: $patientUpdatedVM.Address, errorMsg: .constant(""), title: "Clinic_Screen_street".localized(language))
//                                            
//                                            InputTextField(text: $patientUpdatedVM.BlockNo, errorMsg: .constant(""), title: "Clinic_Screen_building".localized(language))
//                                            
//                                            InputTextField(text: $patientUpdatedVM.FloorNo.string(), errorMsg: .constant(""), title: "Clinic_Screen_floor".localized(language))
//                                                .keyboardType(.numberPad)
//                                            
//                                            InputTextField(text: $patientUpdatedVM.ApartmentNo, errorMsg: .constant(""), title: "Apartment Number".localized(language))
//                                            
//                                        }
//                                        .focused($isfocused)
//                                        .autocapitalization(.none)
//                                        .textInputAutocapitalization(.never)
//                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                    }
//                                }
//                            }
//                            .keyboardSpace()
//                            
//                            Spacer()
//                            ButtonView(text: "UpdateProfile".localized(language), action: {
//                                patientUpdatedVM.updatePersonalInfo(operation: .updatePersonalInfo)
//                            })
//                        }
//                    }
//                }
//                .ignoresSafeArea()
//                .background(Color("CLVBG"))
//                .blur(radius: ShowOccupation || ShowCity || ShowNationality || ShowArea ? 10 : 0)
//                .disabled(ShowOccupation || ShowCity || ShowNationality || ShowArea)
//                
////                if ShowNationality {
////                    ShowUpdateNationalityList(ShowNationality: $ShowNationality, bounds: $bounds, offset: $offset)
////                        .environmentObject(patientUpdatedVM)
////                        .environmentObject(NationalityVM)
////                    
////                }
////                else if ShowCity{
////                    ShowUpdateCityList( ShowCity: $ShowCity , bounds: $bounds, offset: $offset)
////                        .environmentObject(patientUpdatedVM)
////                    
////                }
////                else if ShowArea {
////                    ShowUpdateAreaList(ShowArea:$ShowArea,bounds: $bounds, offset: $offset)
////                        .environmentObject(patientUpdatedVM)
////                    
////                    
////                }
////                else if ShowOccupation {
////                    ShowUpdateOccupationList(ShowOccupation:$ShowOccupation,bounds: $bounds, offset: $offset)
////                        .environmentObject(patientUpdatedVM)
////                        .environmentObject(OccupationVM)
////                }
//            }
//            .toolbar{
//                ToolbarItemGroup(placement: .keyboard ){
//                    Spacer()
//                    Button("Done"){
//                        isfocused = false
//                    }
//                }
//            }
//            .sheet(isPresented: $ShowingMap) {
//                ViewMapWithPin(showmap: $ShowingMap, title: "", subtitle: "", longtude: $patientUpdatedVM.Longitude , latitude: $patientUpdatedVM.Latitude ).environmentObject(locationViewModel)
//            }
//            //MARK: -------- imagePicker From Camera and Library ------
//            .confirmationDialog("Choose Image From ?", isPresented: $showImageSheet) {
//                Button("photo Library") { self.imgsource = "Library";   self.showImageSheet = false; self.startPicking = true }
//                Button("Camera") {self.imgsource = "Cam" ;    self.showImageSheet = false; self.startPicking = true}
//                Button("Cancel", role: .cancel) { }
//            } message: {Text("Select Image From")}
//            
//            .sheet(isPresented: $startPicking) {
//                if imgsource == "Library"{
//                    // Pick an image from the photo library:
//                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$patientUpdatedVM.profileImage)
//                }else{
//                    //  If you wish to take a photo from camera instead:
//                    ImagePicker(sourceType: .camera, selectedImage: self.$patientUpdatedVM.profileImage)
//                }
//            }
//            
//            // showing loading indicator
//            ActivityIndicatorView(isPresented: $patientUpdatedVM.isLoading)
//        }
//        .onAppear(perform: {
//            NationalityVM.startFetchCountries()
//            OccupationVM.startFetchOccupation()
//            patientUpdatedVM.updatePersonalInfo(operation: .getPersonalInfo)
//                Helper.setUserLocation(CurrentLatitude: "\(patientUpdatedVM.Latitude)", CurrentLongtude: "\(patientUpdatedVM.Longitude)")
//
//        })
//        
//        .navigationViewStyle(StackNavigationViewStyle())
//        
//        // Alert with no internet connection
//        .alert(isPresented: $patientUpdatedVM.isAlert, content: {
//            Alert(title: Text(patientUpdatedVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
//                patientUpdatedVM.isAlert = false
//                
//            }))
//        })
//        
//        
//    }
//}
//
//struct UpdatePersonalDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            UpdatePersonalDataView()
//        }
//    }
//}
//
//
//
//
//
//
