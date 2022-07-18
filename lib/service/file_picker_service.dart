import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';


class FilePickerService {

  Future<PlatformFile> pickImageFile() {
    return pickSingleFile(
      allowedExtensions: ['jpg']
    );
  }

  Future<PlatformFile> pickAudioFile() {
    return pickSingleFile(
      allowedExtensions: ['mp3']
    );
  }

  Future<PlatformFile> pickSingleFile({
    List<String>? allowedExtensions,
  }) async {

    List<PlatformFile>? pickedFiles;
    try {

      FilePickerResult? pickResult = await FilePicker.platform.pickFiles(
        allowedExtensions: allowedExtensions,
        allowMultiple: false,
        withData: true,
      );

      if (pickResult != null) {
        pickedFiles = pickResult.files;

      }

    } on PlatformException catch (e) {
      // _logException('Unsupported operation: $e');
    } catch (e) {
      // _logException(e.toString());
    }

    return pickedFiles![0];

    // maybe the widget has been dismount meanwhile loading
    // if (!mounted) return;

    // if (pickedFiles != null) {
    //
    //   setState(() {
    //     selectedFile = pickedFiles![0];
    //     hasSelectedImage = true;
    //     textEditingController.text = selectedFile!.name;
    //   });
    //
    //   if (widget.onImageSelected != null) {
    //     widget.onImageSelected!(selectedFile!.bytes!);
    //   }
    //
    // }

  }

}