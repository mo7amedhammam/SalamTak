//
//  TimerViewModel.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    private var timer: AnyCancellable?
    @Published var count = 0
    
    init() {
        timer = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.count += 1
            }
    }
}
