import 'package:aflink/routes/routes.dart';
import 'package:aflink/screen/signup/interest_screen.dart';
import 'package:aflink/screen/signup/upload_media_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Mulish'
      ),
      home:  const UploadMediaScreen(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
