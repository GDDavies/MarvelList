//
//  LoadingView.swift
//  MarvelList
//
//  Created by George Davies on 23/10/2022.
//

import SwiftUI

struct LoadingView: View {

    @Binding var isLoading: Bool

    var body: some View {
        if isLoading {
            ProgressView()
        }
    }
}
