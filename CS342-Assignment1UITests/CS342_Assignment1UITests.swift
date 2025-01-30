//
//  CS342_Assignment1UITests.swift
//  CS342-Assignment1UITests
//
//  Created by Merve Cerit on 1/8/25.
//

import XCTest

final class CS342_Assignment1UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // I used chatgpt to learn about accessibility identifier and checking whether a button/field contains a string. https://chatgpt.com/share/679aedc0-450c-8004-bf87-7bec88c5c61a
    
    @MainActor
    func testAddPatient() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.buttons["AddPatientButton"].tap()
        
        let firstNameField = app.textFields["FirstNameField"]
        let lastNameField = app.textFields["LastNameField"]
        let heightField = app.textFields["HeightField"]
        let weightField = app.textFields["WeightField"]
        
        firstNameField.tap()
        firstNameField.typeText("John")
        
        lastNameField.tap()
        lastNameField.typeText("Doe")
        
        heightField.tap()
        heightField.typeText("5.9")
        
        weightField.tap()
        weightField.typeText("160")
        
        app.buttons["SavePatientButton"].tap()
        
        let patientButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", "John Doe")).firstMatch
        XCTAssertTrue(patientButton.exists, "The patient should be added to the list")
    }

    
    @MainActor
    func testSearchPatient() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search field should appear after tapping search")
           
        searchField.tap()
        searchField.typeText("Cer")

        let patientButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", "Merve Cerit")).firstMatch
        XCTAssertTrue(patientButton.exists, "The patient should appear in search results")
            
        patientButton.tap()

        let patientDetailView = app.staticTexts["PatientDetailView"]
        XCTAssertTrue(patientDetailView.exists, "Should navigate to patient's detail page")

    }
    
    @MainActor
    func testPrescribeMedication() throws {
        let app = XCUIApplication()
        app.launch()

        let patientButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", "Honey Bee")).firstMatch
        XCTAssertTrue(patientButton.exists, "Patient 'Honey Bee' should exist in the list")
        patientButton.tap()

        let prescribeButton = app.buttons["PrescribeButton"]
        XCTAssertTrue(prescribeButton.exists, "Prescribe button should exist")
        prescribeButton.tap()

        let medNameField = app.textFields["MedicationNameField"]
        let doseField = app.textFields["DoseField"]
        let routeField = app.textFields["RouteField"]
        let frequencyField = app.textFields["FrequencyField"]
        let durationField = app.textFields["DurationField"]

        XCTAssertTrue(medNameField.exists, "Medication Name field should exist")
        XCTAssertTrue(doseField.exists, "Dose field should exist")
        XCTAssertTrue(routeField.exists, "Route field should exist")
        XCTAssertTrue(frequencyField.exists, "Frequency field should exist")
        XCTAssertTrue(durationField.exists, "Duration field should exist")

        medNameField.tap()
        medNameField.typeText("Aspirin")

        doseField.tap()
        doseField.typeText("500")

        routeField.tap()
        routeField.typeText("Oral")

        frequencyField.tap()
        frequencyField.typeText("2")

        durationField.tap()
        durationField.typeText("7")

        let saveButton = app.buttons["SaveMedicationButton"]
        XCTAssertTrue(saveButton.exists, "Save button should exist")
        saveButton.tap()

        let medicationCell = app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", "Aspirin")).firstMatch
        XCTAssertTrue(medicationCell.exists, "The prescribed medication should be listed under current medications")
    }


}
