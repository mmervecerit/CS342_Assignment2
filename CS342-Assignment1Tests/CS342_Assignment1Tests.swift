//
//  CS342_Assignment1Tests.swift
//  CS342-Assignment1Tests
//
//  Created by Merve Cerit on 1/8/25.
//

import Testing
@testable import CS342_Assignment1



struct CS342_Assignment1Tests {

    //test creating a patient and get its description.
    @Test func create_patient() async throws {
        
        let patient1=try Patient(firstName: "Merve", lastName: "Cerit",dateOfBirthString:"11/7/94",dateOfBirthFormat:"MM/dd/yy",height: 5.6, weight:115,bloodType:.zeroplus)
        #expect(patient1.description == "Cerit, Merve(30)")
        #expect(patient1.returnPatientInfo() == "Cerit, Merve(30)")
        #expect(patient1.medications.isEmpty)
        #expect(patient1.bloodType == .zeroplus)
        #expect(patient1.returnDonorBloodTypes() == [.zerominus, .zeroplus])
        
    }
    
    //test creating a patient without bloodtype and test its description
    @Test func create_patient_wo_bloodtype() async throws {
    
        let patient1=try Patient(firstName: "Merve", lastName: "Cerit",dateOfBirthString:"11/7/94",dateOfBirthFormat:"MM/dd/yy",height: 5.6, weight:115)
        #expect(patient1.description == "Cerit, Merve(30)")
        #expect(patient1.returnPatientInfo() == "Cerit, Merve(30)")
        #expect(patient1.medications.isEmpty)
        #expect(patient1.bloodType == .none)
        #expect(patient1.returnDonorBloodTypes() == [])

    }
    //test adding patient's bloodtype later and then getting the donor list
    @Test func setbloodtype_returndonorlist() async throws {
    
        let patient1=try Patient(firstName: "Merve", lastName: "Cerit",dateOfBirthString:"11/7/1994",dateOfBirthFormat:"MM/dd/yyyy",height: 5.6, weight:115)
        patient1.setBloodType(bloodType: .abplus)
        #expect(patient1.bloodType  == .abplus)
        #expect(patient1.bloodType?.description == "AB+")
        #expect(patient1.returnDonorBloodTypes() == [.abminus,.abplus,.aminus,.aplus,.bminus,.bplus,.zeroplus,.zerominus])
    }
    
    //test creating medication
    @Test func createMedication() async throws {
        let med1=try Medication(dateString: "12/9/2024", dateFormat: "MM/dd/yyyy", name: "Metoprolol", dose: 25.5, route: "by mouth", frequency: 1, duration: 90)
        #expect(med1.description  == "Metoprolol 25.5 mg by mouth once daily for 90 days")
    }
    
    //test prescribing a medication
    @Test func prescribeMedication() async throws {
        let patient1=try Patient(firstName: "Merve", lastName: "Cerit",dateOfBirthString:"11/7/1994",dateOfBirthFormat:"MM/dd/yyyy",height: 5.6, weight:115)
        let med1=try Medication(dateString: "12/9/2024", dateFormat: "MM/dd/yyyy", name: "Metoprolol", dose: 25.5, route: "by mouth", frequency: 1, duration: 90)
        try patient1.prescribeMedication(medication: med1)
        #expect(patient1.medications[0].description==med1.description)

    }
    
    //test prescribing a duplicate medication, assuming equality based on name only.
    @Test func prescribeduplicateMedication() async throws {
        let med1=try Medication(dateString: "12/9/2024", dateFormat: "MM/dd/yyyy", name: "Metoprolol", dose: 25.5, route: "by mouth", frequency: 1, duration: 90)
        let patient1=try Patient(firstName: "Merve", lastName: "Cerit",dateOfBirthString:"11/7/1994",dateOfBirthFormat:"MM/dd/yyyy",height: 5.6, weight:115,medications:[med1])
        #expect(patient1.medications[0].name == med1.name)
        #expect(throws:MedicationError.duplicateMedication){
            try patient1.prescribeMedication(medication: med1)
        }
    }
    //test getting a list of medications, and make sure they are ordered based on date and completed ones are not included.
    @Test func getlistofMedications() async throws {
        let med1=try Medication(dateString: "11/9/2024", dateFormat: "MM/dd/yyyy", name: "Metoprolol", dose: 25.5, route: "by mouth", frequency: 1, duration: 90)
        let med2=try Medication(dateString: "12/9/2024", dateFormat: "MM/dd/yyyy", name: "Advil", dose: 500, route: "by mouth", frequency: 2, duration: 60)
        let med3=try Medication(dateString: "12/9/2024", dateFormat: "MM/dd/yyyy", name: "Tylenol", dose: 30, route: "by mouth", frequency: 3, duration: 10)
        let patient1=try Patient(firstName: "Merve", lastName: "Cerit",dateOfBirthString:"11/7/1994",dateOfBirthFormat:"MM/dd/yyyy",height: 5.6, weight:115,medications:[med1])
        
        try patient1.prescribeMedication(medication: med2)
        
        #expect(patient1.medications.count == 2)
        #expect(patient1.returnActiveMedications().count == 2)
        #expect(patient1.returnActiveMedications().description=="[Advil 500.0 mg by mouth twice daily for 60 days, Metoprolol 25.5 mg by mouth once daily for 90 days]")
        
        try patient1.prescribeMedication(medication: med3)
        #expect(patient1.medications.count == 3)
        #expect(patient1.returnActiveMedications().description=="[Advil 500.0 mg by mouth twice daily for 60 days, Metoprolol 25.5 mg by mouth once daily for 90 days]")
    }

        

    
    
    
    

}
