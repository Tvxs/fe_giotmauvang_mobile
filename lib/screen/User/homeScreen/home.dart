import 'package:fe_giotmauvang_mobile/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import 'banner_widget.dart';
import 'carousel_widget.dart';
import 'standards_widget.dart';
import 'notes_widget.dart';
import 'advice_widget.dart';
import 'activities_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(106), // Tổng chiều cao của AppBar
        child: NavBarCustom(), // Sử dụng widget NavBarCustom
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Widget
            SizedBox(
              height: 530, // Đặt chiều cao cho BannerWidget
              child: const BannerWidget(),
            ),
            const SizedBox(height: 16),

            // Carousel Widget
            SizedBox(
              height: 600, // Đặt chiều cao cho CarouselWidget
              child: const CarouselWidget(),
            ),
            const SizedBox(height: 16),

            // Standard Widget
            const StandardsWidget(),
            const SizedBox(height: 16),

            // Notes Widget
            const NotesWidget(),
            const SizedBox(height: 16),

            // Advice Widget
            const AdviceWidget(),
            const SizedBox(height: 16),

            // Footer Widget
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
