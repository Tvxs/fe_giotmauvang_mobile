import 'package:fe_giotmauvang_mobile/providers/UnitProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../providers/EventProvider.dart';

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
      body: Consumer<EventProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text('Lỗi: ${provider.errorMessage}'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelector(),
                  const SizedBox(height: 20),
                  _buildFilters(),
                  const SizedBox(height: 20),
                  _buildOrganizationDropdown(),
                  const SizedBox(height: 20),
                  _buildResultCount(provider.events.length),
                  _buildDonationList(provider.events),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelector() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(
                    'Bạn cần đặt lịch vào thời gian nào?',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Từ ngày - Đến ngày',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                initialValue: DateFormat('dd/MM/yyyy').format(dateRange.start) + ' - ' + DateFormat('dd/MM/yyyy').format(dateRange.end),
                readOnly: true,
                onTap: () async {
                  DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDateRange: dateRange,
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.blue,
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
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            final provider = Provider.of<EventProvider>(context, listen: false);
            provider.fetchEvents(dateRange.start, dateRange.end);
          },
          child: const Text('Tìm kiếm'),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bộ lọc:'),
        const SizedBox(height: 8),
        Row(
          children: [
            FilterChip(
              label: const Text('Gần tôi'),
              selected: filterSelected == 'Gần tôi',
              onSelected: (bool selected) {
                setState(() {
                  filterSelected = 'Gần tôi';
                });
              },
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('Đề xuất'),
              selected: filterSelected == 'Đề xuất',
              onSelected: (bool selected) {
                setState(() {
                  filterSelected = 'Đề xuất';
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrganizationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Đơn vị tổ chức:'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: organizationSelected,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: [
            // Đảm bảo rằng 'Tất cả' là một DropdownMenuItem<String>
            DropdownMenuItem<String>(
              value: "Tất cả",
              child: Text('Tất cả'),
            ),
            ...units.map((unit) {
              return DropdownMenuItem<String>(
                value: unit['id'].toString(), // Lưu ID của đơn vị như String
                child: Text(unit['name'] ?? 'Không có tên'),
              );
            }).toList(),
          ],
          onChanged: (String? newValue) {
            setState(() {
              organizationSelected = newValue!;  // Lưu giá trị đơn vị đã chọn
              selectedUnitId = newValue;        // Lưu lại ID của đơn vị được chọn
            });
            final provider = Provider.of<EventProvider>(context, listen: false);
            provider.fetchEvents(dateRange.start, dateRange.end, unitId: selectedUnitId); // Gọi API để lấy sự kiện theo bộ lọc
          },
        ),
      ],
    );
  }


  Widget _buildResultCount(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        '$count Kết quả',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDonationList(List<dynamic> events) {
    return Column(
      children: events.map<Widget>((event) {
        var donationUnitDTO = event['donationUnitDTO'];
        var address = donationUnitDTO != null && donationUnitDTO['location'] != null
            ? donationUnitDTO['location']
            : 'Địa chỉ không có';
        var unitPhotoUrl = donationUnitDTO != null && donationUnitDTO['unitPhotoUrl'] != null
            ? donationUnitDTO['unitPhotoUrl']
            : '';

        return _buildDonationCard(
          logo: unitPhotoUrl.isNotEmpty ? unitPhotoUrl : 'CTD',
          title: event['name'] ?? 'Sự kiện không có tên',
          address: address,
          operatingDate: event['eventDate'] ?? 'Không có thông tin',
          donationTime: event['eventStartTime'] ?? 'Không có thời gian',
          registeredCount: event['currentRegistrations'] ?? 0,
          totalSlots: event['maxRegistrations'] ?? 0,
          isAvailable: event['status'] == 'ACTIVE',
        );
      }).toList(),
    );
  }

  Widget _buildDonationCard({
    required String logo,
    required String title,
    required String address,
    required String operatingDate,
    required String donationTime,
    required int registeredCount,
    required int totalSlots,
    required bool isAvailable,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: logo.isNotEmpty
                  ? Image.network(
                logo,
                fit: BoxFit.contain,
              )
                  : const Icon(Icons.image_not_supported),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow('Địa chỉ:', address),
                  _buildInfoRow('Thời gian hoạt động:', operatingDate),
                  _buildInfoRow('Thời gian hiến máu:', donationTime),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.people),
                              const SizedBox(width: 8),
                              Text('Số lượng đăng ký'),
                            ],
                          ),
                          Text(
                            '$registeredCount/$totalSlots người',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: isAvailable ? () {} : null,
                        child: Text(isAvailable ? 'Đăng ký' : 'Hết chỗ'),
                        style: ElevatedButton.styleFrom(
                          // primary: isAvailable ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(value),
      ],
    );
  }
}
