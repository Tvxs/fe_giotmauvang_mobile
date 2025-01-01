import 'package:fe_giotmauvang_mobile/providers/AppointmentProvider.dart';
import 'package:fe_giotmauvang_mobile/providers/UserProvider.dart';
import 'package:fe_giotmauvang_mobile/screen/User/homeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:fe_giotmauvang_mobile/screen/User/newsScreen/news.dart';
import 'package:provider/provider.dart';
void main() {
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()), // Thêm các provider khác nếu cần
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );  }
}
