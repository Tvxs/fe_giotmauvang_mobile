import 'package:fe_giotmauvang_mobile/providers/UnitProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../providers/EventProvider.dart';
import '../../widgets/custom_app_bar.dart';
import '../BloodDonationSchedule/BloodDonationBooking.dart';

const TextStyle labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.grey,
  fontFamily: 'Roboto',
);

const TextStyle valueStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  color: Colors.black87,
  fontFamily: 'Roboto',

);

const TextStyle headerStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
  fontFamily: 'Roboto',

);

const TextStyle titleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black,
  letterSpacing: -0.5,
  fontFamily: 'Roboto',

);

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _HomePageState();
}

class _HomePageState extends State<EventScreen> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 30)),
  );
  String filterSelected = 'Gần tôi';
  String organizationSelected = 'Tất cả';
  String selectedUnitId = ''; // To store the selected unit ID
  List<dynamic> units = []; // To store the list of units

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUnits(); // Fetch units when the screen is loaded
    });

    // Fetch events when the screen is loaded
    final provider = Provider.of<EventProvider>(context, listen: false);
    provider.fetchEvents(dateRange.start, dateRange.end);
  }

  Future<void> _fetchUnits() async {
    final provider = Provider.of<UnitProvider>(context, listen: false);
    await provider.fetchUnit(); // Fetch the list of units
    setState(() {
      units = provider.units; // Store the fetched units in the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(106),
        child: NavBarCustom(),
      ),
      body: Consumer<EventProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text('Lỗi: ${provider.errorMessage}'));
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelector(),
                  const SizedBox(height: 24),
                  _buildFiltersSection(),
                  const SizedBox(height: 24),
                  _buildResultCount(provider.events.length),
                  _buildEventsList(provider.events),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Bạn cần đặt lịch vào thời gian nào?',
                  style: titleStyle,

                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Từ ngày - Đến ngày',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    initialValue: '${DateFormat('dd/MM/yyyy').format(dateRange.start)} - ${DateFormat('dd/MM/yyyy').format(dateRange.end)}',
                    readOnly: true,
                    onTap: _showDatePicker,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    final provider = Provider.of<EventProvider>(context, listen: false);
                    provider.fetchEvents(dateRange.start, dateRange.end);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Tìm kiếm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          const SizedBox(height: 20),
          _buildOrganizationDropdown(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bộ lọc:',
          style: headerStyle,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: [
            _buildFilterChip('Gần tôi'),
            _buildFilterChip('Đề xuất'),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: filterSelected == label,
      onSelected: (bool selected) {
        setState(() {
          filterSelected = label;
        });
      },
      selectedColor: Colors.blue.withOpacity(0.2),
      checkmarkColor: Colors.blue,
    );
  }

  Widget _buildOrganizationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Đơn vị tổ chức:',
          style: headerStyle,

        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: organizationSelected,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: [
            const DropdownMenuItem<String>(
              value: "Tất cả",
              child: Text('Tất cả',style: TextStyle(fontFamily: "Roboto"),),
            ),
            ...units.map((unit) => DropdownMenuItem<String>(
              value: unit['id'].toString(),
              child: Text(unit['name'] ?? 'Không có tên'),
            )),
          ],
          onChanged: _handleOrganizationChange,
        ),
      ],
    );
  }

  Widget _buildResultCount(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        '$count Kết quả',
        style: titleStyle,

      ),
    );
  }

  Widget _buildEventsList(List<dynamic> events) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final event = events[index];
        return _buildEventCard(event);
      },
    );
  }

  Widget _buildEventCard(dynamic event) {
    final donationUnitDTO = event['donationUnitDTO'];
    final address = donationUnitDTO?['location'] ?? 'Địa chỉ không có';
    final unitPhotoUrl = donationUnitDTO?['unitPhotoUrl'] ?? '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: _buildEventImage(unitPhotoUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['name'] ?? 'Sự kiện không có tên',
                  style: titleStyle,
                ),
                const SizedBox(height: 12),
                _buildEventInfo(event, address),
                const SizedBox(height: 16),
                _buildRegistrationSection(event),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventImage(String imageUrl) {
    return imageUrl.isNotEmpty
        ? Image.network(
      imageUrl,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
    )
        : _buildPlaceholderImage();
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          size: 30,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildEventInfo(dynamic event, String address) {
    return Column(
      children: [
        _buildInfoRow(
          Icons.location_on,
          'Địa chỉ:',
          address,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          Icons.event,
          'Thời gian hoạt động:',
          event['eventDate'] ?? 'Không có thông tin',
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          Icons.access_time,
          'Thời gian hiến máu:',
          event['eventStartTime'] ?? 'Không có thời gian',
        ),
      ],
    );
  }

  // Widget _buildInfoRow(IconData icon, String label, String value) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Icon(icon, size: 18, color: Colors.grey),
  //       const SizedBox(width: 8),
  //       Expanded(
  //         child: RichText(
  //           text: TextSpan(
  //             style: DefaultTextStyle.of(context).style,
  //             children: [
  //               TextSpan(
  //                 text: '$label ',
  //                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color:  Colors.black),
  //               ),
  //               TextSpan(text: value,
  //                       style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 17)
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: labelStyle,
                ),
                TextSpan(
                  text: value,
                  style: valueStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationSection(dynamic event) {
    final registeredCount = event['currentRegistrations'] ?? 0;
    final totalSlots = event['maxRegistrations'] ?? 0;
    final isAvailable = event['status'] == 'ACTIVE';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.people, size: 18),
                SizedBox(width: 8),
                Text('Số lượng đăng ký',
                  style: labelStyle,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '$registeredCount/$totalSlots người',
              style: valueStyle.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
        ElevatedButton(
          onPressed: isAvailable
              ? () => _navigateToBooking(event['id'].toString())
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(isAvailable ? 'Đăng ký' : 'Hết chỗ'),
        ),
      ],
    );
  }

  void _showDatePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: dateRange,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.light(primary: Colors.blue),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != dateRange) {
      setState(() {
        dateRange = picked;
      });
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.fetchEvents(dateRange.start, dateRange.end);
    }
  }

  void _handleOrganizationChange(String? newValue) {
    if (newValue != null) {
      setState(() {
        organizationSelected = newValue;
        selectedUnitId = newValue;
      });
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.fetchEvents(dateRange.start, dateRange.end, unitId: selectedUnitId);
    }
  }

  void _navigateToBooking(String eventId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BloodDonationBooking(eventId: eventId),
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: const PreferredSize(
  //       preferredSize: Size.fromHeight(106),
  //
  //       child: NavBarCustom(),
  //
  //     ),
  //     body: Consumer<EventProvider>(
  //       builder: (context, provider, child) {
  //         if (provider.isLoading) {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //         if (provider.errorMessage.isNotEmpty) {
  //           return Center(child: Text('Lỗi: ${provider.errorMessage}'));
  //         }
  //
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 _buildDateSelector(),
  //                 const SizedBox(height: 20),
  //                 _buildFilters(),
  //                 const SizedBox(height: 20),
  //                 _buildOrganizationDropdown(),
  //                 const SizedBox(height: 20),
  //                 _buildResultCount(provider.events.length),
  //                 _buildDonationList(provider.events),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _buildDateSelector() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 const Icon(Icons.calendar_today),
  //                 const SizedBox(width: 8),
  //                 Text(
  //                   'Bạn cần đặt lịch vào thời gian nào?',
  //                   style: Theme.of(context).textTheme.titleLarge,
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 8),
  //             TextFormField(
  //               decoration: InputDecoration(
  //                 hintText: 'Từ ngày - Đến ngày',
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 suffixIcon: const Icon(Icons.calendar_today),
  //               ),
  //               initialValue: DateFormat('dd/MM/yyyy').format(dateRange.start) + ' - ' + DateFormat('dd/MM/yyyy').format(dateRange.end),
  //               readOnly: true,
  //               onTap: () async {
  //                 DateTimeRange? picked = await showDateRangePicker(
  //                   context: context,
  //                   firstDate: DateTime(2000),
  //                   lastDate: DateTime(2100),
  //                   initialDateRange: dateRange,
  //                   builder: (context, child) {
  //                     return Theme(
  //                       data: ThemeData.light().copyWith(
  //                         primaryColor: Colors.blue,
  //                       ),
  //                       child: child!,
  //                     );
  //                   },
  //                 );
  //                 if (picked != null && picked != dateRange) {
  //                   setState(() {
  //                     dateRange = picked;
  //                   });
  //                   final provider = Provider.of<EventProvider>(context, listen: false);
  //                   provider.fetchEvents(dateRange.start, dateRange.end);
  //                 }
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(width: 16),
  //       ElevatedButton(
  //         onPressed: () {
  //           final provider = Provider.of<EventProvider>(context, listen: false);
  //           provider.fetchEvents(dateRange.start, dateRange.end);
  //         },
  //         child: const Text('Tìm kiếm'),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildFilters() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('Bộ lọc:'),
  //       const SizedBox(height: 8),
  //       Row(
  //         children: [
  //           FilterChip(
  //             label: const Text('Gần tôi'),
  //             selected: filterSelected == 'Gần tôi',
  //             onSelected: (bool selected) {
  //               setState(() {
  //                 filterSelected = 'Gần tôi';
  //               });
  //             },
  //           ),
  //           const SizedBox(width: 8),
  //           FilterChip(
  //             label: const Text('Đề xuất'),
  //             selected: filterSelected == 'Đề xuất',
  //             onSelected: (bool selected) {
  //               setState(() {
  //                 filterSelected = 'Đề xuất';
  //               });
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildOrganizationDropdown() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('Đơn vị tổ chức:'),
  //       const SizedBox(height: 8),
  //       DropdownButtonFormField<String>(
  //         value: organizationSelected,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //         ),
  //         items: [
  //           // Đảm bảo rằng 'Tất cả' là một DropdownMenuItem<String>
  //           DropdownMenuItem<String>(
  //             value: "Tất cả",
  //             child: Text('Tất cả'),
  //           ),
  //           ...units.map((unit) {
  //             return DropdownMenuItem<String>(
  //               value: unit['id'].toString(), // Lưu ID của đơn vị như String
  //               child: Text(unit['name'] ?? 'Không có tên'),
  //             );
  //           }).toList(),
  //         ],
  //         onChanged: (String? newValue) {
  //           setState(() {
  //             organizationSelected = newValue!;  // Lưu giá trị đơn vị đã chọn
  //             selectedUnitId = newValue;        // Lưu lại ID của đơn vị được chọn
  //           });
  //           final provider = Provider.of<EventProvider>(context, listen: false);
  //           provider.fetchEvents(dateRange.start, dateRange.end, unitId: selectedUnitId); // Gọi API để lấy sự kiện theo bộ lọc
  //         },
  //       ),
  //     ],
  //   );
  // }
  //
  //
  // Widget _buildResultCount(int count) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 16.0),
  //     child: Text(
  //       '$count Kết quả',
  //       style: const TextStyle(
  //         fontSize: 18,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildDonationList(List<dynamic> events) {
  //   return Column(
  //     children: events.map<Widget>((event) {
  //       var donationUnitDTO = event['donationUnitDTO'];
  //       var address = donationUnitDTO != null && donationUnitDTO['location'] != null
  //           ? donationUnitDTO['location']
  //           : 'Địa chỉ không có';
  //       var unitPhotoUrl = donationUnitDTO != null && donationUnitDTO['unitPhotoUrl'] != null
  //           ? donationUnitDTO['unitPhotoUrl']
  //           : '';
  //       var id = event['id'];
  //
  //       return _buildDonationCard(
  //         eventId : id.toString(),
  //         logo: unitPhotoUrl.isNotEmpty ? unitPhotoUrl : 'CTD',
  //         title: event['name'] ?? 'Sự kiện không có tên',
  //         address: address,
  //         operatingDate: event['eventDate'] ?? 'Không có thông tin',
  //         donationTime: event['eventStartTime'] ?? 'Không có thời gian',
  //         registeredCount: event['currentRegistrations'] ?? 0,
  //         totalSlots: event['maxRegistrations'] ?? 0,
  //         isAvailable: event['status'] == 'ACTIVE',
  //       );
  //     }).toList(),
  //   );
  // }
  //
  // Widget _buildDonationCard({
  //   required String logo,
  //   required String title,
  //   required String eventId,
  //   required String address,
  //   required String operatingDate,
  //   required String donationTime,
  //   required int registeredCount,
  //   required int totalSlots,
  //   required bool isAvailable,
  // }) {
  //   return Card(
  //     elevation: 2,
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           // Card chứa hình ảnh
  //           Card(
  //             elevation: 2,
  //             child: SizedBox(
  //               height: 150,  // Cài đặt chiều cao hình ảnh
  //               child: logo.isNotEmpty? ClipRRect(
  //                 borderRadius: BorderRadius.circular(8),  // Căn chỉnh bo góc cho hình ảnh
  //                 child: Image.network(
  //                   logo,
  //                   fit: BoxFit.cover,  // Cách hiển thị hình ảnh
  //                   width: double.infinity,  // Đảm bảo hình ảnh chiếm toàn bộ chiều rộng
  //                   height: double.infinity,
  //                 )
  //               )
  //                   : const Icon(Icons.image_not_supported),
  //             ),
  //           ),
  //
  //           const SizedBox(height: 8),  // Khoảng cách giữa hai card
  //
  //           // Card chứa thông tin
  //           Card(
  //             elevation: 2,
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     title,
  //                     style: const TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 16,
  //                       overflow: TextOverflow.ellipsis,  // Dùng ellipsis khi văn bản quá dài
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   _buildInfoRow('Địa chỉ:', address),
  //                   _buildInfoRow('Thời gian hoạt động:', operatingDate),
  //                   _buildInfoRow('Thời gian hiến máu:', donationTime),
  //                   const SizedBox(height: 16),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               const Icon(Icons.people),
  //                               const SizedBox(width: 8),
  //                               Text('Số lượng đăng ký'),
  //                             ],
  //                           ),
  //                           Text(
  //                             '$registeredCount/$totalSlots người',
  //                             style: const TextStyle(
  //                               color: Colors.blue,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       ElevatedButton(
  //                         onPressed: isAvailable
  //                             ? () {
  //                           Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                               builder: (context) => BloodDonationBooking(eventId: eventId), // Truyền eventId
  //                             ),
  //                           );
  //                         }
  //                             : null,
  //                         child: Text(isAvailable ? 'Đăng ký' : 'Hết chỗ'),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildInfoRow(String label, String value) {
  //   return Row(
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(fontWeight: FontWeight.bold),
  //
  //       ),
  //       const SizedBox(width: 8),
  //       Text(value),
  //     ],
  //   );
  // }
}
