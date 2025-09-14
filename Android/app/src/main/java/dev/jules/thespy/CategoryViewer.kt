package dev.jules.thespy

import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import org.json.JSONArray
import org.json.JSONObject
import java.util.Locale

@OptIn(ExperimentalMaterial3Api::class)
@Composable
@Preview(showBackground = true)
internal fun CategoryViewer() {
    val fileName = "words_${Locale.getDefault().language}.json"
    val stream =
        LocalContext.current.assets.open(fileName).bufferedReader().use { it.readText() }
    val jsObject = JSONObject(stream)
    val categories: JSONArray = jsObject.names() ?: JSONArray()
    Scaffold {
        LazyColumn(Modifier.padding(it)) {
            for (categoryNumber in 0..categories.length()) {
                val words = jsObject.getJSONArray(categories.getString(categoryNumber))
                stickyHeader {
                    Text(categories.getString(categoryNumber))
                }
                for (wordNumber in 0..words.length()) {
                    val word = words.get(wordNumber).toString()

                    item {
                        Text(word)
                    }
                }
            }
        }
    }
}