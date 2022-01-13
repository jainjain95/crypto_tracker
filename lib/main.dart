import 'package:crypto/constant/theme.dart';
import 'package:crypto/models/localStorage.dart';
import 'package:crypto/pages/home_page.dart';
import 'package:crypto/provider/market_provider.dart';
import 'package:crypto/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentState = await LocalStorage.getTheme() ?? "light";
  runApp( MyApp(theme: currentState));
}

class MyApp extends StatelessWidget {
  

  final String theme;
  MyApp({required this.theme});

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
        )

        //.......
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeProvider.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: HomePage(),
        );
      }),
    );
  }
}
