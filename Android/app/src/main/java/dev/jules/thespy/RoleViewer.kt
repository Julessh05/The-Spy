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
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import org.json.JSONObject
import kotlin.random.Random

private var hidden = true
private var playerCounter = 1
private val spyNumbers = emptyList<Int>()
private var textToShow = ""
private var word = ""
private var numberPlayerGlobal = 2

@Preview
@Composable
internal fun RoleViewer(
    @PreviewParameter(OnNavigatePreviewProvider::class) onNavigate: () -> Unit,
    // Default parameter to enable preview
    numberPlayer: Int = 2,
    numberSpies: Int = 1
) {
    numberPlayerGlobal = numberPlayer
    hidden = true
    val stream =
        LocalContext.current.assets.open("words.json").bufferedReader().use { it.readText() }
    val jsObject = JSONObject(stream)
    val categories = jsObject.names()
    val categoryNumber = Random.nextInt(1, categories!!.length())
    val category = jsObject.getJSONArray(categories.getString(categoryNumber))
    val wordNumber = Random.nextInt(1, category.length())
    word = category.get(wordNumber).toString()
    for (i in 1..numberSpies) {
        spyNumbers.plus(Random.nextInt(1, numberPlayer))
    }
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .fillMaxHeight(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Box(Modifier.clickable { btnTap(onNavigate) }) {
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

private fun btnTap(onNavigate: () -> Unit) {
    if (hidden) {
        hidden = false
        playerCounter += 1
    } else {
        if (spyNumbers.contains(playerCounter)) {
            textToShow = "You're a spy"
        } else if (playerCounter > numberPlayerGlobal) {
            onNavigate()
        } else {
            textToShow = word
        }
        hidden = !hidden
    }
}
