//
//  NewPatientFormView.swift
//  CS342-Assignment1
//
//  Created by Merve Cerit on 1/28/25.
//

import SwiftUI

struct NewPatientFormView: View {
    @Environment(\.dismiss) var dismiss // this whole dismiss thing i learned from chatgpt: https://chatgpt.com/share/679aedc0-450c-8004-bf87-7bec88c5c61a
    @State var patientManager: PatientManager
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var height = ""
    @State private var weight = ""
    @State private var bloodType: BloodType? = nil

    @State private var firstNameError: String? = nil
    @State private var lastNameError: String? = nil
    @State private var heightError: String? = nil
    @State private var weightError: String? = nil

    @State private var showErrorAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Required Patient Information")) {
                    TextField("First Name", text: $firstName)
                        .textInputAutocapitalization(.words)
                        .onChange(of: firstName) { validateFirstName() }.accessibilityIdentifier("FirstNameField")
                    if let error = firstNameError {
                        Text(error).foregroundColor(.red).font(.footnote)
                    }

                    TextField("Last Name", text: $lastName)
                        .textInputAutocapitalization(.words)
                        .onChange(of: lastName) { validateLastName() }.accessibilityIdentifier("LastNameField")
                    if let error = lastNameError {
                        Text(error).foregroundColor(.red).font(.footnote)
                    }

                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date).accessibilityIdentifier("DOBPicker")
                
                
                    TextField("Height (ft)", text: $height)
                        .keyboardType(.decimalPad)
                        .onChange(of: height) { validateHeight() }.accessibilityIdentifier("HeightField")
                    if let error = heightError {
                        Text(error).foregroundColor(.red).font(.footnote)
                    }

                    TextField("Weight (lbs)", text: $weight)
                        .keyboardType(.decimalPad)
                        .onChange(of: weight) { validateWeight() }.accessibilityIdentifier("WeightField")
                    if let error = weightError {
                        Text(error).foregroundColor(.red).font(.footnote)
                    }
                
                }
                Section(header: Text("Optional Information")) {
                    Picker("Blood Type", selection: $bloodType) {
                        Text("Unknown").tag(nil as BloodType?)
                        ForEach(BloodType.allCases, id: \.self) { blood in
                            Text(blood.rawValue).tag(blood as BloodType?)
                        }
                    }.accessibilityIdentifier("BloodTypePicker")
                }
            }
            .navigationTitle("New Patient")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        addPatient()
                    }.accessibilityIdentifier("SavePatientButton")
                    .disabled(hasValidationErrors() || firstName.isEmpty || lastName.isEmpty || height.isEmpty || weight.isEmpty)
                }
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func validateFirstName() {
        firstNameError = firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "First name is required." : nil
    }

    private func validateLastName() {
        lastNameError = lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Last name is required." : nil
    }

    private func validateHeight() {
        if let doubleValue = Double(height), doubleValue > 0 {
            heightError = nil
        } else {
            heightError = "Please enter a valid height."
        }
    }

    private func validateWeight() {
        if let doubleValue = Double(weight), doubleValue > 0 {
            weightError = nil
        } else {
            weightError = "Please enter a valid weight."
        }
    }

    private func hasValidationErrors() -> Bool {
        return firstNameError != nil || lastNameError != nil || heightError != nil || weightError != nil
    }
    
    private func addPatient() {
        guard let heightDouble = Double(height),
              let weightDouble = Double(weight) else {
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let dobString = dateFormatter.string(from: dateOfBirth)

        do {
            let newPatient = try Patient(
                firstName: firstName,
                lastName: lastName,
                dateOfBirthString: dobString,
                dateOfBirthFormat: "MM/dd/yy",
                height: heightDouble,
                weight: weightDouble,
                bloodType: bloodType
            )

            print("Adding new patient: \(newPatient.firstName) \(newPatient.lastName)")
            patientManager.patients.append(newPatient) 
            dismiss()
        } catch {
            alertMessage = "An error occurred while adding the patient."
            showErrorAlert = true
        }
    }
}

#if DEBUG
#Preview {
    @Previewable @State var patientManager = PatientManager.shared
    NewPatientFormView(patientManager: patientManager)
}
#endif
