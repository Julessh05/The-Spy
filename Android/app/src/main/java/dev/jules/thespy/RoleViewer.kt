package dev.jules.thespy

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import org.json.JSONObject
import kotlin.random.Random


private var playerCounter = 1
private var spyNumbers = emptyList<Int>()
private var textToShow = ""
private var word = ""
private var numberPlayerGlobal = 2
private var wordLoaded = false


private fun init() {
    playerCounter = 1
    spyNumbers = emptyList()
    textToShow = ""
    word = ""
    numberPlayerGlobal = 2
    wordLoaded = false
}

@OptIn(ExperimentalMaterial3Api::class)
@Preview(showBackground = true)
@Composable
internal fun RoleViewer(
    @PreviewParameter(OnNavigatePreviewProvider::class) onNavigate: () -> Unit,
    // Default parameter to enable preview
    numberPlayer: Int = 2,
    numberSpies: Int = 1
) {
    var hidden by remember { mutableStateOf(true) }
    if (!wordLoaded) {
        init()
        numberPlayerGlobal = numberPlayer
        val stream =
            LocalContext.current.assets.open("words.json").bufferedReader().use { it.readText() }
        val jsObject = JSONObject(stream)
        val categories = jsObject.names()
        val categoryNumber = Random.nextInt(1, categories!!.length())
        val category = jsObject.getJSONArray(categories.getString(categoryNumber))
        val wordNumber = Random.nextInt(1, category.length())
        word = category.get(wordNumber).toString()
        for (i in 1..numberSpies) {
            spyNumbers = spyNumbers.plus(Random.nextInt(1, numberPlayer + 1))
        }
        wordLoaded = true
    }
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Roles") })
        }
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .fillMaxHeight()
                .padding(it),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            Box(Modifier.clickable {
                if (!hidden) {
                    hidden = true
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
            ) {
                Column {
                    if (hidden && playerCounter <= numberPlayerGlobal) {
                        Text("Tap to show")
                    } else if (hidden) {
                        Text("Tap to start")
                    } else if (playerCounter > numberPlayerGlobal) {
                        Text("Loading...")
                    } else {
                        Text(textToShow)
                        Text("Tap to hide again")
                    }
                }
            }
        }
    }
}
