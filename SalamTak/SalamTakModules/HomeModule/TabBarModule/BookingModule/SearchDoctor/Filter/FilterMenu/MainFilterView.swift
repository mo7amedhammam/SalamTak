//
//  MainFilterView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine

enum FilterCases{
    case Menu,Title,Speciality,SubSpeciality,City,Area,Fees
}

struct MainDoctorFilterView: View {
    @EnvironmentObject var searchDoc : VMSearchDoc
    @EnvironmentObject var seniorityVM : ViewModelSeniority
    @EnvironmentObject var specialityvm : ViewModelSpecialist
    @EnvironmentObject var SubSpecialityVM : ViewModelSubspeciality
    @EnvironmentObject var CitiesVM : ViewModelGetCities
    @EnvironmentObject var AreasVM : ViewModelGetAreas
    @EnvironmentObject var FeesVM : ViewModelFees
    
    @Binding var FilterTag:FilterCases
    @Binding var showFilter:Bool
    
//    @Binding var SpecialistId:Int
//    @Binding var CityId:Int
//    @Binding var CityName:String
//
//    @Binding var AreaId:Int
//    @Binding var AreaName:String

//    @Binding var selectedSeniorityLvlName :String?
//    @Binding var selectedSeniorityLvlId :Int?
//    @Binding var SenbuttonSelected: Int?
//
//    @Binding var selectedSpecLvlName :String?
//    @Binding var OldselectedSpecLvlName :String
//
//    @Binding var selectedSpecLvlId :Int?
////    @Binding var OldselectedSpecLvlId :Int?
//    @Binding var SpecbuttonSelected: Int?
//
//    @Binding var selectedSubSpecLvlNames : [String]
//    @Binding var selectedSubSpecLvlIds : [Int]
//
    @Binding var selectedFee :Float
    
//    @Binding var selectedFilterCityName :String?
////    @Binding var OldselectedFilterCityName :String
//
//    @Binding var selectedFilterCityId :Int?
////    @Binding var OldselectedFilterCityId :Int?
//
////    @Binding var CitybuttonSelected: Int?
//
//    @Binding var selectedFilterAreaName :String?
////    @Binding var OldselectedFilterAreaName :String
//
//    @Binding var selectedFilterAreaId :Int?
////    @Binding var OldselectedFilterAreaId :Int?
//
//    @Binding var AreabuttonSelected: Int?
    @Binding  var searchTxt : String
    
    var body: some View {
        CustomSheet(IsPresented: $showFilter, TapToDismiss: .constant(false), content: {
            switch FilterTag{
            case .Menu:
                FilterMenu(FilterTag: $FilterTag, showFilter: $showFilter,
                           selectedFee: $selectedFee,searchTxt:$searchTxt)
                    .environmentObject(searchDoc)
                    .environmentObject(FeesVM)
                
                
            case .Speciality:
                SpecialityFilterList( FilterTag: $FilterTag)
                    .environmentObject(specialityvm)
                    .environmentObject(searchDoc)
                
            case .Title:
                TitleFilterList(FilterTag: $FilterTag)
                    .environmentObject(seniorityVM)
                
            case .SubSpeciality:
                SubSpecialityFilterList( FilterTag: $FilterTag)
                    .environmentObject(SubSpecialityVM)
                    .environmentObject(searchDoc)

                
            case .City:
                CityFilterList( FilterTag: $FilterTag)
                    .environmentObject(CitiesVM)
                    .environmentObject(searchDoc)

            case .Area:
                AreaFilterList( FilterTag: $FilterTag)
                    .environmentObject(AreasVM)
                    .environmentObject(searchDoc)

                
            case .Fees:
                FeesFilterView( FilterTag: $FilterTag, selectedFee: $selectedFee)
                    .environmentObject(FeesVM)
            }
            
            
        })
        
    }
}





