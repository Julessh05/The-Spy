package dev.jules.thespy

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import dev.jules.thespy.ui.theme.TheSpyTheme

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            TheSpyTheme {
                val navController = rememberNavController()
                NavHost(
                    navController = navController,
                    startDestination = Routes.Welcome.name,
                ) {
                    composable(Routes.Welcome.name) {
                        Welcome(
                            onNavigateNew = { navController.navigate(Routes.Config.name) },
                            onNavigateCats = { navController.navigate(Routes.CategoryViewer.name) },
                            onNavigateConfig = { navController.navigate(Routes.FurtherConfig.name) }

                        )
                    }
                    composable(Routes.CategoryViewer.name) {
                        CategoryViewer()
                    }
                    composable(Routes.Config.name) {
                        GameConfig { numberPlayer, numberSpies ->
                            // https://stackoverflow.com/questions/65542751/multiple-arguments-with-jetpack-compose-navigation
                            navController.navigate("${Routes.RoleViewer.name}/$numberPlayer/$numberSpies")
                        }
                    }
                    composable(
                        "${Routes.RoleViewer.name}/{numberPlayer}/{numberSpies}",
                        arguments = listOf(
                            navArgument("numberPlayer") { type = NavType.IntType },
                            navArgument("numberSpies") { type = NavType.IntType }
                        )
                    ) { backStackEntry ->
                        RoleViewer(
                            onNavigate = { navController.navigate(Routes.Game.name) },
                            numberPlayer = backStackEntry.arguments?.getInt("numberPlayer")
                                ?: 2,
                            numberSpies = backStackEntry.arguments?.getInt("numberSpies") ?: 1,
                        )
                    }
                    composable(Routes.Game.name) {
                        Game {
                            navController.navigate(Routes.Welcome.name)
                        }
                    }
                }
            }
        }
    }
}
