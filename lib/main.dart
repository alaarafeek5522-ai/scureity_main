import 'package:flutter/material.dart';
import 'utils/remote_guard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RemoteGuard.verify();
  runApp(const SecureApp());
}

class SecureApp extends StatelessWidget {
  const SecureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Security Main',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text(
            '✅ Signature Verified',
            style: TextStyle(fontSize: 22, color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }
}
