import 'package:fe_giotmauvang_mobile/screen/QandA/QA.dart';
import 'package:fe_giotmauvang_mobile/screen/homeScreen/home.dart';
import 'package:flutter/material.dart';
import '../screen/newsScreen/news.dart';
import '../screen/certificateScreen/certificate.dart';

class NavBarCustom extends StatefulWidget {
  const NavBarCustom({Key? key}) : super(key: key);

  @override
  _NavBarCustomState createState() => _NavBarCustomState();
}

class _NavBarCustomState extends State<NavBarCustom> {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _menuOverlay;

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }),
                    _buildMenuItem('Đăng ký hiến máu'),
                    _buildMenuItem('Lịch sử hiến máu'),
                    _buildMenuItem('Chứng nhận', onTap: () {
                      _hideMenu();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CertificateScreen(),
                        ),
                      );
                    }),
                    _buildMenuItem('Hỏi đáp', onTap: () {
                      _hideMenu();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QAScreen(),
                        ),
                      );
                    }),
                    _buildMenuItem('Tin tức', onTap: () {
                      _hideMenu();
                      Navigator.push(
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

  void _hideMenu() {
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

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
        cursor: SystemMouseCursors.click, // Hiển thị pointer khi di chuột
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
          // Thanh AppBar chính
          const CustomAppBar(),
          // Thanh màu xanh
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
          Image.asset(
            'assets/logo-hutech.png',
            height: 40,
          ),
          // Icon người dùng
          const Icon(
            Icons.person_outline,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
