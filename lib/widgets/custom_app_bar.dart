import 'package:flutter/material.dart';

class NavBarCustom extends StatelessWidget {
  const NavBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Thanh AppBar chính
        const CustomAppBar(),
        // Thanh màu xanh
        Container(
          color: Colors.blue,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(
                Icons.menu,
                color: Colors.white,
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ],
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
            'assets/logo-hutech.png', // Thay bằng đường dẫn logo của bạn
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
