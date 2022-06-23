import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class ImageFilePicker extends StatefulWidget {

  final String? initialValue;
  final Function? onImageFileSelected;

  const ImageFilePicker(
    {
      this.initialValue,
      this.onImageFileSelected,
      Key? key
    }
  ) : super(key: key);

  @override
  State<ImageFilePicker> createState() => _ImageFilePickerState();
}

class _ImageFilePickerState extends State<ImageFilePicker> {

  late final bool hasInitialValue;
  bool hasSelectedImage = false;

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  // String? _fileName;
  // String? _saveAsFileName;
  // List<PlatformFile> _paths = [];
  // String? _directoryPath;
  // String? _extension;
  // bool _isLoading = false;
  // bool _userAborted = false;
  // bool _multiPick = false;
  // FileType _pickingType = FileType.any;
  // TextEditingController _controller = TextEditingController();

  PlatformFile? selectedFile;

  @override
  void initState() {
    hasInitialValue = widget.initialValue != null;
    super.initState();
    // _controller.addListener(() => _extension = _controller.text);
  }

  void _pickFiles() async {
    _resetState();
    List<PlatformFile>? pickedFiles;
    try {
      // _directoryPath = null;

      FilePickerResult? pickResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
        // onFileLoading: (FilePickerStatus status) => print(status),
      );

      if (pickResult != null) {
        pickedFiles = pickResult.files;
      }

    } on PlatformException catch (e) {
      _logException('Unsupported operation: $e');
    } catch (e) {
      _logException(e.toString());
    }

    // maybe the widget has been dismount meanwhile loading
    if (!mounted) return;

    if (pickedFiles != null) {
      setState(() {
        selectedFile = pickedFiles![0];
        hasSelectedImage = true;
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
      // _isLoading = true;
      // _directoryPath = null;
      // _fileName = null;
      // _paths = [];
      // _saveAsFileName = null;
      // _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        buildCurrentImageDisplay(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          // style: Theme.of(context).outlinedButtonTheme.style,
          onPressed: () => _pickFiles(),
          child: const Text('Pick file'),
        ),
      ],
    );

  }

  Widget buildCurrentImageDisplay() {

    Widget image;

    if (hasInitialValue) {
      image = Image(
        image: NetworkImage(widget.initialValue!)
      );
    } else if (hasSelectedImage) {
      Uint8List bytes = selectedFile!.bytes!;
      image = Image.memory(bytes);
    } else {
      image = Container(
        width: 200,
        height: 200,
        color: Colors.purpleAccent,
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
