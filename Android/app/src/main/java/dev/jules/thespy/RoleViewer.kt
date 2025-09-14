package dev.jules.thespy

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import androidx.compose.ui.unit.dp
import org.json.JSONObject
import java.util.Locale
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
    val spyString = stringResource(R.string.youre_a_spy)
    var hidden by remember { mutableStateOf(true) }
    if (!wordLoaded) {
        init()
        numberPlayerGlobal = numberPlayer
        val fileName = "words_${Locale.getDefault().language}.json"
        val stream =
            LocalContext.current.assets.open(fileName).bufferedReader().use { it.readText() }
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
                title = { Text(stringResource(R.string.roles)) })
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
            val isSpy: Boolean = spyNumbers.contains(playerCounter)
            val backgroundColor = if (isSpy) Color.Red else Color(0xFFFF9800)
            Box(
                modifier = Modifier
                    .size(width = 250.dp, height = 400.dp)
                    .background(
                        color = backgroundColor,
                        shape = RoundedCornerShape(16.dp)
                    )
                    .clickable {
                        if (!hidden) {
                            hidden = true
                            playerCounter += 1
                        } else {
                            if (spyNumbers.contains(playerCounter)) {
                                textToShow = spyString
                            } else if (playerCounter > numberPlayerGlobal) {
                                wordLoaded = false
                                onNavigate()
                            } else {
                                textToShow = word
                            }
                            hidden = !hidden
                        }
                    },
                contentAlignment = Alignment.Center
            ) {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text("${stringResource(R.string.player)} $playerCounter")
                    Spacer(modifier = Modifier.size(150.dp))
                    if (hidden && playerCounter <= numberPlayerGlobal) {
                        Text(stringResource(R.string.tap_to_show))
                    } else if (hidden) {
                        Text(stringResource(R.string.tap_to_start))
                    } else if (playerCounter > numberPlayerGlobal) {
                        Text(stringResource(R.string.loading))
                    } else {
                        Text(textToShow)
                        Text(stringResource(R.string.tap_to_hide_again))
                    }
                    Spacer(modifier = Modifier.size(150.dp))
                }
            }
        }
    }
}
