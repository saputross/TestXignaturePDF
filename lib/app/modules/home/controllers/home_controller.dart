import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:test_xignature_p_d_f/app/routes/app_pages.dart';

class HomeController extends GetxController {
  openFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.single;
      String path = file.path!;
      printInfo(info: 'Info $path');
      Get.toNamed(Routes.PDF, arguments: {"path": path});
    }
  }
}
