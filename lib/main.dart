import 'package:calculator/views/currency_conventer_view.dart';
import 'package:calculator/views/simple_calculator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // The number of tabs / views.
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          elevation: 0,
          title: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calculate)),
              Tab(icon: Icon(Icons.currency_exchange_rounded)),
            ],
            dividerColor: Colors.white54,
            dividerHeight: 1,
            indicatorColor: Colors.orange,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.white54,
          ),
        ),
        body: const TabBarView(
          children: [
            SimpleCalculatorView(),
            CurrencyConventerView(),
          ],
        ),
      ),
    );
  }
}
