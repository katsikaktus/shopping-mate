//
//  BindingBoolExtensionTests.swift
//  ShoppingMateTests
//
//  Created by Giota on 2024-02-03.
//

import XCTest
import SwiftUI
@testable import ShoppingMate


final class BindingBoolExtensionTests: XCTestCase {
    
    // Test for checking the getter functionality of the Binding extension with a non-nil value
    func testBindingBoolGetterWithNonNullValue() {
        var optionalString: String? = "Test String"
        let stringExistsBinding = Binding(value: Binding(get: { optionalString }, set: { optionalString = $0 }))
        
        XCTAssertTrue(stringExistsBinding.wrappedValue, "Binding<Bool> should be true when optional value is not nil")
    }
    
    // Test for checking the getter functionality of the Binding extension with a nil value
    func testBindingBoolGetterWithNilValue() {
        var optionalString: String? = nil
        let stringExistsBinding = Binding(value: Binding(get: { optionalString }, set: { optionalString = $0 }))
        
        XCTAssertFalse(stringExistsBinding.wrappedValue, "Binding<Bool> should be false when optional value is nil")
    }
    
    // Test for checking the setter functionality of the Binding extension with a non-nil value
    func testBindingBoolSetterFromTrueToFalse() {
        var optionalString: String? = "Test String"
        var stringExistsBinding = Binding(value: Binding(get: { optionalString }, set: { optionalString = $0 }))
        
        stringExistsBinding.wrappedValue = false
        XCTAssertNil(optionalString, "optionalString should be nil when Binding<Bool> is set to false")
    }
    
    // Test for checking the setter functionality of the Binding extension with a nil value
    func testBindingBoolSetterFromFalseToFalse() {
        var optionalString: String? = nil
        var stringExistsBinding = Binding(value: Binding(get: { optionalString }, set: { optionalString = $0 }))
        
        stringExistsBinding.wrappedValue = false
        XCTAssertNil(optionalString, "optionalString should remain nil when Binding<Bool>, already false, is set to false again")
    }
    
}
