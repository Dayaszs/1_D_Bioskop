import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import qr_flutter
import 'package:flutter_application_1/data/ticket.dart'; // Import the ticket.dart file

class TicketPdfPage extends StatelessWidget {
  final Ticket ticket;

  TicketPdfPage({required this.ticket});

  // Generate PDF document
  Future<pw.Document> generatePdf() async {
    final pdf = pw.Document();

    // Load the image from network
    final image = await loadImage('${ticket.picture}'.isNotEmpty ? '${ticket.picture}' : 'https://via.placeholder.com/200x300');

    // Generate QR code image
    final qrCodeImage = await _generateQrCode(ticket.id.toString());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Cinema Header
              pw.Container(
                alignment: pw.Alignment.center,
                margin: pw.EdgeInsets.only(bottom: 20),
                child: pw.Text(
                  'ATMA Cinema',
                  style: pw.TextStyle(fontSize: 36, fontWeight: pw.FontWeight.bold, color: PdfColors.yellow400),
                ),
              ),
              
              // Movie Poster
              pw.Center(
                child: pw.Image(image, width: 200, height: 300),
              ),
              
              pw.SizedBox(height: 20),
              
              // Movie Details Section
              pw.Text(
                '${ticket.judul}'.isNotEmpty ? '${ticket.judul}' : 'Dummy Movie Title',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                '${ticket.genre}'.isNotEmpty ? '${ticket.genre}' : 'Genre: Drama, Action',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.grey),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Location: ATMA Cinema Pakuwon Jogja',
                style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
              ),
              pw.Text(
                'Date: 14 October 2024, 13:00 WIB',
                style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
              ),
              pw.SizedBox(height: 30),
              // QR Code for Ticket ID
              pw.Center(
                child: pw.Image(
                  qrCodeImage,
                  width: 100,
                  height: 100,
                ),
              ),
              pw.SizedBox(height: 30),

              pw.Center(
                child: pw.Text("Ticket ID: " + ticket.id.toString())
              ),
              
              pw.SizedBox(height: 30),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                'Thank you for choosing ATMA Cinema!',
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.black),
                textAlign: pw.TextAlign.center,
              ),
              
            ],
          );
        },
      ),
    );

    return pdf;
  }

  // Load image from network and convert it to PdfImage
  Future<pw.ImageProvider> loadImage(String imageUrl) async {
    final ByteData data = await NetworkAssetBundle(Uri.parse(imageUrl)).load('');
    final Uint8List bytes = data.buffer.asUint8List();
    return pw.MemoryImage(bytes);
  }

  // Generate QR Code and return it as a PdfImage
  Future<pw.ImageProvider> _generateQrCode(String ticketId) async {
    // Create a QR code data object
    final qr = QrCode(
      4, // version (this is a fixed size, you can adjust for your needs)
      QrErrorCorrectLevel.L,
    );

    // Add the ticket ID as data
    qr.addData(ticketId);

    // Generate a QR painter
    final qrPainter = QrPainter(
      data: ticketId,  // The data for the QR code (ticket ID)
      version: 4,  // Version of the QR code (size of the matrix)
      errorCorrectionLevel: QrErrorCorrectLevel.L,  // Error correction level
      gapless: true,  // Whether to have gaps between the QR code modules
    );

    // Convert QR code to image data
    final data = await qrPainter.toImageData(200);

    // Return the image data as MemoryImage
    return pw.MemoryImage(data!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Ticket PDF',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<pw.Document>(
        future: generatePdf(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Render the PDF directly using Printing.layoutPdf
            final pdf = snapshot.data!;

            return PdfPreview(
              build: (format) async => pdf.save(),
              canChangePageFormat: false,
              canDebug: false,
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}