import 'package:fe_giotmauvang_mobile/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 600, // Đặt chiều cao tối thiểu
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 530, // Đặt chiều cao cụ thể
                child: BannerWidget(),
              ),

              SizedBox(height: 16),
              SizedBox(
                height: 600, // Đặt chiều cao cụ thể
                child: CarouselWidget(),
              ),
              SizedBox(height: 16),
              StandardsWidget(),
              SizedBox(height: 16),
              NotesWidget(),
              SizedBox(height: 16),
              AdviceWidget(),
              // SizedBox(height: 16),
              // ActivitiesWidget(),

              SizedBox(height: 16,),
              FooterWidget()
            ],
          ),
        ),
      ),
    );
  }
}
