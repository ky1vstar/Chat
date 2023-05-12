//
//  Created by Alex.M on 14.06.2022.
//

import SwiftUI

struct TextInputView: View {

    @Environment(\.chatTheme) private var theme

    @EnvironmentObject private var globalFocusState: GlobalFocusState

    @Binding var text: String
    var inputFieldId: UUID
    var style: InputViewStyle

    var body: some View {
        TextField.multiline(text: $text)
            .customFocus($globalFocusState.focus, equals: .uuid(inputFieldId))
            .placeholder(when: text.isEmpty) {
                Text(style.placeholder)
                    .foregroundColor(theme.colors.buttonBackground)
            }
            .foregroundColor(style == .message ? theme.colors.textLightContext : theme.colors.textDarkContext)
            .padding(.vertical, 10)
            .onTapGesture {
                globalFocusState.focus = .uuid(inputFieldId)
            }
    }
}

extension TextField where Label == Text {
    static func multiline(text: Binding<String>) -> TextField<Text> {
        if #available(iOS 16.0, *) {
            return TextField("", text: text, axis: .vertical)
        } else {
            return TextField("", text: text, prompt: nil)
        }
    }
}
