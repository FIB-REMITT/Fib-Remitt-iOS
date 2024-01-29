//
//  FilePickerView.swift
//  FIB Remitt
//
//  Created by Raihan on 29/1/24.
//@Published var isPickerShown: Bool = false

import SwiftUI
import UniformTypeIdentifiers

class FilePickerView: ObservableObject {
    var isPickerShown: Binding<Bool>
    var allowedContentTypes: [UTType]
    var onSelect: (URL) -> Void
    var onError: (Error) -> Void

    init(isPickerShown: Binding<Bool>, allowedContentTypes: [UTType], onSelect: @escaping (URL) -> Void, onError: @escaping (Error) -> Void) {
        self.isPickerShown = isPickerShown
        self.allowedContentTypes = allowedContentTypes
        self.onSelect = onSelect
        self.onError = onError
    }

    func showPicker() {
        isPickerShown.wrappedValue = true
    }

    func hidePicker() {
        isPickerShown.wrappedValue = false
    }

    func handleResult(_ result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            onSelect(url)
        case .failure(let error):
            onError(error)
        }
        hidePicker()
    }
}



// MARK: - Implementation


//import UniformTypeIdentifiers


//struct ContentView: View {
//    @State private var selectedFileURL: URL?
//    @State private var isPickerShown = false
//
//    var body: some View {
//        let filePickerView = FilePickerView(
//            isPickerShown: $isPickerShown,
//            allowedContentTypes: [UTType.pdf],
//            onSelect: { url in
//                selectedFileURL = url
//                print("Selected file: \(url)")
//            },
//            onError: { error in
//                print("Error: \(error.localizedDescription)")
//            }
//        )
//
//        // Your view code...
//        Button("Pick File") {
//            filePickerView.showPicker()
//        }
//        .fileImporter(
//            isPresented: $isPickerShown,
//            allowedContentTypes: filePickerView.allowedContentTypes,
//            onCompletion: filePickerView.handleResult
//        )
//    }
//}
