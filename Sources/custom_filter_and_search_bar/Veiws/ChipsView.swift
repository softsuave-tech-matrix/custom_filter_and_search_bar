//
//  ChipsView.swift
//
//
//  Created by Softsuave on 24/06/24.
//

import SwiftUI


@available(iOS 13.0, *)
public struct ChipsView: View {
    @Binding var options: [String]
    var onRemove: (String) -> Void
    var chipHeight: CGFloat = 30
    var chipPadding: CGFloat = 8
    var chipHorizontalSpacing: CGFloat = 8
    var chipVerticalSpacing: CGFloat = 8
    var chipBackgroundColor: Color = Color.blue.opacity(0.2)
    var chipTextColor: Color = .primary
    var closeIcon: Image = Image(systemName: "xmark.circle")
    var closeIconTintColor: Color = .red

    @State private var totalHeight = CGFloat.zero

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(options, id: \.self) { option in
                self.item(for: option)
                    .padding([.horizontal], chipHorizontalSpacing / 2)
                    .padding([.vertical], chipVerticalSpacing / 2)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > geometry.size.width) {
                            width = 0
                            height -= d.height + chipVerticalSpacing
                        }

                        let result = width
                        if option == self.options.last! {
                            width = 0
                        } else {
                            width -= d.width + chipHorizontalSpacing
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if option == self.options.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> some View {
        HStack {
            Text(text)
                .foregroundColor(chipTextColor)
            Button(action: {
                onRemove(text)
            }) {
                closeIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: chipHeight / 2, height: chipHeight / 2)
                    .foregroundColor(closeIconTintColor)
            }
        }
        .padding(.all, chipPadding)
        .frame(height: chipHeight)
        .background(chipBackgroundColor)
        .cornerRadius(chipHeight / 2)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geo.frame(in: .local).size.height
            }
            return Color.clear
        }
    }
}
