import 'dart:async';
import 'package:fit_x/core/provider/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otp = '';
  bool enableContinue = false;
  int secondsRemaining = 59;
  late Timer timer;
  final RoundedLoadingButtonController _otpBtnController = RoundedLoadingButtonController();


  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (secondsRemaining == 0) {
        t.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const SizedBox(height: 80),
                SvgPicture.asset(
                  'assets/logo/light_logo.svg',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 60),
                const Text(
                  "OTP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
               
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "We've sent a 6-digit code to your mobile number.\nPlease enter it below to continue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
                    height: 1.4,
               
                  ),
                ),
                const SizedBox(height: 40),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  cursorColor: Colors.white,
                  animationType: AnimationType.scale,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    errorBorderColor: Colors.red,
                    activeFillColor: Colors.white.withOpacity(0.08),
                    selectedFillColor: Colors.white.withOpacity(0.05),
                    inactiveFillColor: Colors.white.withOpacity(0.05),
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    selectedColor: Colors.white.withOpacity(0.2),
                    borderWidth: 2,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  onChanged: (value) {
                    setState(() {
                      otp = value;
                      enableContinue = value.length == 6;
                    });
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: RoundedLoadingButton(
                    controller: _otpBtnController,
                    borderRadius: 12,
                    color: enableContinue ? Colors.white : Colors.white.withOpacity(0.1),
                    successColor: Colors.green,
                    errorColor: Colors.red,
                    failedIcon: Icons.close,
                    successIcon: Icons.check,
                    valueColor: enableContinue ? Colors.black : Colors.grey.shade500,
                    onPressed: enableContinue

                        ? () {
                      final authProvider = Provider.of<AuthProvider>(context, listen: false);
                      authProvider.verifyOtp(
                        smsCode: otp,
                        onSuccess: () {
                          _otpBtnController.success();
                          Future.delayed(Duration(seconds: 2),() {
                            context.go('/setupDemographics'); // Navigate after success
                          });
                        },
                        onError: (error) {
                          _otpBtnController.error();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error),
                              backgroundColor: Colors.red,
                            ),
                          );
                          Future.delayed(const Duration(seconds: 2), () {
                            _otpBtnController.reset();
                          });
                        },
                      );
                    }
                        : null,
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                   
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Text(
                  "Didn’t get it? You can resend the code in",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
               
                  ),
                ),
                const SizedBox(height: 6),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   "00:${secondsRemaining.toString().padLeft(2, '0')}",
                   style:  TextStyle(
                     color: enableContinue ? Colors.white.withOpacity(0.85) : Colors.white.withOpacity(0.4),
                     fontSize: 18,
                     fontWeight: FontWeight.w600,
                     letterSpacing: 1.2,
                
                   ),
                 ),
                 const SizedBox(width: 15),
                 Visibility(
                   visible: secondsRemaining == 0,
                   child: ElevatedButton(
                     onPressed: enableContinue
                         ? () {
                       authProvider.verifyOtp(
                         smsCode: otp,
                         onSuccess: () {
                           context.go('/setupDemographics'); // Update as needed
                         },
                         onError: (error) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               content: Text(error),
                               backgroundColor: Colors.red,
                             ),
                           );
                         },
                       );
                     }
                         : null,

                      child: Text("Resend OTP",style: TextStyle(color: Colors.black,fontFamily: "Garet",),)),
                 )
               ],
             ),
                // Spacer(),
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
