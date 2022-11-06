import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/services/services_locator.dart';

void main() {
  ServicesLocator().init();
  runApp(MyApp());
}
