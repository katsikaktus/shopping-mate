//
//  Binding.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import Foundation
import SwiftUI

/**
 An extension to `Binding` when its value type is `Bool`.

 This extension provides an initializer that creates a `Binding<Bool>`
 instance based on the nil status of another `Binding` instance of
 any optional type.

 - Parameter value: A `Binding` instance wrapping an optional value (`T?`).
                    This is the source binding that the new `Binding<Bool>`
                    instance will be based upon.

 - Returns: A `Binding<Bool>` instance. This binding's value is `true` if the
            `value`'s wrapped optional is not `nil`, and `false` if it is `nil`.

 - Discussion: This extension is useful for creating a `Bool` binding that reflects
               the presence or absence of a value. It is particularly handy in UI
               logic where the visibility or state of a view element depends on
               whether an optional value is nil or not.

               The getter for this binding checks if the `wrappedValue` of the input
               `Binding<T?>` is nil. If it is nil, the getter returns `false`,
               otherwise, it returns `true`.

               The setter for this binding allows changing the `wrappedValue` of the
               original `Binding<T?>`. If the new value of the `Binding<Bool>` is set
               to `false`, the `wrappedValue` of the `Binding<T?>` is set to `nil`.
               Note that setting the `Binding<Bool>` to `true` does not change the
               `wrappedValue` of the `Binding<T?>`.

 - Example:
    ```
    @State var optionalString: String? = "Hello"
    var stringExistsBinding: Binding<Bool> = Binding(value: $optionalString)

    // Now, stringExistsBinding will be true since optionalString is not nil.
    // Setting stringExistsBinding to false will set optionalString to nil.
    ```
*/

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
