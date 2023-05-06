import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/controllers/mainscreen_provider.dart';
import 'package:online_shop/views/mainscreen.dart';

import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier(),)
      ],
      child: const MyApp()), 
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home:  MainScreen(),
    );
  }
}
