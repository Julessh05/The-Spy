package dev.jules.thespy

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import androidx.compose.ui.unit.dp
import androidx.core.text.isDigitsOnly

@OptIn(ExperimentalMaterial3Api::class)
@Preview
@Composable
fun GameConfig(
    @PreviewParameter(OnNavigatePreviewProvider::class) onNavigate: (Int, Int) -> Unit
) {
    var numberPlayer by remember { mutableStateOf("") }
    var numberSpies by remember { mutableStateOf("") }
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(stringResource(R.string.new_game)) })
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .fillMaxHeight()
                .padding(innerPadding),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            TextField(
                value = numberPlayer,
                onValueChange = {
                    numberPlayer = it
                },
                label = { Text(stringResource(R.string.number_player)) },
                keyboardOptions = KeyboardOptions(
                    keyboardType = KeyboardType.Number,
                    imeAction = ImeAction.Next,
                ),
            )
            TextField(
                value = numberSpies,
                onValueChange = {
                    numberSpies = it
                },
                label = { Text(stringResource(R.string.number_spies)) },
                keyboardOptions = KeyboardOptions(
                    keyboardType = KeyboardType.Number,
                    imeAction = ImeAction.Done,
                ),
            )
            Button(
                onClick = { onNavigate(numberPlayer.toInt(), numberSpies.toInt()) },
                modifier = Modifier.padding(24.dp),
                enabled = numberPlayer.isNotEmpty() && numberSpies.isNotEmpty() && numberPlayer > numberSpies && numberPlayer.isDigitsOnly() && numberSpies.isDigitsOnly()
            ) {
                Text(stringResource(R.string.done))
            }
        }
    }
}
