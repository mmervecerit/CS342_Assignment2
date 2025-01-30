//
//  NewPatientFormView.swift
//  CS342-Assignment1
//
//  Created by Merve Cerit on 1/27/25.
//
import SwiftUI

@Observable class PatientManager {
    static let shared = PatientManager()

    let med1: Medication
    let med2: Medication
    let med3: Medication
    let med4: Medication

    var patients: [Patient]

    init() {
        self.med1 = try! Medication(dateString: "2025/1/27", dateFormat: "yyyy/MM/dd", name: "Aspirine", dose: 250, route: "oral", frequency: 2, duration: 10, isCompleted: false)
        self.med2 = try! Medication(dateString: "2025/1/28", dateFormat: "yyyy/MM/dd", name: "Tylenol", dose: 500, route: "oral", frequency: 3, duration: 7, isCompleted: false)
        self.med3 = try! Medication(dateString: "2025/1/15", dateFormat: "yyyy/MM/dd", name: "Advil", dose: 1.5, route: "oral", frequency: 2, duration: 4, isCompleted: false)
        self.med4 = try! Medication(dateString: "2025/1/1", dateFormat: "yyyy/MM/dd", name: "Cipro", dose: 10, route: "oral", frequency: 1, duration: 60, isCompleted: false)

        self.patients = [
            try! Patient(firstName: "Merve", lastName: "Cerit", dateOfBirthString: "11/07/1994", dateOfBirthFormat: "MM/dd/yy", height: 5.6, weight: 120, medications: [med1, med2]),
            try! Patient(firstName: "Bryan", lastName: "B", dateOfBirthString: "12/08/1992", dateOfBirthFormat: "MM/dd/yy", height: 6.3, weight: 200, medications: [med1, med2, med3, med4]),
            try! Patient(firstName: "Honey", lastName: "Bee", dateOfBirthString: "07/13/1966", dateOfBirthFormat: "MM/dd/yy", height: 5.0, weight: 140, medications: [med2, med3, med4])
        ]
    }
}

