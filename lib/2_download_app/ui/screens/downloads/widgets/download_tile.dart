import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO
  String getCurrentSize() {
    double currentSize =
        (controller.progress / 100) * controller.ressource.size;
    return currentSize.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    // TODO
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.status == DownloadStatus.notDownloaded) {
          return ListTile(
            title: Text(controller.ressource.name),
            subtitle: Text(""),
            trailing: GestureDetector(
              onTap: () {
                controller.startDownload();
              },
              child: Icon(Icons.download),
            ),
          );
        }
        if (controller.status == DownloadStatus.downloading) {
          return ListTile(
            title: Text(controller.ressource.name),
            subtitle: Text(
              "${controller.progress.toString()} % completed - ${getCurrentSize()} of ${controller.ressource.size} MB",
            ),
            trailing: GestureDetector(
              onTap: () {
                controller.startDownload();
              },
              child: Icon(Icons.downloading),
            ),
          );
        }
        if (controller.status == DownloadStatus.downloaded) {
          return ListTile(
            title: Text(controller.ressource.name),
            subtitle: Text(
              "${controller.progress.toString()} % completed - ${getCurrentSize()} of ${controller.ressource.size} MB",
            ),
            trailing: Icon(Icons.download_done_rounded),
          );
        }
        return Placeholder();
      },
    );
  }
}
