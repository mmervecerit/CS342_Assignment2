# CS342 Assignment 2 - Patient Management App

## Overview
This project is a Swift-based iOS application designed for CS342 at Stanford University. The app provides a simple patient management system, allowing users to add patients, manage their information, and prescribe medications. The project is built using SwiftUI and follows the MVVM (Model-View-ViewModel) architecture.

## Features
- **Patient Management**: Users can view and add patient information.
- **Medication Management**: Prescribe medications with details such as dosage, route, frequency, and duration.
- **Blood Type Compatibility**: Determines compatible donor blood types for patients.
- **Search Functionality**: Quickly find patients by last name.
- **Validation & Error Handling**: Ensures correct user input for fields like name, height, weight, and medication dosage.
- **Unit & UI Tests**: Comprehensive test coverage for patient and medication operations.

## Directory Structure
```bash
├── CS342-Assignment1/
│   ├── BloodType.swift               # Enum for blood types
│   ├── CS342_Assignment1App.swift    # App entry point
│   ├── Medication.swift               # Model for medications
│   ├── NewPatientFormView.swift       # Form to add new patients
│   ├── Patient.swift                  # Model for patient details
│   ├── PatientDetailView.swift        # UI to view patient details
│   ├── PatientListView.swift          # UI to list and search patients
│   ├── PatientManager.swift           # Singleton for managing patient data
│   ├── PrescribeMedicationView.swift  # UI for prescribing medications
│   ├── Assets.xcassets/               # App icons and UI assets
│   ├── Preview Content/               # UI preview assets
│
├── CS342-Assignment1.xcodeproj/       # Xcode project files
│   ├── project.pbxproj
│   ├── project.xcworkspace/
│
├── CS342-Assignment1Tests/            # Unit tests
│   ├── CS342_Assignment1Tests.swift   # Tests for patient and medication models
│
└── CS342-Assignment1UITests/          # UI tests
    ├── CS342_Assignment1UITests.swift  # UI test cases
    ├── CS342_Assignment1UITestsLaunchTests.swift
```

## Installation

### Steps
1. Clone the repository:
   ```sh
   git clone <repository-url>
   cd mmervecerit-cs342_assignment2
   ```
2. Open the project in Xcode:
   ```sh
   open CS342-Assignment1.xcodeproj
   ```
3. Build and run the app using an iOS Simulator or a connected device.

## Usage
- **Adding a Patient**: Tap the `+` button in the patient list and fill out the form.
- **Viewing a Patient**: Select a patient from the list to see details.
- **Prescribing Medication**: Click `Prescribe` in a patient’s details view, enter medication details, and save.
- **Searching for Patients**: Use the search bar to filter patients by last name.

## Testing
### Running Unit Tests
To run unit tests, execute:
```sh
CMD + U (in Xcode)
```
### Running UI Tests
To execute UI tests:
```sh
CMD + U (in Xcode with a simulator running)
```

## Acknowledgments
This project was created for CS342 at Stanford University as part of an assignment on iOS app development. Some UI logic and validation techniques were learned and applied with the help of ChatGPT.

**This README is written by ChatGPT using gitingest. ** See [chat link](https://chatgpt.com/share/679af71d-c5d0-8004-b8c6-bb22351f6175)

