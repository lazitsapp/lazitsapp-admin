import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class ImageFilePicker extends StatefulWidget {

  final String? currentImageUrl;
  final Function? onImageFileSelected;

  const ImageFilePicker(
    {
      this.currentImageUrl,
      this.onImageFileSelected,
      Key? key
    }
  ) : super(key: key);

  @override
  State<ImageFilePicker> createState() => _ImageFilePickerState();
}

class _ImageFilePickerState extends State<ImageFilePicker> {


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile> _paths = [];
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  PlatformFile? selectedFile;
  bool isFileSelected = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _pickFiles() async {
    _resetState();
    List<PlatformFile>? pickFilesResult;
    try {
      _directoryPath = null;

      pickFilesResult = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        withData: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }

    // maybe the widget has been dismount meanwhile loading
    if (!mounted) return;

    if (pickFilesResult != null) {
      setState(() {
        isFileSelected = true;
        selectedFile = pickFilesResult![0];
        // _isLoading = false;
        // _fileName =
        // _paths != null ? _paths!.map((e) => e.name).toString() : '...';
        // _userAborted = _paths == null;
      });

      if (widget.onImageFileSelected != null) {
        widget.onImageFileSelected!(selectedFile!.bytes);
      }
    }



  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = [];
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        if (widget.currentImageUrl != null) buildCurrentImageDisplay(widget.currentImageUrl!),
        ElevatedButton(
          onPressed: () => _pickFiles(),
          child: const Text('Pick file'),
        ),
      ],
    );

  }

  Widget buildCurrentImageDisplay(String currentImageUrl) {

    Widget image;

    if (isFileSelected) {
      Uint8List bytes = selectedFile!.bytes!;
      image = Image.memory(bytes);
    } else {
      image = Image(
        image: NetworkImage(currentImageUrl)
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200),
      child: Container(
        child: image
      )
    );

  }

}
