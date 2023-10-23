import 'package:apicepviaback4app/my_app.dart';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  // seta os types do flutter
  WidgetsFlutterBinding.ensureInitialized();

  // var documentsDirectory =
  //     await path_provider.getApplicationDocumentsDirectory();

  runApp(const MyApp());
}
