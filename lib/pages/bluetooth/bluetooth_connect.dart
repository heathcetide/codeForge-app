import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterBlueApp extends StatefulWidget {
  const FlutterBlueApp({Key? key}) : super(key: key);

  @override
  State<FlutterBlueApp> createState() => _FlutterBlueAppState();
}

class _FlutterBlueAppState extends State<FlutterBlueApp> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = _adapterState == BluetoothAdapterState.on
        ? const ScanScreen()
        : BluetoothOffScreen(adapterState: _adapterState);

    return MaterialApp(
      color: Colors.lightBlue,
      home: screen,
      navigatorObservers: [BluetoothAdapterStateObserver()],
    );
  }
}

class BluetoothAdapterStateObserver extends NavigatorObserver {
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/DeviceScreen') {
      _adapterStateSubscription ??= FlutterBluePlus.adapterState.listen((state) {
        if (state != BluetoothAdapterState.on) {
          navigator?.pop();
        }
      });
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _adapterStateSubscription?.cancel();
    _adapterStateSubscription = null;
  }
}

class BluetoothOffScreen extends StatelessWidget {
  final BluetoothAdapterState adapterState;

  const BluetoothOffScreen({Key? key, required this.adapterState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth Off")),
      body: Center(
        child: Text(
          'Bluetooth is turned off. Please enable Bluetooth to continue.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late StreamSubscription<List<ScanResult>> _scanSubscription;
  BluetoothDevice? _connectedDevice;
  bool _isScanning = false;
  Set<BluetoothDevice> _devices = {}; // Store unique devices

  String? _filterType; // Filter by device name or type

  @override
  void initState() {
    super.initState();
    _checkBluetoothStatus();
    _checkPermissions();
  }

  Future<void> _checkBluetoothStatus() async {
    bool isBluetoothOn = await FlutterBluePlus.isOn;
    if (!isBluetoothOn) {
      print('Bluetooth is turned off');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bluetooth is Off'),
            content: Text('Please enable Bluetooth to continue scanning for devices.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _checkPermissions() async {
    final permissionStatus = await Permission.bluetoothScan.request();
    final locationPermissionStatus = await Permission.locationWhenInUse.request();
    if (permissionStatus.isGranted && locationPermissionStatus.isGranted) {
      print('Bluetooth scan and location permission granted');
    } else {
      print('Bluetooth or location permission is required');
    }
  }

  void _startScan() {
    FlutterBluePlus.startScan();
    setState(() {
      _isScanning = true;
    });

    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      print('Found ${results.length} devices');
      results.forEach((scanResult) {
        print('Device found: ${scanResult.device.name}, ID: ${scanResult.device.id}');

        // 设备的广告数据可以用来过滤设备
        // 例如过滤支持特定服务的设备（通过 UUID 判断）
        if (_filterType == null || _shouldIncludeDevice(scanResult)) {
          setState(() {
            _devices.add(scanResult.device); // Add unique devices
          });
        }
      });
    });
  }

  bool _shouldIncludeDevice(ScanResult scanResult) {
    // 假设你想要根据设备广告数据中的服务 UUID 进行过滤
    // 你可以通过 scanResult.advertisementData 里的 services 字段来获得设备的服务列表
    final services = scanResult.advertisementData.serviceUuids;

    // 例如，过滤出包含特定服务 UUID 的设备
    if (services.contains('YOUR_SERVICE_UUID')) {
      return true; // 包含该服务的设备
    }

    // 可以根据其他条件来进行更多过滤
    return false;
  }

  // Stop scanning when the user clicks "Stop Scan" button
  void _stopScan() {
    FlutterBluePlus.stopScan();
    setState(() {
      _isScanning = false;
    });
  }

  @override
  void dispose() {
    _scanSubscription.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      setState(() {
        _connectedDevice = device;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Connected to ${device.name}')));
    } catch (e) {
      print('Error connecting to device: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to connect')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanning for Devices")),
      body: Column(
        children: [
          // Filter dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: _filterType,
              hint: Text('Select Device Type'),
              items: ['Device 1', 'Device 2', 'Device 3'] // Add your own device types
                  .map((type) => DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _filterType = value;
                  _devices.clear(); // Clear devices when filtering changes
                });
                _startScan(); // Restart scan with new filter
              },
            ),
          ),
          // Start and stop scanning buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _isScanning ? null : _startScan,
              child: Text(_isScanning ? 'Scanning...' : 'Start Scan'),
            ),
          ),
          if (_isScanning)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _stopScan,
                child: const Text('Stop Scan'),
              ),
            ),
          // Display devices
          Expanded(
            child: ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices.elementAt(index);
                bool isConnected = _connectedDevice?.id == device.id;

                return ListTile(
                  title: Text(device.name.isNotEmpty ? device.name : 'Unnamed Device'),
                  subtitle: Text(device.id.toString()),
                  trailing: ElevatedButton(
                    onPressed: isConnected ? null : () => _connectToDevice(device),
                    child: Text(isConnected ? 'Connected' : 'Connect'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}