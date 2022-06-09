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
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @StateObject var searchDoc = VMSearchDoc()
    
    @Binding var ExTpe:Int
    @Binding var SpecialistId:Int
    @Binding var CityId:Int
    @Binding var AreaId:Int
    
    @State  var isSearch = false
    @State  var searchTxt = ""
    
    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    @State var index = 1
    
    @State var gotodoctorDetails = false
    @State var selectedCityId = 0
    @State var imgs : [Img] = []
    @State var SelectedDoctor = Doc()
    
    
    init(ExTpe: Binding<Int>,SpecialistId: Binding<Int> ,CityId: Binding<Int>,AreaId: Binding<Int> ) {
        UITableView.appearance().showsVerticalScrollIndicator = false
        self._ExTpe = ExTpe
        self._SpecialistId = SpecialistId
        self._CityId = CityId
        self._AreaId = AreaId
    }
    
    @State var FilterTag : FilterCases = .Menu
    @State var showFilter = false
    @StateObject var seniorityVM = ViewModelSeniority()
    @StateObject var specialityvm = ViewModelSpecialist()
    @StateObject var SubSpecialityVM = ViewModelSubspeciality()
    @StateObject var CitiesVM = ViewModelGetCities()
    @StateObject var AreasVM = ViewModelGetAreas()
    @StateObject var FeesVM = ViewModelFees()

    @State var selectedSeniorityLvlName :String?
    @State var selectedSeniorityLvlId :Int?
    @State var SenbuttonSelected: Int?

    @State var selectedSpecLvlName :String?
    @State var selectedSpecLvlId :Int?
    @State var SpecbuttonSelected: Int?

    @State var selectedSubSpecLvlNames : [String] = []
    @State var selectedSubSpecLvlIds : [Int] = []

    @State var selectedFee :Float = 0

    @State var selectedFilterCityName :String?
    @State var selectedFilterCityId :Int?
    @State var CitybuttonSelected: Int?

    @State var selectedFilterAreaName :String?
    @State var selectedFilterAreaId :Int?
    @State var AreabuttonSelected: Int?
    @State var ispreviewImage=false
    @State var previewImageurl=""


    var body: some View {
        ZStack{
            VStack{
                
                Spacer().frame(height:100)
                ZStack {
                    Image("WhiteCurve")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 120)
                        .padding(.top,-20)
                    
                    SearchBar(PlaceHolder:"Search_a_doctor...".localized(language),text: $searchTxt, isSearch: $isSearch){
                        getAllDoctors()
                    }
                    .shadow(color: .black.opacity(0.2), radius: 15)
                }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack( spacing: 10) {
                        ForEach(medicalType.publishedModelExaminationTypeId, id:\.self){ type in
                            if type.id==0{ }else{
                                Button(action: {
                                    withAnimation(.default) {
                                        self.index = type.id ?? 1
                                    }
                                }, label: {
                                    HStack(alignment: .center){
                                        Text(type.Name ?? "")
                                            .font(Font.SalamtechFonts.Reg16)
                                            .foregroundColor(self.index == type.id ? Color("blueColor") : Color("lightGray"))
                                        
                                    }
                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                    .frame(minWidth: 100, maxWidth: 350)
                                    .frame(height: 40)
                                        .background( Color(self.index == type.id ? "tabText" : "lightGray").opacity(self.index == type.id ? 1 : 0.3)
                                                        .cornerRadius(8))
                                        .clipShape(Rectangle())
                                })

                            }
                        }
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        .padding(.horizontal)
                }
                List( ){
                    if searchDoc.noDoctors == true{
                        Text("Sorry,\nNo_Doctors_Found_🤷‍♂️".localized(language))
                            .multilineTextAlignment(.center)
                        .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                    }
                    
                    ForEach(searchDoc.publishedModelSearchDoc , id:\.self){ Doctor in
                        ViewDocCell(Doctor: Doctor,searchDoc: searchDoc,gotodoctorDetails:$gotodoctorDetails,SelectedDoctor:$SelectedDoctor , ispreviewImage:$ispreviewImage, previewImageurl:$previewImageurl)
                    }
                        ZStack{}
                        .frame( maxHeight: 2)
                        .foregroundColor(.black)
                        .onAppear(perform: {
                            if searchDoc.publishedModelSearchDoc.count > searchDoc.SkipCount{
                            searchDoc.SkipCount += searchDoc.MaxResultCount
                                searchDoc.FetchDoctors(operation: .fetchMoreDoctors)
                            }
                        })

                }.refreshable(action: {
                    getAllDoctors()
                })
                    .listStyle(.plain)
                    .padding(.vertical,0)
               
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            .blur(radius: showFilter==true ? 9:0)
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))

            VStack{
                AppBarView(Title: "Search_a_Doctor".localized(language))
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            if showFilter == true {
                MainDoctorFilterView( FilterTag: $FilterTag, showFilter: $showFilter, SpecialistId: $SpecialistId,CityId:$CityId,AreaId:$AreaId,selectedSeniorityLvlName:$selectedSeniorityLvlName,selectedSeniorityLvlId:$selectedSeniorityLvlId,SenbuttonSelected:$SenbuttonSelected,selectedSpecLvlName:$selectedSpecLvlName,selectedSpecLvlId:$selectedSpecLvlId,SpecbuttonSelected:$SpecbuttonSelected,selectedSubSpecLvlNames:$selectedSubSpecLvlNames,selectedSubSpecLvlIds:$selectedSubSpecLvlIds,selectedFee:$selectedFee, selectedFilterCityName:$selectedFilterCityName, selectedFilterCityId:$selectedFilterCityId, CitybuttonSelected:$CitybuttonSelected, selectedFilterAreaName:$selectedFilterAreaName, selectedFilterAreaId:$selectedFilterAreaId, AreabuttonSelected:$AreabuttonSelected,searchTxt:$searchTxt)
                    .environmentObject(searchDoc)
                    .environmentObject(seniorityVM)
                    .environmentObject(specialityvm)
                    .environmentObject(SubSpecialityVM)
                    .environmentObject(CitiesVM)
                    .environmentObject(AreasVM)
                    .environmentObject(FeesVM)

            }
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $searchDoc.isLoading)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(ispreviewImage)
        .onAppear(perform: {
            medicalType.GetExaminationTypeId()
            searchDoc.MaxResultCount = 10
            index =  ExTpe
            searchDoc.MedicalExaminationTypeId = ExTpe
            searchDoc.SpecialistId = SpecialistId
            searchDoc.CityId = CityId
            searchDoc.AreaId = AreaId
            getAllDoctors()
        })
        .onChange(of: index){newval in
            self.ExTpe = newval
            searchDoc.isLoading = true
            searchDoc.MedicalExaminationTypeId = newval
            searchDoc.publishedModelSearchDoc.removeAll()
            getAllDoctors()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if !showFilter && !ispreviewImage{
                    BackButtonView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if  !ispreviewImage{
                FilterButtonView(imagename: "filter"){
                    showFilter.toggle()
                }
                }
            }
        }
        .overlay(content: {
            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
        })
        //  go to clinic info
        NavigationLink(destination:ViewDocDetails(Doctor:SelectedDoctor, ExType: $ExTpe),isActive: $gotodoctorDetails) {
        }
        
//        // Alert with no internet connection
//            .alert(isPresented: $searchDoc.isNetworkError, content: {
//                Alert(title: Text("Check_Your_Internet_Connection".localized(language)), message: nil, dismissButton: .cancel())
//        })
        
        // Alert with no internet connection
            .alert(isPresented: $searchDoc.isAlert, content: {
                Alert(title: Text(searchDoc.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    searchDoc.isAlert = false

                    }))
            })
        
    }
    
    //MARK: --- Functions ----
    func getAllDoctors(){
        searchDoc.isLoading = true
        searchDoc.DoctorName = searchTxt
        searchDoc.SkipCount = 0
        searchDoc.FetchDoctors(operation: .fetchDoctors)
    }
}

struct ViewSearchDoc_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSearchDoc(ExTpe: .constant(2), SpecialistId: .constant(2), CityId: .constant(2), AreaId: .constant(2))
        }.navigationBarHidden(true)
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





