//
//  FilePickerView.swift
//  FIB Remitt
//
//  Created by Raihan on 29/1/24.
//

import SwiftUI
import UniformTypeIdentifiers

class FilePickerView: ObservableObject {
    @Published var isPickerShown: Bool = false
    var allowedContentTypes: [UTType]
    var onSelect: (URL) -> Void
    var onError: (Error) -> Void

    init(allowedContentTypes: [UTType], onSelect: @escaping (URL) -> Void, onError: @escaping (Error) -> Void) {
        self.allowedContentTypes = allowedContentTypes
        self.onSelect = onSelect
        self.onError = onError
    }

    func showPicker() {
        isPickerShown = true
    }

    func handleResult(_ result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            onSelect(url)
        case .failure(let error):
            onError(error)
        }
    }
}


// MARK: - Implementation


//import UniformTypeIdentifiers


//struct ContentView: View {
//    @StateObject private var filePickerViewModel = FilePickerViewModel(
//        allowedContentTypes: [UTType.image], // For image files
//        onSelect: { url in
//            print("Selected file: \(url.lastPathComponent)")
//        },
//        onError: { error in
//            print("Error: \(error.localizedDescription)")
//        }
//    )
//
//    var body: some View {
//        Button("Upload File") {
//            filePickerViewModel.showPicker()
//        }
//        .fileImporter(
//            isPresented: $filePickerViewModel.isPickerShown,
//            allowedContentTypes: filePickerViewModel.allowedContentTypes,
//            onCompletion: filePickerViewModel.handleResult
//        )
//    }
//}
