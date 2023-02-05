//
//  ViewSearchDoc.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import ImageViewerRemote

struct ViewSearchDoc: View {
    @StateObject var DocDetails = ViewModelDocDetails()
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @EnvironmentObject var searchDoc : VMSearchDoc
    @EnvironmentObject var AdsVM : ViewModelSlidingAds
    @State private var currentStep = 0
    @State var VideoLink = "https://www.youtube.com/watch?v=tYBZ8AVH0Q0"
    @State private var isActive: Bool = false

    @EnvironmentObject var environments : EnvironmentsVM
    @State  var isSearch = false
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    @State var index = 1
    @State var gotoBooking = false
    @State var SelectedDoctor = Doc()
    @State var gotoMoreDetails = false
    init(
//        ExTpe: Binding<Int>,SpecialistId: Binding<Int>,SpecialistName: Binding<String> ,CityId: Binding<Int>,CityName: Binding<String>,AreaId: Binding<Int>,AreaName: Binding<String>
    ) {
        UITableView.appearance().showsVerticalScrollIndicator = false
//        self._ExTpe = ExTpe
//        self._SpecialistId = SpecialistId
//        self._SpecialistName = SpecialistName
//        self._CityId = CityId
//        self._CityName = CityName
//        self._AreaId = AreaId
//        self._AreaName = AreaName
    }
    
    @State var FilterTag : FilterCases = .Menu
    @State var ShowFilter = false
    @StateObject var seniorityVM = ViewModelSeniority()
    @StateObject var specialityvm = ViewModelSpecialist()
    @StateObject var SubSpecialityVM = ViewModelSubspeciality()
    @StateObject var CitiesVM = ViewModelGetCities()
    @StateObject var AreasVM = ViewModelGetAreas()
    @StateObject var FeesVM = ViewModelFees()

    @State var ispreviewImage=false
    @State var previewImageurl=""

    var body: some View {
        ZStack{
            VStack{
//                AppBarView(Title: "".localized(language),withbackButton: true)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:90)
                    .padding(.top,-20)

//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack( spacing: 10) {
//                        ForEach(medicalType.publishedModelExaminationTypeId, id:\.self){ type in
//                            if type.id==0{ }else{
//                                Button(action: {
//                                    withAnimation(.default) {
//                                        self.index = type.id ?? 1
//                                    }
//                                }, label: {
//                                    HStack(alignment: .center){
//                                        Text(type.Name ?? "")
//                                            .font(Font.SalamtechFonts.Reg16)
//                                            .foregroundColor(self.index == type.id ? Color("blueColor") : Color("lightGray"))
//                                    }
//                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                                    .frame(minWidth: 100, maxWidth: 350)
//                                    .frame(height: 40)
//                                        .background( Color(self.index == type.id ? "tabText" : "lightGray").opacity(self.index == type.id ? 1 : 0.3).cornerRadius(8))
//                                        .clipShape(Rectangle())
//                                })
//                            }
//                        }
//                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
////                        .padding(.horizontal)
//                }
                
                //MARK: -- Ads --
                if AdsVM.publishedAdsModel.count > 0{
                    TabView(selection: $currentStep) {
                        ForEach(0..<AdsVM.publishedAdsModel.count, id:\.self){ ad in
                            ZStack{
                                if AdsVM.publishedAdsModel[ad].isVideo ?? false{
                                    LinkView(link: "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")")
                                        .disabled(true)
                                        .onAppear(perform: {
                                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                                VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
                                            })
                                        })
                                    //                                        YoutubeVideoView(youtubeVideoID:AdsVM.publishedAdsModel[ad].Link?.youtubeID ?? "")
                                }else{
                                    AsyncImage(url: URL(string: "\(URLs.BaseUrl)\(AdsVM.publishedAdsModel[ad].videoLink ?? "")")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width-40, height: 150)
                            .cornerRadius(12)
                            .overlay(
                                HStack{
                                    Button(action: {
                                        currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
                                    }, label: {
                                        Image("newleft")
                                            .resizable()
                                            .frame(width:15, height:20)
                                            .scaledToFit()
                                    })
                                    Spacer()
                                    Button(action: {
                                        if AdsVM.publishedAdsModel[ad].isVideo ?? false {
                                            //                                                VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
//                                                isTimerRunning = false
                                            isActive.toggle()
                                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                                VideoLink = "\(AdsVM.publishedAdsModel[ad].videoLink ?? "")"
                                            })
                                        }else{
                                            //preview image
                                        }
                                    }, label: {
                                        ZStack{
                                            if AdsVM.publishedAdsModel[ad].isVideo ?? false{
                                                Image("newyoutubelogo")
                                                    .resizable()
                                                    .frame(width:65, height:55)
                                            }
                                        }.frame(width: 200, height: 150, alignment: .center)
                                    })
                                    Spacer()
                                    Button(action: {
                                        currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
                                    }, label: {
                                        Image("newright")
                                            .resizable()
                                            .frame(width:15, height:20)
                                            .scaledToFit()
                                    })
                                }
                                    .frame( height:120)
                                    .padding(.horizontal,10)
                            )
                            .padding(.horizontal)
                            .padding(.top,-20)
                            .tag(ad)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
//                        .padding(.top,-30)
                    .frame( height: 170)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                        .onReceive(timer, perform: { _ in
//                            if isTimerRunning{
//                                DispatchQueue.main.async(execute: {
//                                    print("selection is",currentStep)
//                                    currentStep = currentStep < AdsVM.publishedAdsModel.count-1 ? currentStep + 1 : 0
//                                })
//                            }
//                        })
                    
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//                                    currentStep = currentStep < (ad.getAdImagesDtos?.count ?? 0)-1 ? currentStep + 1 : 0
                            
                            currentStep = (currentStep + 1) % (AdsVM.publishedAdsModel.count )
                        }
                    }
                }else{
                    //No ads
                }
                HStack(){
                    Button(action: {
                        ShowFilter.toggle()
                    }, label: {
                        Text("Filter_".localized(language))
                            .foregroundColor(.white)
                    })
                        .frame(width: 120, height: 40, alignment: .center)
                        .background(Color.salamtackBlue)
                        .cornerRadius(8)
                    Spacer()
                }
                .padding(.horizontal)
                
                List( ){
                    if searchDoc.noDoctors == true{
                        Text("Sorry,\nNo_Doctors_Found_🤷‍♂️".localized(language))
                            .multilineTextAlignment(.center)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)

                        .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                    }
                    
                    ForEach(searchDoc.publishedModelSearchDoc , id:\.self){ Doctor in
//                        ViewDoctorCell(Doctor: Doctor,gotodoctorDetails:$gotodoctorDetails,SelectedDoctor:$SelectedDoctor,ispreviewImage:$ispreviewImage, previewImageurl:$previewImageurl)
//                            .environmentObject(searchDoc)

                        Color.secondary
                            .frame(height:0.7)
//                            .padding(.vertical,-20)
                        ViewLeftSection(Doctor: Doctor,MoreInfoAction: {
                            SelectedDoctor = Doctor
                            gotoMoreDetails = true
                        },ImageAction: {
                            ispreviewImage = true
                            previewImageurl = URLs.BaseUrl + "\(Doctor.Image ?? "")"
                        }){
                            SelectedDoctor = Doctor
                            gotoBooking = true
                        }
                        .environmentObject(medicalType)
                        .padding(.horizontal,-10)
                            .padding(.vertical,-20)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)

//                        ZStack{}
                    Color.salamtackWelcome
                        .frame( maxHeight: 2)
                        .foregroundColor(.black)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)

                        .onAppear(perform: {
                            if searchDoc.publishedModelSearchDoc.count > searchDoc.SkipCount{
                            searchDoc.SkipCount += searchDoc.MaxResultCount
                            searchDoc.FetchDoctors(operation: .fetchMoreDoctors)
                            }
                        })

                }.refreshable(action: {
                    getAllDoctors()
                })
//                    .frame(width:UIScreen.main.bounds.width,alignment:.center)

                    .listStyle(.plain)
//                    .padding(.top,-20)
                    .padding(.vertical,0)
                    .edgesIgnoringSafeArea(.bottom)
            }
//            .disabled(showFilter)
//            .blur(radius: showFilter == true ? 9:0)
//            .frame(width: UIScreen.main.bounds.width)
//            .edgesIgnoringSafeArea(.vertical)
//            .background(Color("CLVBG"))

//            VStack{
//                AppBarView(Title: "Search_a_Doctor".localized(language))
//                    .frame(height:55)
//                    .navigationBarBackButtonHidden(true)
//                Spacer()
//            }
//            .edgesIgnoringSafeArea(.vertical)
//            if showFilter == true {
//                MainDoctorFilterView( FilterTag: $FilterTag, showFilter: $showFilter, searchTxt:$searchTxt)
//                    .environmentObject(searchDoc)
//                    .environmentObject(seniorityVM)
//                    .environmentObject(specialityvm)
//                    .environmentObject(SubSpecialityVM)
//                    .environmentObject(CitiesVM)
//                    .environmentObject(AreasVM)
//                    .environmentObject(FeesVM)
//            }
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $searchDoc.isLoading)
            
            //  go to clinic info
            NavigationLink(destination:ViewBooking(Doctor:SelectedDoctor, ExType: $searchDoc.MedicalExaminationTypeId, BookingClinicId:SelectedDoctor.ClinicId ?? 0)
                            .environmentObject(DocDetails)
                            .environmentObject(environments)
                            .navigationBarBackButtonHidden(true),isActive: $gotoBooking) {
            }
            //  go to clinic info
            NavigationLink(destination:ViewMoreDetails(Doctor:SelectedDoctor, ExType: $searchDoc.MedicalExaminationTypeId)
                            .environmentObject(DocDetails)
                            .environmentObject(environments)
                            .navigationBarBackButtonHidden(true),isActive: $gotoMoreDetails) {
            }
        }
        .sheet(isPresented: $isActive, content: {
            LinkView(link: VideoLink)
                .frame(height:200)
                .onDisappear(perform: {
//                    isTimerRunning.toggle()
                })
        })
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(navController.popToRoot, perform: {newval in
            gotoBooking = newval
        })
        .onAppear(perform: {
//            setFirstselections()
//            FeesVM.startFetchFees()
//            medicalType.GetExaminationTypeId()
            index =  searchDoc.MedicalExaminationTypeId
//            searchDoc.MedicalExaminationTypeId = ExTpe
//            searchDoc.SpecialistId = SpecialistId
//            searchDoc.SpecialistName = SpecialistName
//            searchDoc.CityId = CityId
//            searchDoc.CityName = CityName
//            searchDoc.AreaId = AreaId
//            searchDoc.AreaName = AreaName
//            getAllDoctors()
            AdsVM.PageID = 3
            AdsVM.GetDashboardAds()

        })
        .onChange(of: index){newval in
            searchDoc.MedicalExaminationTypeId = newval
            getAllDoctors()
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                if !showFilter && !ispreviewImage{
//                    BackButtonView()
//                }
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                if  !ispreviewImage{
//                FilterButtonView(imagename: "filter"){
//                    showFilter.toggle()
//                }
//                }
//            }
//        }
        .overlay(content: {
            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
        })
        .sheet(isPresented: $ShowFilter){
            SpecialityView(isPresented:$ShowFilter)
                .environmentObject(environments)
                .environmentObject(searchDoc)
                .environmentObject(AdsVM)
        }
        
        // Alert with no internet connection
            .alert(isPresented: $searchDoc.isAlert, content: {
                Alert(title: Text(searchDoc.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    searchDoc.isAlert = false

                    }))
            })
            .background(
                newBackImage(backgroundcolor: .white, imageName:.image2)
            )
    }
}

struct ViewSearchDoc_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSearchDoc()
                .environmentObject(VMSearchDoc())
                .environmentObject(EnvironmentsVM())
        }.navigationBarHidden(true)
    }
}


extension ViewSearchDoc{

    func setFirstselections(){
//        searchDoc.FilterSpecialistId = SpecialistId
//        searchDoc.FilterSpecialistName = SpecialistName
//        searchDoc.FilterCityId = CityId
//        searchDoc.FilterCityName = CityName
//        searchDoc.FilterAreaId = AreaId
//        searchDoc.FilterAreaName = AreaName

    }
    
    //MARK: --- Functions ----
    func getAllDoctors(){
//        searchDoc.DoctorName = searchTxt
        searchDoc.SkipCount = 0
        searchDoc.FetchDoctors(operation: .fetchDoctors)
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}





