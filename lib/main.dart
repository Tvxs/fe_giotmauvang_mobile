import 'package:fe_giotmauvang_mobile/screen/User/homeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:fe_giotmauvang_mobile/screen/User/newsScreen/news.dart';
import 'package:fe_giotmauvang_mobile/screen/User/profile/profile.dart';
import 'package:fe_giotmauvang_mobile/screen/AppointmentHistoryScreen/AppointmentHistory.dart';

void main() {
  runApp(const MyApp());
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
      home: AppointmentHistoryScreen(),
    );  }
}
