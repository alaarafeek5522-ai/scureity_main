import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RemoteGuard {
  static const _channel = MethodChannel('com.alaa.scureity_main/sig');

  static const _remoteUrl =
      'https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/main/valid_signatures.json';

  static Future<void> verify() async {
    try {
      // 1. جيب توقيع التطبيق
      final String rawSig = await _channel.invokeMethod('getSignature');
      final actualHash = sha256.convert(utf8.encode(rawSig)).toString();

      // 2. جيب القائمة من GitHub
      final res = await http.get(Uri.parse(_remoteUrl))
          .timeout(const Duration(seconds: 10));

      if (res.statusCode != 200) _kill();

      final List validSigs = jsonDecode(res.body)['signatures'];

      // 3. قارن
      if (!validSigs.contains(actualHash)) _kill();

    } catch (_) {
      _kill();
    }
  }

  static void _kill() {
    throw StateError('');
  }
}
