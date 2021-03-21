import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class IMEIHelper {
  // String platformIMEI = 'Unknown';
  // String uniqueId = "Unknown";

  // Platform messages are asynchronous, so we initialize in an async method.
  static Future<String> getEncryptedIMEI() async {
    String platformImei;
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      List<String> multiImei = await ImeiPlugin.getImeiMulti();
      print(multiImei);
      idunique = await ImeiPlugin.getId();
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
      return null;
    }
    log("{'IMEI': $platformImei, 'uid': $idunique}");
    var bytes = utf8.encode(platformImei); // data being hashed

    var digest = sha1.convert(bytes);

    log("Digest as bytes: ${digest.bytes}");
    log("Digest as hex string: $digest");
    return digest.toString();
  }
}
