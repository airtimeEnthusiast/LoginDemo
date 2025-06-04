//
//  ItemCommentsView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUI

//MARK: Item Detail View
struct ItemCommentsView: View {
    var item: Item
    @StateObject private var vm = ItemDetailViewModel()
    var body: some View {
        VStack {
            ForEach(vm.comments, id: \.self){ comment in
                VStack(alignment: .leading, spacing: 6) {
                    Text(comment.author)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white.opacity(0.8))
                    Text(comment.message)
                        .font(.body)
                    Text(comment.timestamp)
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(12)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(16)
                .frame(maxWidth: 250, alignment: .leading)
                .padding(.leading)
            }
        }.onAppear {
            if vm.comments.count == 0 {
                vm.loadComments(id: item.id)
            }
        }
    }
}
