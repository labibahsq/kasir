import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_9/services/user.dart';
import 'package:flutter_application_9/widgets/alert.dart';
import 'package:intl/intl.dart';

class Registeruserview extends StatefulWidget {
  const Registeruserview({super.key});

  @override
  State<Registeruserview> createState() => _RegisteruserviewState();
}

class _RegisteruserviewState extends State<Registeruserview> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController birthday = TextEditingController();
  List roleChoice = ["admin", "user"];
  String? role;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFE9),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),

              Column(
                children: [Image.asset('assets/logonama.png', height: 250)],
              ),

              const SizedBox(height: 40),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    _inputField("Nama", name),
                    const SizedBox(height: 12),

                    _inputField("Email", email),
                    const SizedBox(height: 12),

                    DropdownButtonFormField(
                      value: role,
                      decoration: _inputDecoration("Role"),
                      items: roleChoice.map((r) {
                        return DropdownMenuItem(value: r, child: Text(r));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          role = value.toString();
                        });
                      },
                      hint: Text("Pilih role"),
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Role harus dipilih';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: password,
                      obscureText: !isPasswordVisible,
                      decoration: _inputDecoration("Password").copyWith(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 12),

                    _inputField("Address", address),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: birthday,
                      readOnly: true,
                      decoration: _inputDecoration(
                        "Birthday",
                      ).copyWith(suffixIcon: Icon(Icons.calendar_today)),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          String formattedDate = DateFormat(
                            'dd/MM/yyy',
                          ).format(pickedDate);
                          setState(() {
                            birthday.text = formattedDate;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Birthday harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var data = {
                              "name": name.text,
                              "email": email.text,
                              "role": role,
                              "password": password.text,
                              "address": address.text,
                              "birthday": birthday.text,
                            };
                            var result = await user.registerUser(data);
                            if (result.status == true) {
                              name.clear();
                              email.clear();
                              password.clear();
                              address.clear();
                              birthday.clear();
                              setState(() {
                                role = null;
                              });
                              alertMessage().showAlert(
                                context,
                                result.message,
                                true,
                              );

                              Future.delayed(const Duration(seconds: 2), () {
                                if (!mounted) return;
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                );
                              });
                            } else {
                              alertMessage().showAlert(
                                context,
                                result.message,
                                false,
                              );
                            }
                          }
                        },

                        child: Text(
                          "Register",
                          style: const TextStyle(
                            color: const Color(0xFFFEFDF2),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(
    String hint, {
    IconData? icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(icon, color: const Color(0xFFC5A059))
          : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF9F7F0), // warna kotak lembut
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }
}
