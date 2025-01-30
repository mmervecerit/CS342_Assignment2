//
//  NewPatientFormView.swift
//  CS342-Assignment1
//
//  Created by Merve Cerit on 1/28/25.
//

import SwiftUI

struct PrescribeMedicationView: View {
    var patient: Patient
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var dose = ""
    @State private var route = ""
    @State private var frequency = ""
    @State private var duration = ""

    @State private var doseError: String? = nil
    @State private var frequencyError: String? = nil
    @State private var durationError: String? = nil
    @State private var showErrorAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Medication Details")) {
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words).accessibilityIdentifier("MedicationNameField")
                    
                    TextField("Dose (mg)", text: $dose)
                        .keyboardType(.decimalPad)
                        .onChange(of: dose) { newValue in validateDose(newValue) }.accessibilityIdentifier("DoseField") // used ChatGPT to learn about "on change" and validation functions: https://chatgpt.com/share/679aebfe-478c-8004-aaf9-5192a830efa0
                    if let error = doseError {
                        Text(error).foregroundColor(.red).font(.footnote)
                    }
                    
                    TextField("Route (e.g., oral, injection)", text: $route)
                        .textInputAutocapitalization(.none).accessibilityIdentifier("RouteField")
                    
                    TextField("Frequency (times per day)", text: $frequency)
                        .keyboardType(.numberPad)
                        .onChange(of: frequency) { newValue in validateFrequency(newValue) }.accessibilityIdentifier("FrequencyField")
                    if let error = frequencyError {
                        Text(error).foregroundColor(.red).font(.footnote)
                    }
                    
                    TextField("Duration (days)", text: $duration)
                        .keyboardType(.numberPad)
                        .onChange(of: duration) { newValue in validateDuration(newValue) }.accessibilityIdentifier("DurationField")
                    if let error = durationError {
                        Text(error).foregroundColor(.red).font(.footnote)
                    }
                }
            }
            .navigationTitle("Prescribe Medication")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        addMedication()
                    }.accessibilityIdentifier("SaveMedicationButton")
                    .disabled(hasValidationErrors() || name.isEmpty || route.isEmpty)
                }
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func validateDose(_ value: String) {
        if let doubleValue = Double(value), doubleValue > 0 {
            doseError = nil
        } else {
            doseError = "Please enter a valid positive number."
        }
    }

    private func validateFrequency(_ value: String) {
        if let intValue = Int(value), intValue > 0 {
            frequencyError = nil
        } else {
            frequencyError = "Frequency must be a positive whole number."
        }
    }

    private func validateDuration(_ value: String) {
        if let intValue = Int(value), intValue > 0 {
            durationError = nil
        } else {
            durationError = "Duration must be a positive whole number."
        }
    }

    private func hasValidationErrors() -> Bool {
        return doseError != nil || frequencyError != nil || durationError != nil
    }
    
    private func addMedication() {
        guard let doseDouble = Double(dose),
              let frequencyInt = Int(frequency),
              let durationInt = Int(duration) else {
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: Date())

        do {
            let newMedication = try Medication(
                dateString: todayString,
                dateFormat: "yyyy-MM-dd",
                name: name,
                dose: doseDouble,
                route: route,
                frequency: frequencyInt,
                duration: durationInt
            )

            print("Trying to add medication: \(newMedication.name)")
            print("Existing medications: \(patient.medications.map { $0.name })")

            try patient.prescribeMedication(medication: newMedication)
            dismiss()
        } catch MedicationError.duplicateMedication {
            alertMessage = "This medication is already prescribed."
            showErrorAlert = true
        } catch {
            alertMessage = "Unexpected error: \(error.localizedDescription)"
            showErrorAlert = true
            print("Error details: \(error)")
        }
    }
}

#if DEBUG
#Preview {
    @Previewable @State var patientManager = PatientManager.shared
    PrescribeMedicationView(patient: patientManager.patients[0])
}
#endif
