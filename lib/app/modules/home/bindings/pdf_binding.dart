import 'package:get/get.dart';
import 'package:test_xignature_p_d_f/app/modules/home/controllers/pdf_controller.dart';

class PdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfController>(
      () => PdfController(),
    );
  }
}
