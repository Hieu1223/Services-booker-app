import 'package:flutter/material.dart';
import 'package:home_fix/views/main_page.dart';
import 'package:home_fix/views/services_page.dart';
import 'package:home_fix/views/setting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeFix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 3, 
        child: AppShell()
      )
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final tabBars = TabBar(
      dividerHeight: 0,
      tabs:[
        const Tab(
          icon: Icon(Icons.home_outlined),
          text: "Home",
        ),
        const Tab(
          icon: Icon(Icons.handyman_outlined),
          text: "Services",
        ),
        const Tab(
          icon: Icon(Icons.settings_outlined),
          text: "Settings",
        ),
      ] 
    );

    final tabs = TabBarView(
      children:[
        MainPage(),
        ServicesPage(),
        SettingPage()
      ] 
    );

    final content = Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: tabBars,
      ),
      body: SafeArea(child: tabs),
    );

    return content;
  }
}