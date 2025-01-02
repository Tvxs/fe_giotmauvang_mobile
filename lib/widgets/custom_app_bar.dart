import 'package:fe_giotmauvang_mobile/providers/AuthProvider.dart';
import 'package:fe_giotmauvang_mobile/screen/BloodDonationSchedule/BloodDonationInfo.dart';
import 'package:fe_giotmauvang_mobile/screen/User/loginScreen/login.dart' as login_screen;
import 'package:fe_giotmauvang_mobile/screen/User/homeScreen/home.dart';
import 'package:fe_giotmauvang_mobile/screen/User/newsScreen/news.dart';
import 'package:fe_giotmauvang_mobile/screen/User/QandA/QA.dart';
import 'package:fe_giotmauvang_mobile/screen/User/certificateScreen/certificate.dart';
import 'package:fe_giotmauvang_mobile/screen/User/userProfileScreen/userProfile.dart';
import 'package:fe_giotmauvang_mobile/screen/eventScreen/Event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBarCustom extends StatefulWidget {
  const NavBarCustom({Key? key}) : super(key: key);

  @override
  _NavBarCustomState createState() => _NavBarCustomState();
}

class _NavBarCustomState extends State<NavBarCustom> {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _menuOverlay;

  // Hiển thị menu khi nhấn vào nút menu
  void _showMenu(BuildContext context) {
    final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = MediaQuery.of(context).size;

    _menuOverlay = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: _hideMenu,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Positioned(
              top: offset.dy + renderBox.size.height,
              right: 0,
              width: size.width * 0.5,
              height: size.height - offset.dy - renderBox.size.height,
              child: Material(
                color: Colors.white,
                elevation: 8,
                child: ListView(
                  padding: const EdgeInsets.only(top: 20),
                  children: [
                    _buildMenuItem('Trang chủ', onTap: () {
                      _hideMenu();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }),
                    _buildMenuItem('Đăng ký hiến máu', onTap: (){
                      _hideMenu();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EventScreen(),
                        ),);
                    }),
                    _buildMenuItem('Lịch hẹn của bạn', onTap: (){
                      _hideMenu();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  BloodDonationInfo(),
                      ),);
                    }),
                    _buildMenuItem('Lịch sử hiến máu'),
                    _buildMenuItem('Chứng nhận', onTap: () {
                      _hideMenu();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CertificateScreen(),
                        ),
                      );
                    }),
                    _buildMenuItem('Hỏi đáp', onTap: () {
                      _hideMenu();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QAScreen(),
                        ),
                      );
                    }),
                    _buildMenuItem('Tin tức', onTap: () {
                      _hideMenu();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewsScreen(),
                        ),
                      );
                    }),
                    _buildMenuItem('Liên hệ'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_menuOverlay!);
  }

  // Ẩn menu khi người dùng nhấn ngoài menu
  void _hideMenu() {
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

  // Xây dựng một mục menu
  Widget _buildMenuItem(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          print("Selected: $title");
          _hideMenu();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Divider(height: 1, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Container(
            key: _menuKey,
            color: Colors.blue,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (_menuOverlay == null) {
                      _showMenu(context);
                    } else {
                      _hideMenu();
                    }
                  },
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // VN | EN
          Row(
            children: const [
              Text(
                'VN',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(width: 4),
              Text(
                '|',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(width: 4),
              Text(
                'EN',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          // Logo
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Image.asset(
                'assets/logo-hutech.png',
                height: 40,
              ),
            ),
          ),
          // Login Icon with Authentication Check
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: PopupMenuButton<String>(
              onSelected: (String value) async {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                if (value == 'profile') {
                  // Chuyển đến trang hồ sơ
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfileScreen(),
                    ),
                  );
                } else if (value == 'logout') {
                  // Đăng xuất
                  await authProvider.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const login_screen.LoginScreen(),
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Xem Hồ Sơ'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Đăng Xuất'),
                ),
              ],
              icon: const Icon(
                Icons.person_outline,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
