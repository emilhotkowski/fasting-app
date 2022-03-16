//
//  FastingManager.swift
//  FastingTimer
//
//  Created by Emil Hotkowski on 16/03/2022.
//

import Foundation

enum FastingState {
    case notStarted
    case fasting
    case feeding
}

enum FastingPlan: String {
    case beginner = "12:12"
    case intermediate = "16:8"
    case advnaced = "20:4"
    
    var fastingPeriod: Double {
        switch self {
        case .beginner:
            return 12
        case .intermediate:
            return 16
        case .advnaced:
            return 20
        }
    }
}

class FastingManager: ObservableObject {
    @Published private(set) var fastingState: FastingState = .notStarted
    @Published private(set) var fastingPlan: FastingPlan = .intermediate
    @Published private(set) var startTime: Date
    @Published private(set) var endTime: Date
    
    init() {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour], from: Date())
        components.hour = 20
        print(components)
        
        let scheduledTime = calendar.date(from: components) ?? Date.now
        print("ScheduledTile \(scheduledTime)")
        startTime = scheduledTime
        endTime = scheduledTime.addingTimeInterval(FastingPlan.intermediate.fastingPeriod)
    }
    
    func toggleFastingState() {
        fastingState = fastingState == .fasting ? .feeding : .fasting
    }
}
