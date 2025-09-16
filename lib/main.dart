import 'package:flutter/material.dart';
import 'package:stock_investment_app/presentation/assets/asset_index.dart';
import 'package:stock_investment_app/presentation/pages/stocks_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenSize.setSizes();

        return const MaterialApp(
          title: 'Stock Investment App',
          home: StocksPage(),
        );
      },
    );
  }
}
