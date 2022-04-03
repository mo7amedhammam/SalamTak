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
    
    @FocusState private var isfocused : Bool
    let screenWidth = UIScreen.main.bounds.size.width - 50
    @State var isValid = true
    
    @StateObject var patientCreatedVM = ViewModelCreatePatientProfile()
    
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
                    }.ignoresSafeArea()
                    
                   
                }
                
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
