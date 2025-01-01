import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fe_giotmauvang_mobile/screen/User/loginScreen/login.dart';
import 'package:intl/intl.dart'; // Thư viện định dạng ngày tháng

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // Text editing controllers for Form 1
  TextEditingController cccdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Text editing controllers for Form 2
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  DateTime? selectedDate;
  String? selectedGender;
  bool showForm2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Ký Tài Khoản'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              showForm2 ? "Thông Tin Liên Lạc" : "Thông Tin Cá Nhân",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            // Form 1: Thông tin cá nhân
            if (!showForm2) _buildForm1(context),
            // Form 2: Thông tin liên lạc
            if (showForm2) _buildForm2(context),
          ],
        ),
      ),
    );
  }

  Widget _buildForm1(BuildContext context) {
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(cccdController, "CCCD", "Vui lòng nhập CCCD"),
          const SizedBox(height: 16),
          _buildTextField(passwordController, "Mật khẩu", "Vui lòng nhập mật khẩu",
              obscureText: true),
          const SizedBox(height: 16),
          _buildTextField(fullNameController, "Họ và Tên", "Vui lòng nhập họ và tên"),
          const SizedBox(height: 16),
          _buildDatePicker(context),
          const SizedBox(height: 16),
          _buildGenderDropdown(),
          const SizedBox(height: 16),
          _buildTextField(addressController, "Địa chỉ", "Vui lòng nhập địa chỉ"),
          const SizedBox(height: 24),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildForm2(BuildContext context) {
    return Form(
      key: _formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(emailController, "Email", "Vui lòng nhập email"),
          const SizedBox(height: 16),
          _buildTextField(phoneController, "Số điện thoại", "Vui lòng nhập số điện thoại",
              keyboardType: TextInputType.phone),
          const SizedBox(height: 24),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String errorText,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today, color: Colors.blue),
            label: Text(
              selectedDate == null
                  ? "Chọn ngày sinh"
                  : "Ngày sinh: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}",
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedGender,
      items: ['Nam', 'Nữ', 'Khác']
          .map((gender) => DropdownMenuItem(
        value: gender,
        child: Text(gender),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
      decoration: const InputDecoration(
        labelText: "Giới tính",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null) {
          return "Vui lòng chọn giới tính";
        }
        return null;
      },
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey1.currentState!.validate()) {
          setState(() {
            showForm2 = true;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      child: const Text("Chuyển Tiếp"),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey2.currentState!.validate()) {
          Fluttertoast.showToast(msg: "Đăng ký thành công!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      child: const Text("Đăng Ký"),
    );
  }
}
