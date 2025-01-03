import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/User.dart';
import '../../../models/UserInfo.dart';
import '../../../providers/RegisterProvider.dart';

class Register extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<Register> {
  final _formKey1 = GlobalKey<FormState>(); // Form 1 key
  final _formKey2 = GlobalKey<FormState>(); // Form 2 key
  final _cccdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedSex = 'Nam';

  bool _isForm1 = true; // Biến trạng thái để kiểm tra form nào đang hiển thị

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng ký tài khoản')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: _isForm1 ? _buildForm1() : _buildForm2(),
        ),
      ),
    );
  }

  Widget _buildForm1() {
    return Form(
      key: _formKey1,
      child: Column(
        children: [
          TextFormField(
            controller: _cccdController,
            decoration: InputDecoration(labelText: 'CCCD'),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Vui lòng nhập CCCD';
              if (value!.length != 12) return 'CCCD phải có 12 số';
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Mật khẩu'),
            obscureText: true,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Vui lòng nhập mật khẩu';
              if (value!.length < 6) return 'Mật khẩu phải có ít nhất 6 ký tự';
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Số điện thoại'),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Vui lòng nhập số điện thoại';
              if (!RegExp(r'^\d{10}$').hasMatch(value!))
                return 'Số điện thoại không hợp lệ';
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Vui lòng nhập email';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!))
                return 'Email không hợp lệ';
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: ()async  {
              if (_formKey1.currentState!.validate()) {
                final user = User(
                  cccd: _cccdController.text,
                  password: _passwordController.text,
                  phone: _phoneController.text,
                  email: _emailController.text,
                  roleId: 2,
                );

                final success = await context.read<RegisterProvider>().submitUserData(user);

                if (success) {
                  setState(() {
                    _isForm1 = false; // Chuyển sang form 2
                  });
                }
              }
            },
            child: Text('Tiếp tục'),
          ),
        ],
      ),
    );
  }

  Widget _buildForm2() {
    return Form(
      key: _formKey2,
      child: Column(
        children: [
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(labelText: 'Họ và tên'),
            validator: (value) =>
            value?.isEmpty ?? true ? 'Vui lòng nhập họ tên' : null,
          ),
          ListTile(
            title: Text('Ngày sinh'),
            subtitle: Text(_selectedDate?.toString().split(' ')[0] ?? 'Chọn ngày sinh'),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() => _selectedDate = date);
              }
            },
          ),
          DropdownButtonFormField<String>(
            value: _selectedSex,
            items: ['Nam', 'Nữ'].map((sex) => DropdownMenuItem(
              value: sex,
              child: Text(sex),
            )).toList(),
            onChanged: (value) => setState(() => _selectedSex = value!),
            decoration: InputDecoration(labelText: 'Giới tính'),
          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Địa chỉ'),
            validator: (value) =>
            value?.isEmpty ?? true ? 'Vui lòng nhập địa chỉ' : null,
          ),
          SizedBox(height: 20),
          Consumer<RegisterProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () async {
                  String formatDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
                  if (_formKey2.currentState!.validate() && _selectedDate != null) {
                    final userInfo = UserInfo(
                      fullName: _fullNameController.text,
                      dob:  formatDate,
                      sex: _selectedSex,
                      address: _addressController.text,
                      id: -1,
                    );

                    final success = await provider.submitUserInfo(userInfo);
                    if (success) {
                      // Hiển thị thông báo thành công
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đăng ký thành công!'),
                        ),
                      );
                      // Chuyển hướng đến trang login
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  }
                },
                child: Text('Hoàn tất đăng ký'),
              );
            },
          ),
        ],
      ),
    );
  }
}
