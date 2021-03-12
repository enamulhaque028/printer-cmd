// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Printer"),
      ),
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
            child: Text('Print'),
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrintPage(),
                ),
              );
            }),
      ),
    );
  }
}

class PrintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Printer"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: Colors.green,
          child: Center(
            child: Container(
              height: 600,
              width: 600,
              child: PdfPreview(
                build: (format) => _generatePdf(),
                //allowSharing: false,
                // maxPageWidth: 400,
                onPrinted: (context) {
                  print('Printed successfuly!');
                },
                onError: (context) {
                  return Text('Sorry! can\'t be displayed');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf() async {
    final String title = 'Great!!! Printing is working';
    final pdf = pw.Document(
      title: "Ati Limited",
      author: "Anisul Islam",
      creator: "Enamul Haque",
      subject: "Billing Cost",
    );
    final image = await imageFromAssetBundle('assets/images/scan.png');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: pw.Column(children: [
              pw.Container(child: pw.Text(title)),
              pw.Container(child: pw.Text(title)),
              pw.Container(child: pw.Image(image)),
            ]),
          );
        },
      ),
    );

    return pdf.save();
  }

  // Future<Uint8List> _generatePdfdoc() async {
  //   final pdf = await rootBundle.load('assets/images/google.pdf');
  //   //await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());

  //   return pdf.buffer.asUint8List();
  // }
}
