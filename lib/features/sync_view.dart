import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/features/main_screen.dart';
import 'package:meine_wunschliste/services/sync_service/sync_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SyncView extends StatefulWidget {
   SyncView({super.key});

  final SyncService syncService = GetIt.I.get<SyncService>();

  @override
  _SyncViewState createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  @override
  void initState() {
    super.initState();
    _checkConnectivityAndSync();
  }

  Future<void> _checkConnectivityAndSync() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      await widget.syncService.updateDataBetweenFirebaseAndRealm();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEA434),
        title: const Text('Syncing Data'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
