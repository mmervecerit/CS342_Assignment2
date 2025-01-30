//
//  ContentView.swift
//  CS342-Assignment1
//
//  Created by Merve Cerit on 1/8/25.
//

import SwiftUI
enum MedicationError:Error{
    case duplicateMedication
    case invalidDate
}
enum PatientError:Error{
    case invalidDateofBirth
    case AgeCalculationError
}

struct PatientRowView: View {
    var person: Patient
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("\(person.firstName) \(person.lastName) (\(try!person.calculateAge()))")
                .foregroundColor(.primary)
                .font(.headline)
            HStack(spacing: 3) {
                Text("ID: \(person.recordID)")
            }
            .foregroundColor(.secondary)
            .font(.caption)
        }
    }
}

struct PatientList: View {
    @State private var patientManager = PatientManager.shared
    @State private var searchText = ""
    @State private var showingAddPatientView = false
    var body: some View {
        NavigationStack {
                   List {
                       ForEach(searchResults.sorted(by: { $0.lastName < $1.lastName })) { patient in
                           NavigationLink(destination: PatientDetailView(patient: patient)) {
                               PatientRowView(person: patient)
                           }
                       }
                   }
               .navigationTitle("Patients")
               .searchable(text: $searchText, prompt: "Search by Last Name")
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button(action: {
                           showingAddPatientView.toggle()
                       }) {
                           Image(systemName: "plus")
                       }.accessibilityIdentifier("AddPatientButton")
                   }
               }
               .sheet(isPresented: $showingAddPatientView) {
                   NewPatientFormView(patientManager: patientManager)
               }
           }
       }
       
       var searchResults: [Patient] {
           if searchText.isEmpty {
               return patientManager.patients
           } else {
               return patientManager.patients.filter { $0.lastName.localizedCaseInsensitiveContains(searchText) }
           }
       }
   }

#if DEBUG
#Preview {
    PatientList()
}
#endif
