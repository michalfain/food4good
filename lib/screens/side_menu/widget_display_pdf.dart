import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/widgets/main_logo_widget.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:food4good_app/utils/constants.dart';

class WidgetDisplayPdf extends StatefulWidget {
  static const String SCREEN_NAME = 'UserTermsScreen';
  final String pdfUrl;
  final String headline;

  WidgetDisplayPdf({Key key, this.pdfUrl, this.headline}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WidgetDisplayPdfState();
  }
}

class _WidgetDisplayPdfState extends State<WidgetDisplayPdf> {
  @override
  Widget build(BuildContext context) {
    double sizeOFPDF = MediaQuery.of(context).size.height - 100.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.headline,
          style: TextStyle(
              fontSize: Constants.SCREEN_APPBAR_FONT,
              color: Constants.SCREEN_APPBAR_COLOR),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.grey),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<String>(
              future: loadPdf(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: sizeOFPDF,
                        child: PdfViewer(
                          filePath: snapshot.data,
                        ),
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Future<Uint8List> fetchPost() async {
    final response = await http.get(widget.pdfUrl);
    final responseJson = response.bodyBytes;

    return responseJson;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<bool> existsFile() async {
    final file = await _localFile;
    return file.exists();
  }

  Future<String> loadPdf() async {
    String path;
    await writeCounter(await fetchPost());
    await existsFile();
    path = (await _localFile).path;

    if (mounted) return path;
  }
}
