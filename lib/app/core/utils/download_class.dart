import 'dart:developer';

import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {
    log("Download status: $status");
    log("Download progress: $progress");
  }
}
