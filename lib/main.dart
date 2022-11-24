import 'package:flutter/material.dart';
import 'hasilAnalisa.dart';
import 'informasiMelanoma.dart';
import 'kontakDokter.dart';
import 'mainScreen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MainScreen(),
        '/hasilAnalisa': (context) => HasilAnalisa(),
        '/informasiMelanoma': (context) => InformasiMelanoma(),
        '/kontakDokter': (context) => KontakDokter(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xffD21F3C)),
      ),
    );
  }
}
