import 'dart:async';
import 'dart:convert';
import 'package:fit_x/core/services/hive_db_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

final _hivedb = HiveDbHelper();

class BleManager extends ChangeNotifier {
  ValueNotifier<bool> startMonitoringNotifier = ValueNotifier(false);
  ValueNotifier<bool> ackNotifier = ValueNotifier(false);
  ValueNotifier<DiscoveredDevice?> myDevice = ValueNotifier(null);
  ValueNotifier<bool> isScanningRunning = ValueNotifier(false);
  ValueNotifier<bool> isDeviceConnected = ValueNotifier(false);
  ValueNotifier<ConnectionStateUpdate?> connectionState = ValueNotifier(null);
  ValueNotifier<BleStatus> bleStatus = ValueNotifier(BleStatus.unknown);

  static final BleManager _instance = BleManager._internal();
  factory BleManager() => _instance;
  BleManager._internal();

  final FlutterReactiveBle _ble = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> _scanSub;
  late StreamSubscription<ConnectionStateUpdate> _connSub;
  List<DiscoveredService> _services = [];

  Future<void> initialize() async {
    _ble.statusStream.listen((status) {
      bleStatus.value = status;
      notifyListeners();
      print("[BLE] Status changed: $status");

      if (status == BleStatus.ready) {
        startScanIfNotScanning();
      } else {
        stopScan();
        myDevice.value = null;
        isDeviceConnected.value = false;
      }
    });
    await requestPermissions();
  }

  Future<void> requestPermissions() async {
    final statuses =
        await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.locationWhenInUse,
        ].request();

    if (statuses.values.any((status) => !status.isGranted)) {
      print('[BLE] Required permissions not granted.');
    }
  }

  void startScanIfNotScanning() async {
    print('inside scanning');
    await requestPermissions();
    print('permission allowed');
    if (!isScanningRunning.value && !isDeviceConnected.value) {
      isScanningRunning.value = true;
      notifyListeners();
      print('inside scanning function');

      _scanSub = _ble
          .scanForDevices(withServices: [], scanMode: ScanMode.lowLatency)
          .listen(
            (device) {
              print('inside scanning function');
              print('[BLE] Discovered: ${device.name}');
              if (device.name == 'H59_B304') {
                print('[BLE] Found matching device: ${device.name}');
                myDevice.value = device;
                stopScan();
                connectToDevice(device);
              }
            },
            onError: (e) {
              print('[BLE] Scan error: $e');
              isScanningRunning.value = false;
              notifyListeners();
            },
          );
    }
  }

  void stopScan() {
    _scanSub.cancel();
    isScanningRunning.value = false;
    notifyListeners();
  }

  void connectToDevice(DiscoveredDevice device) {
    _connSub = _ble
        .connectToDevice(id: device.id)
        .listen(
          (update) {
            connectionState.value = update;
            notifyListeners();
            if (update.connectionState == DeviceConnectionState.connected) {
              print('[BLE] Connected to ${device.name}');
              isDeviceConnected.value = true;
              _hivedb.putBool('DeviceSetup', true);
              discoverServices(device.id);
            } else if (update.connectionState ==
                DeviceConnectionState.disconnected) {
              print('[BLE] Disconnected');
              isDeviceConnected.value = false;
              myDevice.value = null;
              notifyListeners();
              startScanIfNotScanning();
            }
          },
          onError: (e) {
            print('[BLE] Connection error: $e');
          },
        );
  }

  Future<void> discoverServices(String deviceId) async {
    try {
      _services = await _ble.discoverServices(deviceId);
      print('[BLE] Services: $_services');
      if (_services.isNotEmpty) {
        readOrWriteCharacteristic(
          serviceUuid: BleDeviceInfo.serviceUuid,
          characteristicUuid: BleDeviceInfo.characteristicUuid,
          text: BleDeviceInfo.connectionCMD,
          isRead: true,
        );
      }
    } catch (e) {
      print('[BLE] Service discovery failed: $e');
    }
  }

  Future<void> readOrWriteCharacteristic({
    required Uuid serviceUuid,
    required Uuid characteristicUuid,
    required String text,
    required bool isRead,
  }) async {
    try {
      final characteristic = QualifiedCharacteristic(
        serviceId: serviceUuid,
        characteristicId: characteristicUuid,
        deviceId: myDevice.value!.id,
      );
      await _ble.writeCharacteristicWithResponse(
        characteristic,
        value: utf8.encode(text),
      );
      if (isRead) {
        final data = await _ble.readCharacteristic(characteristic);
        final decodedData = utf8.decode(data);
        print('[BLE] DATA RECEIVED: $decodedData');
        ackNotifier.value = decodedData.contains('ACK');
        notifyListeners();
      }
    } catch (e) {
      print('[BLE] Error read/write characteristic: $e');
    }
  }

  Future<void> disconnectDevice() async {
    await _connSub.cancel();
    isDeviceConnected.value = false;
    myDevice.value = null;
    notifyListeners();
    startScanIfNotScanning();
  }

  Future<void> forgetDevice() async {
    await disconnectDevice();

    print('[BLE] Forgot device (disconnect only)');
  }

  @override
  void dispose() {
    _scanSub.cancel();
    _connSub.cancel();
    super.dispose();
  }
}

class BleDeviceInfo {
  static final serviceUuid = Uuid.parse("YOUR-SERVICE-UUID");
  static final characteristicUuid = Uuid.parse("YOUR-CHARACTERISTIC-UUID");
  static final connectionCMD = "CMD";
}
