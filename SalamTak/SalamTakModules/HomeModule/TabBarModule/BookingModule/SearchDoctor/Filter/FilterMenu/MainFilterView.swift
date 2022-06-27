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
  
//    @Binding var selectedFee :Float
 
    @Binding  var searchTxt : String
    
    var body: some View {
        CustomSheet(IsPresented: $showFilter, TapToDismiss: .constant(false), content: {
            switch FilterTag{
            case .Menu:
                FilterMenu(FilterTag: $FilterTag, showFilter: $showFilter,
                           searchTxt:$searchTxt)
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
                FeesFilterView( FilterTag: $FilterTag)
                    .environmentObject(FeesVM)
            }
            
            
        })
        
    }
}





