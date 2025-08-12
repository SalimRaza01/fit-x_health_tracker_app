import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fit_x/core/services/ble_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:go_router/go_router.dart';

class BluetoothStatusScreen extends StatefulWidget {
  const BluetoothStatusScreen({super.key});

  @override
  State<BluetoothStatusScreen> createState() => _BluetoothStatusScreenState();
}

class _BluetoothStatusScreenState extends State<BluetoothStatusScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blurAnimation;
  late Animation<double> _spreadAnimation;
  final BleManager _bleManager = BleManager();

  bool testingBluetoothON = false;
  bool deviceFind = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _blurAnimation = Tween<double>(
      begin: 10,
      end: 150,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _spreadAnimation = Tween<double>(
      begin: 1,
      end: 50,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _bleManager.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildBluetoothIcon() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1E262C),
              border: Border.all(color: AppColor.borderColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color:AppColor.lightGrey,
                  blurRadius: _blurAnimation.value,
                  spreadRadius: _spreadAnimation.value,
                ),
              ],
            ),
            child: const Icon(
              CupertinoIcons.bluetooth,
              size: 55,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchfitx() {
    return Image.asset(
      'assets/logo/pairingBG.png',
      fit: BoxFit.fitWidth,
      width: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BleStatus>(
      valueListenable: _bleManager.bleStatus,
      builder: (context, status, _) {
        return ValueListenableBuilder(
          valueListenable: _bleManager.myDevice,
          builder: (context, myDevice, _) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0A0F13), Color(0xFF1B232B)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => context.pop(),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: () {
                              if (status != BleStatus.ready) {
                                // Bluetooth is OFF
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.bluetooth_disabled,
                                      size: 60,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Bluetooth is Off',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Please turn on Bluetooth to connect to your device.',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              } else if (myDevice != null) {
                                // Bluetooth ON but no device found
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildBluetoothIcon(),
                                    const SizedBox(height: 20),
                                    const Text(
                                      'Searching for AEROFIT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Tap the device to connect.\nMake sure the band LED pulses green (pairing mode).',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              } else {
                                // Device found
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildBluetoothIcon(),
                                    const SizedBox(height: 50),
                                    InkWell(
                                      onTap: () {
                                        // _bleManager.connectToDevice(myDevice);
                                              context.push('/connectionProgress');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blueGrey,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: const Color.fromARGB(
                                            83,
                                            0,
                                            0,
                                            0,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/watch_icon.png',
                                              height: 30,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              // myDevice.name.isEmpty
                                              //     ? 'Unknown Device'
                                              //     : myDevice.name,
                                              'FIT-X (H59_B304)',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }(),
                          ),
                          Visibility(
                            visible: myDevice != null,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white10,
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white38),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                if (status == BleStatus.ready) {
                                  context.push('/connectionProgress');
                                  _bleManager.startScanIfNotScanning();
                                } else {
                                  await _bleManager.requestPermissions();
                                       context.push('/connectionProgress');
                                }
                              },
                              child: Text(
                                (status != BleStatus.ready)
                                    ? 'TURN ON BLUETOOTH'
                                    : 'SEARCH AGAIN',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
