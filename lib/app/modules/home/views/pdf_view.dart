import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:test_xignature_p_d_f/app/modules/home/controllers/pdf_controller.dart';

class PdfView extends GetView<PdfController> {
  const PdfView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Pdf View'),
          centerTitle: true,
        ),
        body: Obx(
          () => Stack(
            children: [
              PDFView(
                filePath: controller.pdfPath.value,
                autoSpacing: false,
                onPageChanged: (int? page, int? total) {
                  controller.currentPage.value = page!;
                },
              ),
              Visibility(
                visible: controller.imagePath.value != '',
                child: Positioned(
                  top: controller.offset.value.dy,
                  left: controller.offset.value.dx,
                  child: Draggable(
                    childWhenDragging: Container(),
                    feedback: Material(
                      child: controller.imagePath.value != '' ? DisplayImage(imagePath: controller.imagePath.value, offset: controller.offset.value,) : Container()
                    ),
                    onDragEnd: (details) {
                      var offset = Offset(details.offset.dx, details.offset.dy - AppBar().preferredSize.height - MediaQuery.of(context).viewPadding.top,);
                      controller.onDragEnd(offset, context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.imagePath.value != '' ? DisplayImage(imagePath: controller.imagePath.value, offset: controller.offset.value) : Container(),
                        Visibility(
                          visible: !controller.isPlaced.value,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.savePdf(context);
                                },
                                splashColor: Colors.white,
                                child: Container(
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: const Icon(Icons.done, color: Colors.white,)
                                )
                              ),
                              const SizedBox(height: 5,),
                              InkWell(
                                onTap: () {
                                  controller.imagePath.value = '';
                                },
                                splashColor: Colors.white,
                                child: Container(
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: const Icon(Icons.close, color: Colors.white,)
                                ) 
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                )
              ),
              Visibility(
                visible: controller.imagePath.value == "",
                child: Positioned(
                  bottom: 10,
                  left: (MediaQuery.of(context).size.width/2 - 60),
                  right: (MediaQuery.of(context).size.width /2 - 60),
                  child: InkWell(
                    onTap: () {
                      controller.openImage();
                    },
                    splashColor: Colors.white,
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5,),
                          Center(
                            child: Text(
                              'Add Image',
                              style: TextStyle(color: Colors.white),
                            )
                          ),
                        ],
                      ) 
                    ),
                  )
                )
              ),
            ],
          )
        ) 
      )
    );
  }
}

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final Offset offset;
  const DisplayImage({Key? key, required this.imagePath, required this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.file(
          File(imagePath),
          height: 50,
          width: 50,
          fit: BoxFit.contain,
        ),
        Text("x: ${double.parse(offset.dx.toStringAsFixed(3))}"),
        Text("y: ${double.parse(offset.dy.toStringAsFixed(3))}")
      ],
    );
  }

}
