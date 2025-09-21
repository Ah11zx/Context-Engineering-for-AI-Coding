import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants.dart';
import 'theme.dart';
import 'widgets/dashboard_page.dart';

void main() {
  runApp(const FananApp());
}

class FananApp extends StatelessWidget {
  const FananApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فنان - مساعد المحتوى العربي',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(),
      locale: supportedLocales.first,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const DashboardPage(),
    );
  }
}
