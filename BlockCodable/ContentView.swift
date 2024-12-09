//
//  ContentView.swift
//  BlockCodable
//
//  Created by A_Mcflurry on 12/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var testModel = TestModel(value: "Hello", name: "World")
    var body: some View {
        VStack {
            Text(String(
                data: try! JSONEncoder().encode(testModel),
                encoding: .utf8
            ) ?? "")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct TestModel: Codable {
    @BlockCodable var value: String?
    var name: String
}


@propertyWrapper
struct BlockCodable<T: Codable> where T: ExpressibleByNilLiteral {
    var wrappedValue: T

    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

extension BlockCodable: Codable {
    init(from decoder: Decoder) throws {
        self.wrappedValue = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
