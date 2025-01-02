import 'package:fe_giotmauvang_mobile/models/Event.dart';
import 'package:fe_giotmauvang_mobile/providers/AppointmentProvider.dart';
import 'package:fe_giotmauvang_mobile/providers/AuthProvider.dart';
import 'package:fe_giotmauvang_mobile/providers/EventProvider.dart';
import 'package:fe_giotmauvang_mobile/providers/UnitProvider.dart';
import 'package:fe_giotmauvang_mobile/providers/UserProvider.dart';
import 'package:fe_giotmauvang_mobile/screen/BloodDonationSchedule/BloodDonationInfo.dart';
import 'package:fe_giotmauvang_mobile/screen/User/homeScreen/home.dart';
import 'package:fe_giotmauvang_mobile/screen/User/loginScreen/login.dart';
import 'package:fe_giotmauvang_mobile/screen/User/userProfileScreen/userProfile.dart';
import 'package:fe_giotmauvang_mobile/screen/eventScreen/Event.dart';
import 'package:fe_giotmauvang_mobile/services/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AppointmentProvider(),),
        ChangeNotifierProvider(create: (context) => EventProvider(),),
        ChangeNotifierProvider(create: (context) => UnitProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/userProfile': (context) => const UserProfileScreen(),
        '/bloodDonationInfo': (context) =>  BloodDonationInfo(),
        '/events': (context) => const EventScreen()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: context.read<AuthProvider>().checkAuthentication(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final authProvider = context.watch<AuthProvider>();
          if (authProvider.isAuthenticated) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
