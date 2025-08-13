
import 'package:fit_x/core/constants/Constants.dart';
import 'package:fit_x/core/constants/GlobalMethods.dart';
import 'package:fit_x/core/provider/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool enableLoginButton =  false;
  String phoneNumber = "";
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    enableLoginButton = false;
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1F2A33), // bluish-gray
              Color(0xFF0B0D0F), // dark base
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Icon(
                      Icons.help_outline,
                      color: Colors.white70,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Center(
                    child:getSvgIcon("assets/logo/light_logo.svg", width: 100,height: 100,fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "Enter your phone number to continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
         
                    letterSpacing: 0.5,
            
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PHONE",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                 
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                IntlPhoneField(
                  showDropdownIcon: true,
                  initialCountryCode: 'IN',
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.white,
                  onChanged: (phone) {
                    setState(() {
                      phoneNumber = phone.number;
                      enableLoginButton = phone.number.length == 10;
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.05),
                    filled: true,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  dropdownTextStyle: const TextStyle(color: Colors.white),
                  dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: RoundedLoadingButton(
                    controller: _btnController,
                  color: Colors.white,
                  successColor: Colors.green,
                    borderRadius: 12,
                    elevation: 0,
                    disabledColor: Colors.grey,
                    errorColor: Colors.red,
                    failedIcon: Icons.close,
                    successIcon: Icons.check,
                    completionDuration: Duration(seconds: 1),
                    valueColor: enableLoginButton ? Colors.black : Colors.grey.shade200,
                    onPressed: enableLoginButton
                        ? () {
                      final fullPhone = "+91$phoneNumber";
                      authProvider.sendOtp(
                        phoneNumber: fullPhone,
                        onCodeSent: () {
                          _btnController.success();
                        Future.delayed(Duration(seconds: 1),(){
                          context.go(Constants.OtpScreen);
                        });
                        },
                        onError: (error) {
                          _btnController.error();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $error")),
                          );
                          Future.delayed(const Duration(seconds: 1), () {
                            _btnController.reset();
                          });
                        },
                      );
                    }
                        : null,
                    child:  Text(
                      enableLoginButton ? "Continue" : "LOGIN",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: enableLoginButton ? Colors.black : Colors.grey,
                   
                      ),
                    ),
                  ),
                ),


                const Spacer(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text("© 2025 Vytalix Pvt. Ltd. All rights reserved.",style: TextStyle(color: Colors.grey),)
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
