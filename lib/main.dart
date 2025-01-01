import 'package:fe_giotmauvang_mobile/providers/AppointmentProvider.dart';
import 'package:fe_giotmauvang_mobile/providers/AuthProvider.dart';
import 'package:fe_giotmauvang_mobile/providers/UserProvider.dart';
import 'package:fe_giotmauvang_mobile/screen/User/homeScreen/home.dart';
import 'package:fe_giotmauvang_mobile/screen/User/loginScreen/login.dart';
import 'package:fe_giotmauvang_mobile/screen/User/userProfileScreen/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:fe_giotmauvang_mobile/screen/User/newsScreen/news.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()), // AuthProvider để kiểm tra xác thực
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
      // initialRoute: "/home",
      routes: {
        '/login': (context) => const LoginScreen(), // Trang đăng nhập nếu chưa xác thực
        '/home': (context) => const HomeScreen(), // Trang Home nếu đã đăng nhập
        '/userProfile': (context) => const UserProfileScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: context.read<AuthProvider>().checkAuthentication(), // Kiểm tra xác thực khi mở ứng dụng
        builder: (context, snapshot) {
          // Nếu đang kiểm tra xác thực, hiển thị CircularProgressIndicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Kiểm tra trạng thái xác thực của người dùng
          final authProvider = context.watch<AuthProvider>();
          if (authProvider.isAuthenticated) {
            return const HomeScreen(); // Nếu người dùng đã đăng nhập, chuyển đến HomeScreen
          } else {
            return const LoginScreen(); // Nếu chưa đăng nhập, chuyển đến LoginScreen
          }
        },
      ),
    );
  }
}
