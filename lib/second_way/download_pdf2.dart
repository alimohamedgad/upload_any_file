import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DownLoadPdfScreen extends StatefulWidget {
  DownLoadPdfScreen();

  @override
  State<DownLoadPdfScreen> createState() => _DownLoadPdfScreenState();
}

class _DownLoadPdfScreenState extends State<DownLoadPdfScreen> {
  final name = TextEditingController();
  // final pdfPath = "file:///E:/CV/cv%20Ali%20Mohamed%20Gad.pdf";

  var prograss = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                hintText: 'Enter Url Here...',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
               await FileDownloader.downloadFile(
                  url: name.text,
                  onDownloadError: (e) {
                    print('Erro $e');
                  },
                  onDownloadCompleted: (path) {
                    final File file = File(path);
                    print(file);
                    name.clear();
                  },
                  onProgress: (fileName, progress) {
                    setState(() {
                      prograss = progress;
                    });
                  },
                );
                
              },
              child: const Text('Download PDF'),
            ),
            Container(
              height: 20,
              width: prograss * 4,
              color: Colors.red,
            ),
            Text(
              '$prograss %',
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
