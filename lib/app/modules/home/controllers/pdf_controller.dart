
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfController extends GetxController {
  var pdfPath = ''.obs;
  var imagePath = ''.obs;
  Rx<Offset> offset = const Offset(200.0, 200.0).obs;
  var currentPage = 0.obs;
  var heightPdf = 0.0.obs;
  var isPlaced = false.obs;

  @override
  void onInit() {
    pdfPath.value = Get.arguments['path'];
    super.onInit();
  }

  init() {
    final PdfDocument document = PdfDocument(inputBytes: File(pdfPath.value).readAsBytesSync());
    heightPdf.value = document.pageSettings.height;
  }

  onDragEnd(offsets, context) {
    var minusTopPadding = AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top;
    var dx = offsets.dx < 0.0 ? 0.0 : offsets.dx;
    var dy = offsets.dy < minusTopPadding ? minusTopPadding : offsets.dy;
    offset.value = Offset(dx, dy);
    isPlaced.value = false;
  }

  openImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (image != null) {
      imagePath.value = image.path;
    } 
  }

  savePdf(context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else {
      Uint8List bytes = await File(imagePath.value).readAsBytes();
      final PdfDocument document = PdfDocument(inputBytes: File(pdfPath.value).readAsBytesSync());
      final PdfBitmap image = PdfBitmap(bytes);
      var height = document.pageSettings.height;
      var width= document.pageSettings.width;
      document.pages[currentPage.value].graphics.drawImage(
        image,
        Rect.fromLTWH(
          offset.value.dx * (width/MediaQuery.of(context).size.width),
          offset.value.dy * (MediaQuery.of(context).size.height/height) - AppBar().preferredSize.height,
          60,
          60,
        ),
      );
      var output = "/storage/emulated/0/Download/";
      var filePath = '${output}doc-${DateTime.now().millisecondsSinceEpoch}.pdf';
      File file = await File(filePath).create(recursive: true);
      file.writeAsBytes(await document.save());
      document.dispose();
      isPlaced.value = true;
      showSnackBar(context);
    }
  }

  showSnackBar(context) {
    const snackBar = SnackBar(
      content: Text('Berhasil menyimpan pdf di folder Download')
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
