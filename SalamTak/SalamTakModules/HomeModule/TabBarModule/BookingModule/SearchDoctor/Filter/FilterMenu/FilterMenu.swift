//
//  FilterMenu.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine

struct FilterMenu:View{
    @EnvironmentObject var searchDoc : VMSearchDoc
    @EnvironmentObject var FeesVM : ViewModelFees
    
    @Binding var FilterTag:FilterCases
    @Binding var showFilter:Bool
    
    @Binding var selectedSeniorityLvlName :String?
    @Binding var selectedSeniorityLvlId :Int?
    @Binding var selectedSpecLvlName :String?
    @Binding var OldselectedSpecLvlName :String

    @Binding var selectedSpecLvlId :Int?
    @Binding var OldselectedSpecLvlId :Int

    @Binding var selectedSubSpecLvlNames : [String]
    @Binding var selectedSubSpecLvlIds : [Int]
    @Binding var selectedFee :Float
    @Binding var selectedFilterCityName :String?
    @Binding var OldselectedFilterCityName :String

    @Binding var selectedFilterCityId :Int?
    @Binding var OldselectedFilterCityId :Int

    @Binding var selectedFilterAreaName :String?
    @Binding var OldselectedFilterAreaName :String

    @Binding var selectedFilterAreaId :Int?
    @Binding var OldselectedFilterAreaId :Int

    @Binding  var searchTxt : String
    
    var body: some View{
        VStack{
            Text("Search_Filter".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        showFilter.toggle()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )
            
            ScrollView(){
                Button(action: {
                    print("sel Title")
                    FilterTag = .Title
                    
                }, label: {
                    HStack{
                        
                        Image("FilterTitle")
                        VStack(alignment:.leading){
                            Text("Title".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Text(selectedSeniorityLvlName ?? "")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                        
                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                })
                    .listRowSeparator(.hidden)
                Button(action: {
                    print("sel spec")
                    FilterTag = .Speciality
                    
                }, label: {
                    HStack{
                        
                        Image("FilterSpec")
                        VStack(alignment:.leading){
                            Text("Speciality".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(selectedSpecLvlName ?? "")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                        
                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                })
                Button(action: {
                    FilterTag = .SubSpeciality
                }, label: {
                    HStack{
                        
                        Image("FilterSpec")
                        VStack(alignment:.leading){
                            Text("Sub_Specialities".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(selectedSubSpecLvlNames.joined(separator: ", "))
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                        
                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                })
                
                // in case we wanted to add Gender to filter
                //                            Button(action: {
                //                                FilterTag = "Gender"
                //                            }, label: {
                //                                HStack{
                //
                //                                    Image("FilterPerson")
                //                                    VStack(alignment:.leading){
                //                                        Text("Gender".localized(language))
                //                                            .font(.system(size: 16))
                //                                            .fontWeight(.semibold)
                //                                            .foregroundColor(.black)
                //                                        Text("Select Gender")
                //                                            .font(.system(size: 12))
                //                                            .fontWeight(.medium)
                //                                            .foregroundColor(.gray)
                //                                    }
                //
                //                                    Spacer()
                //
                //                                    CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                //
                //                                }.padding()
                //                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                //                            })
                
                
                Button(action: {
                    FilterTag = .City
                }, label: {
                    HStack{
                        
                        Image("FilterLocation")
                        VStack(alignment:.leading){
                            Text("City".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(selectedFilterCityName ?? "")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                        
                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                })
                Button(action: {
                    FilterTag = .Area
                }, label: {
                    HStack{
                        Image("FilterLocation")
                        VStack(alignment:.leading){
                            Text("Area".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(selectedFilterAreaName ?? "")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                        
                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                })
                Button(action: {
                    FilterTag = .Fees
                }, label: {
                    HStack{
                        
                        Image("FilterFees")
                        VStack(alignment:.leading){
                            Text("Examination_Fee".localized(language))
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text("From".localized(language) + " \(String( FeesVM.publishedMinMaxFee?.MinimumFees ?? 0))" + " to".localized(language) + " \(String(Int( Float(FeesVM.publishedMinMaxFee?.MaximumFees ?? 0) + selectedFee))) "+"EGP".localized(language))
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        CircularButton(ButtonImage: Image(systemName: "chevron.forward"), forgroundColor: Color.gray, backgroundColor: Color("subText").opacity(0.22), Buttonwidth: 15, Buttonheight: 15){  }
                        
                    }.padding()
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                })
                
            }
            .listStyle(.plain)
            
            HStack{
                
                Button( action: {
                    
                    resetFilter()
                    showFilter.toggle()
                }, label: {
                    Text("Reset".localized(language))
                        .font(.system(size: 15))
                        .foregroundColor(.black.opacity(0.5))
                    
                })
                
                    .padding(.leading)
                Button(action: {
                    // add review
                    print("Apply Filter and Hide")
                    
                    applyFilter()
                    showFilter.toggle()
                }, label: {
                    HStack {
                        Text("Apply_Filter".localized(language))
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("blueColor"))
                    .cornerRadius(12)
                    .padding(.horizontal, 30)
                })
            }
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            .frame( height: 60)
            .padding(.horizontal)
            .padding(.bottom,10)
        }
        .onChange(of: selectedFilterCityName){newval in
            if newval != OldselectedFilterCityName{
            selectedFilterAreaId = 0
            selectedFilterAreaName = ""
            }else{
                selectedFilterAreaId = OldselectedFilterAreaId
                selectedFilterAreaName = OldselectedFilterAreaName
            }
        }
        .onChange(of: selectedSpecLvlId){newval in
            selectedSubSpecLvlIds = []
            selectedSubSpecLvlNames = []
        }
    }
    
    
    //MARK: --- Functions ----
    func getAllDoctors(){
        
        searchDoc.DoctorName = searchTxt
        searchDoc.SkipCount = 0
        searchDoc.publishedModelSearchDoc.removeAll()
        searchDoc.FetchDoctors(operation: .fetchDoctors)
    }
    
    func applyFilter(){
        
        searchDoc.FilterSeniortyLevelId = selectedSeniorityLvlId
        searchDoc.FilterSpecialistId = selectedSpecLvlId ?? 115151
        searchDoc.FilterSubSpecialistId = selectedSubSpecLvlIds
        searchDoc.FilterCityId = selectedFilterCityId
        searchDoc.FilterAreaId = selectedFilterAreaId
        searchDoc.FilterFees = selectedFee > 0 ?  Int(FeesVM.publishedMinMaxFee?.MinimumFees ?? 0) + Int(selectedFee):0
        getAllDoctors()
    }
    
    func resetFilter(){
        selectedSeniorityLvlId = 0
        selectedSpecLvlId = OldselectedSpecLvlId
        selectedSpecLvlName = OldselectedSpecLvlName

        selectedSubSpecLvlIds = []
        selectedFilterCityId = OldselectedFilterCityId
        selectedFilterCityName = OldselectedFilterCityName

        selectedFilterAreaId = OldselectedFilterAreaId
        selectedFilterAreaName = OldselectedFilterAreaName

        selectedFee  = 0
        selectedSubSpecLvlIds = []
//        getAllDoctors()
        applyFilter()
    }
    
}

struct FilterMenu_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            FilterMenu(FilterTag: .constant(.Menu), showFilter: .constant(true), selectedSeniorityLvlName: .constant(""),selectedSeniorityLvlId:.constant(0), selectedSpecLvlName: .constant(""),OldselectedSpecLvlName: .constant(""), selectedSpecLvlId: .constant(0),OldselectedSpecLvlId: .constant(0), selectedSubSpecLvlNames: .constant([]),selectedSubSpecLvlIds:.constant([]), selectedFee: .constant(0), selectedFilterCityName: .constant(""),OldselectedFilterCityName: .constant(""),selectedFilterCityId:.constant(0),OldselectedFilterCityId:.constant(0), selectedFilterAreaName: .constant(""),OldselectedFilterAreaName: .constant(""),selectedFilterAreaId:.constant(0),OldselectedFilterAreaId:.constant(0),searchTxt:.constant(""))
                .environmentObject(VMSearchDoc())
                .environmentObject(ViewModelFees())
        }
        
        
    }
}


