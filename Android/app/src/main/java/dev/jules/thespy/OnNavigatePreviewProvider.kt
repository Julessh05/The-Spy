package dev.jules.thespy

import androidx.compose.ui.tooling.preview.PreviewParameterProvider

internal class OnNavigatePreviewProvider : PreviewParameterProvider<() -> Unit> {
    override val values: Sequence<() -> Unit>
        get() = sequenceOf({ previewOnNavigate() })

    private fun previewOnNavigate() {
        print("preview btn pressed")
    }
}
