package dev.jules.thespy

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter

@Preview
@Composable
internal fun RoleViewer(
    @PreviewParameter(OnNavigatePreviewProvider::class) onNavigate: () -> Unit,
    numberPlayer: Int = 2,
    numberSpies: Int = 1
) {
    var hidden = true
    var word = "Loaded Word"
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .fillMaxHeight(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Box(Modifier.clickable { hidden = !hidden }) {
            Column {
                if (hidden) {
                    Text("Tap to show")
                } else {
                    Text("You're a spy")
                    Text("Tap to hide again")
                }
            }
        }
    }
}
