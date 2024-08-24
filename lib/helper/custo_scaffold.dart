import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:miss_planet/util/color_resources.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? floatingActionButton;

  CustomScaffold({required this.body, this.appBar, this.floatingActionButton});

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  final Connectivity _connectivity = Connectivity();

  bool _hasConnection = true;
  bool _isLoading = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      bool newConnectionStatus = result != ConnectivityResult.none;
      if (newConnectionStatus != _hasConnection) {
        setState(() {
          _hasConnection = newConnectionStatus;
        });
        if (_hasConnection) {
          _reloadData();
        }
      }
    });
  }

  Future<void> _checkConnection() async {
    bool hasConnection = await _connectivity.checkConnectivity().then((value) => value != ConnectivityResult.none);
    if (mounted) {
      setState(() {
        _hasConnection = hasConnection;
      });
    }
    if (_hasConnection) {
      _reloadData();
    }
  }

  Future<void> _reloadData() async {
    try {
      // Before performing any async operation, check if the widget is still mounted
      if (!mounted) return;

      setState(() {
        _isLoading = true;
      });

      print("Reloading data...");
      // Simulate a network call or data fetch
      await Future.delayed(Duration(seconds: 5));
      print("Data reloaded.");

      // Again, check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error reloading data: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // Set the design size according to your UI design
      builder: (context, child) {
        return Scaffold(
          backgroundColor: ColorResources.defaultBackground,
          appBar: widget.appBar,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: widget.body,
          ),
          floatingActionButton: widget.floatingActionButton,
        );
      },
    );
  }
}