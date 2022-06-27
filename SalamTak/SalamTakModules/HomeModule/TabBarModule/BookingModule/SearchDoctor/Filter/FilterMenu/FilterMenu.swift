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
                            
                            Text(searchDoc.FilterSeniortyLevelName ?? "" == "" ? "All_Titles".localized(language):searchDoc.FilterSeniortyLevelName ?? "" )
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
                            Text(searchDoc.FilterSpecialistName ?? "")
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
                            Text(searchDoc.FilterSubSpecialistName == [] ? "All_SubSpecs".localized(language): searchDoc.FilterSubSpecialistName.joined(separator: ", ") )
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
                            Text(searchDoc.FilterCityName ?? "" == "" ? "All_Cities".localized(language):searchDoc.FilterCityName ?? "")
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
                            Text(searchDoc.FilterAreaName ?? "" == "" ? "All_Areas".localized(language):searchDoc.FilterAreaName ?? "")
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
                            Text( searchDoc.FilterFees > 0 ?  "From".localized(language) + " \(String( FeesVM.publishedMinMaxFee?.MinimumFees ?? 0))" + " to".localized(language) + " \(String(Int( searchDoc.FilterFees))) "+"EGP".localized(language):"All_Prices".localized(language))
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

    }
    //MARK: --- Functions ----
    func getAllDoctors(){
        searchDoc.DoctorName = searchTxt
        searchDoc.SkipCount = 0
        searchDoc.publishedModelSearchDoc?.removeAll()
        searchDoc.FetchDoctors(operation: .fetchDoctors)
    }
    
    func applyFilter(){
        searchDoc.FilterFees = Float(searchDoc.FilterFees > 0 ? Int(searchDoc.FilterFees):0)
        searchDoc.publishedModelSearchDoc?.removeAll()
        getAllDoctors()
    }
    
    func resetFilter(){
        searchDoc.FilterSeniortyLevelId = 0
        searchDoc.FilterSpecialistId = searchDoc.SpecialistId
        searchDoc.FilterSpecialistName = searchDoc.SpecialistName
        searchDoc.FilterSubSpecialistId = []
        searchDoc.FilterSubSpecialistName = []
        searchDoc.FilterCityId = searchDoc.CityId
        searchDoc.FilterCityName = searchDoc.CityName
        searchDoc.FilterAreaId = searchDoc.AreaId
        searchDoc.FilterAreaName = searchDoc.AreaName
        searchDoc.FilterFees = 0
        getAllDoctors()
    }
    
}

struct FilterMenu_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            FilterMenu(FilterTag: .constant(.Menu), showFilter: .constant(true), searchTxt:.constant(""))
                .environmentObject(VMSearchDoc())
                .environmentObject(ViewModelFees())
        }
    }
}


