package dev.jules.thespy

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import kotlinx.coroutines.delay
import kotlin.time.Duration.Companion.seconds

@Preview(showBackground = true)
@Composable
internal fun Game(
    @PreviewParameter(OnNavigatePreviewProvider::class) onNavigate: () -> Unit
) {
    Column(
        modifier = Modifier
            .fillMaxHeight()
            .fillMaxWidth(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        var seconds by remember { mutableIntStateOf(0) }
        var minutes by remember { mutableIntStateOf(5) }
        // https://stackoverflow.com/questions/71191340/how-can-i-implement-a-timer-in-a-portable-way-in-jetpack-compose
        // Answer used: https://stackoverflow.com/a/71191425
        LaunchedEffect(Unit) {
            while (true) {
                delay(1.seconds)
                if (seconds == 0) {
                    if (minutes == 0) {
                        onNavigate()
                    } else {
                    seconds = 59
                    minutes--
                        }
                } else {
                    seconds--
                }
            }
        }
        Text("Time remaining:")
        Text("${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}")
        Button(onClick = { minutes++ }) {
            Text("+ 1 Minute")
        }
        Button(onClick = onNavigate) {
            Text("Done")
        }
    }
}
