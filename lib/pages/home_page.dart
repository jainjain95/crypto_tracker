import 'package:crypto/pages/favorites.dart';
import 'package:crypto/pages/market_list.dart';
import 'package:crypto/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  
  late TabController viewController;
  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 0,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      "Crypto Market",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    }, 
                    icon: (themeProvider.themeMode == ThemeMode.light) ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
                  )
                ],
              ),
              // SizedBox(height: 20),
              TabBar(
                controller: viewController,
                tabs: [
                  Tab(
                    child: Text("Markets", style: Theme.of(context).textTheme.bodyText1,),
                  ),
                  Tab(
                    child: Text("Favorites", style: Theme.of(context).textTheme.bodyText1,),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()
                  ),
                  controller: viewController,
                  children: [
                    Market(),
                    Favorites(),
                  ],
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
