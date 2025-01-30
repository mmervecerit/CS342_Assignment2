//
//  Patient.swift
//  CS342-Assignment1
//
//  Created by Merve Cerit on 1/9/25.
//

import SwiftUI


@Observable class Patient: Identifiable,Hashable,Equatable{
    var recordID: UUID
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var height: Double
    var weight: Double
    var bloodType: BloodType?
    var medications: [Medication]=[]
    
    init(firstName: String, lastName: String,dateOfBirthString: String, dateOfBirthFormat: String,height:Double,weight:Double,bloodType:BloodType? = .none,medications:[Medication]=[]) throws {
        self.recordID=UUID()
        self.firstName=firstName
        self.lastName=lastName
        
        self.height=height
        self.weight=weight
        self.bloodType=bloodType
        self.medications=medications
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateOfBirthFormat
        //assuming the format of the date will be also inputted in initialization because we don't know which format it should be.
        guard let parsedDate = dateFormatter.date(from: dateOfBirthString) else {
            throw PatientError.invalidDateofBirth
        }
        self.dateOfBirth = parsedDate
    }
    
    //let's make it equatable
    static func ==(lhs: Patient, rhs: Patient) -> Bool {
        return lhs.recordID == rhs.recordID
    }
    
    static func !=(lhs: Patient, rhs: Patient) -> Bool {
        return lhs.recordID != rhs.recordID
    }
    
    //and hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(recordID)
    }
    
    
    //set bloodtype
    func setBloodType(bloodType:BloodType){
        self.bloodType=bloodType
    }
    
    //calculate age in years from the date of birth
    func calculateAge() throws-> Int{
        let now = Date()
        let calendar = Calendar.current
        let ageCalc = calendar.dateComponents([.year, .month, .day], from: dateOfBirth, to: now)
        if let years = ageCalc.year{
            return years
            } else {throw PatientError.AgeCalculationError}}
    
    
    //return patient's full name in string format (last name, first name (Age in years)
    func returnPatientInfo() -> String {
           do {
               let ageYears = try calculateAge()
               return "\(lastName), \(firstName)(\(ageYears))"
           } catch {
               return "\(lastName), \(firstName)(Issue in Age Calculation)"
           }
       }
   
    
    //return donor blood types a patient can receive blood transfusion from, given bloodtype (should it return raw value or directly the enum?)
    func returnDonorBloodTypes() -> [BloodType] {
        switch self.bloodType {
            case .aplus:
                return [.aplus,.aminus,.zerominus, .zeroplus]
            case .bplus:
                return [.bplus,.bminus,.zerominus, .zeroplus]
            case .abplus:
                return [.abminus,.abplus,.aminus,.aplus,.bminus,.bplus,.zeroplus,.zerominus]
            case .abminus:
                return [.bminus,.aminus,.zerominus, .abminus]
            case .aminus:
                return [.zerominus,.aminus]
            case .bminus:
                return [.zerominus,.bminus]
            case .zeroplus:
                return [.zerominus, .zeroplus]
            case .zerominus:
                return [.zerominus]
            case .none:
                return []
            
            }
    }

    
    //prescribe new medication, do not duplicate the medication they are currently taking, if duplicate is prescribed,throw error
    //assuming equality based on name only.
    func prescribeMedication(medication:Medication) throws {
        
        guard !self.medications.contains(where:{$0.name == medication.name})
        else {
            print("There is a duplicate medication.")
            throw MedicationError.duplicateMedication
        }
        self.medications.append(medication)
    }
    
    
    //return list of medications, sort by date prescribed(assumed descending,latest prescribed comes before), exclude any completed medication
    func returnActiveMedications() -> [Medication] {
        for med in self.medications{
            med.checkCompleted() //i couldn't do this when it was a Medication was a struct, i needed to change it to Class
        }
        return self.medications.filter{$0.isCompleted==false}.sorted(by:{$0.date > $1.date})
        }
    
}
extension Patient:CustomStringConvertible{
    var description: String{
        do {
            let ageYears = try calculateAge()
            return "\(lastName), \(firstName)(\(ageYears))"
        } catch {
            return "\(lastName), \(firstName)(Issue in Age Calculation)"
        }
    }
    }
