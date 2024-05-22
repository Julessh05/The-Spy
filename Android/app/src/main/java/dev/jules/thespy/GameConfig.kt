package dev.jules.thespy

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import androidx.compose.ui.unit.dp

@Preview
@Composable
fun GameConfig(
    @PreviewParameter(OnNavigatePreviewProvider::class) onNavigate: (Int, Int) -> Unit
) {
    var numberPlayer by remember { mutableStateOf("") }
    var numberSpies by remember { mutableStateOf("") }
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .fillMaxHeight(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        TextField(
            value = numberPlayer,
            onValueChange = {
                numberPlayer = it
            },
            label = { Text("How many player are there?") },
        )
        TextField(
            value = numberSpies,
            onValueChange = {
                numberSpies = it
            },
            label = { Text("How many spies should be there?") },
        )
        Button(
            onClick = { onNavigate(numberPlayer.toInt(), numberSpies.toInt()) },
            modifier = Modifier.padding(24.dp)
        ) {
            Text("Done")
        }
    }
}
