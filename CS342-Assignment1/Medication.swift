//
//  Medication.swift
//  CS342-Assignment1
//
//  Created by Merve Cerit on 1/8/25.
//
import SwiftUI
import Foundation
@Observable public class Medication: Identifiable{
    var date: Date
    var name: String
    var dose: Double
    var route: String
    var frequency: Int //assumed it is entered as integer?
    var duration: Int
    var isCompleted: Bool = false
    
    
    init(dateString: String, dateFormat: String, name: String, dose: Double, route: String,frequency:Int,duration:Int,isCompleted:Bool=false) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let parsedDate = dateFormatter.date(from: dateString) else {
            throw MedicationError.invalidDate
        }
        self.date = parsedDate
        self.name=name
        self.dose=dose
        self.route=route
        self.frequency=frequency
        self.duration=duration
        self.isCompleted=isCompleted
        
        
    }
    
    func checkCompleted(){
        let dayPassed = Calendar.current.dateComponents([.day], from: self.date, to: Date())
        if  dayPassed.day ?? 0>self.duration{
            self.isCompleted=true
        }
    }
        
}
extension Medication:CustomStringConvertible{
    public var description: String{
        var frequencyString: String = ""
        if frequency==1
        {
            frequencyString = "once"
        } else
        {
            if frequency==2{
                frequencyString = "twice"
            }
            else {frequencyString = "\(frequency) times"}
        }
        return "\(name) \(String(dose)) mg \(route) \(frequencyString) daily for \(String(duration)) days"
    }
}

