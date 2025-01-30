//
//  NewPatientFormView.swift
//  CS342-Assignment1
//
//  Created by Merve Cerit on 1/28/25.
//

import SwiftUI

struct PatientDetailView: View {
    var patient: Patient
    @State private var showingPrescribeMedicationSheet = false

    var body: some View {
        List {
            Section(header: Text("Patient Information").accessibilityIdentifier("PatientDetailView")) {
                HStack {
                    Text("Name:")
                    Spacer()
                    Text("\(patient.firstName) \(patient.lastName)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Date of Birth:")
                    Spacer()
                    Text(patient.dateOfBirth, style: .date)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Age:")
                    Spacer()
                    if let age = try? patient.calculateAge() {
                        Text("\(age) years")
                            .foregroundColor(.secondary)
                    } else {
                        Text("Unknown")
                            .foregroundColor(.secondary)
                    }
                }
                HStack {
                    Text("Height:")
                    Spacer()
                    Text("\(patient.height, specifier: "%.1f") ft")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Weight:")
                    Spacer()
                    Text("\(patient.weight, specifier: "%.1f") lbs")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Blood Type:")
                    Spacer()
                    Text(patient.bloodType?.rawValue ?? "Unknown")
                        .foregroundColor(.secondary)
                }
            }
            
            Section(header: HStack {
                Text("Current Medications")
                Spacer()
                Button {
                    showingPrescribeMedicationSheet.toggle()
                } label: {
                    Label("Prescribe", systemImage: "pencil")
                }.accessibilityIdentifier("PrescribeButton")
            }) {
                if patient.returnActiveMedications().isEmpty {
                    Text("No active medications").foregroundColor(.secondary)
                } else {
                    ForEach(patient.returnActiveMedications(), id: \.id) { medication in
                        VStack(alignment: .leading) {
                            Text(medication.name)
                                .font(.headline)
                            Text("Prescribed on: \(medication.date, style: .date)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle(patient.returnPatientInfo())
        .sheet(isPresented: $showingPrescribeMedicationSheet) {
            PrescribeMedicationView(patient: patient)
        }
    }
}
#if DEBUG
#Preview {
    @Previewable @State var patientManager = PatientManager.shared
    NavigationStack {
        PatientDetailView(patient: patientManager.patients[0])
    }
   
}
#endif
