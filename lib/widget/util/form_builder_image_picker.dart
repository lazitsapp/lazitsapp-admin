import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lazitsapp_admin/service/file_picker_service.dart';

class FormBuilderImagePicker extends FormBuilderField<Uint8List> {

  final String? initialImageUrl;
  final String labelText;
  final String buttonText;

  FormBuilderImagePicker({
    Key? key,

    this.initialImageUrl,
    this.labelText = 'Photo',
    this.buttonText = 'Select Photo',
    // From Super
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    Uint8List? initialValue,
    FocusNode? focusNode,
    FormFieldSetter<Uint8List>? onSaved,
    FormFieldValidator<Uint8List>? validator,
    InputDecoration decoration = const InputDecoration(),
    required String name,
    ValueChanged<Uint8List?>? onChanged,
    ValueTransformer<Uint8List?>? valueTransformer,
    VoidCallback? onReset,
  }) : super(
    key: key,
    initialValue: initialValue,
    name: name,
    validator: validator,
    valueTransformer: valueTransformer,
    onChanged: onChanged,
    autovalidateMode: autovalidateMode,
    onSaved: onSaved,
    enabled: enabled,
    onReset: onReset,
    decoration: decoration,
    focusNode: focusNode,
    builder: (FormFieldState<Uint8List?> field) {
      final state = field as FormBuilderImagePickerState;
      final widget = state.widget;

      return InputDecorator(
        decoration: state.decoration.copyWith(
          border: InputBorder.none,
        ),
        child: ImagePickerWidget(
            initialImageUrl: widget.initialImageUrl,
            labelText: widget.labelText,
            buttonText: widget.buttonText,
            onImageSelected: (value) {
              field.didChange(value);
            }
        ),
      );
    },
  );

  @override
  FormBuilderImagePickerState createState() => FormBuilderImagePickerState();
}

class FormBuilderImagePickerState
    extends FormBuilderFieldState<FormBuilderImagePicker, Uint8List> {}


class ImagePickerWidget extends StatefulWidget {

  final String labelText;
  final String buttonText;
  final String? initialImageUrl;
  final FormFieldValidator<String?>? validator;
  final void Function(Uint8List)? onImageSelected;

  const ImagePickerWidget({
    Key? key,
    this.validator,
    this.initialImageUrl,
    this.onImageSelected,
    this.labelText = 'Photo',
    this.buttonText = 'Select Photo'
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

  PlatformFile? selectedFile;
  bool hasInitialValue = false;
  bool hasSelectedImage = false;
  FilePickerService filePickerService = FilePickerService();
  final TextEditingController textEditingController =
    TextEditingController();


  @override
  void initState() {

    String? initUrl = widget.initialImageUrl;
    if (initUrl != null) {
      hasInitialValue = true;
      textEditingController.text = initUrl;
    } else {
      hasInitialValue = false;
    }

    super.initState();
  }

  void _selectFile() async {
    List<PlatformFile>? pickedFiles;
    try {

      FilePickerResult? pickResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
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
        textEditingController.text = selectedFile!.name;
      });

      if (widget.onImageSelected != null) {
        widget.onImageSelected!(selectedFile!.bytes!);
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: textEditingController,
          readOnly: true,
          decoration: InputDecoration(labelText: widget.labelText),
          validator: widget.validator,
          // onChanged: widget.onChanged,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              onPressed: () {
                _selectFile();
              },
              child: Text(widget.buttonText),
            )
          ],
        ),
        const SizedBox(height: 16),
        buildCurrentImageDisplay(),
      ],
    );
  }

  Widget buildCurrentImageDisplay() {

    Widget image;

    if (hasInitialValue && hasSelectedImage == false) {
      image = Image(
          image: NetworkImage(widget.initialImageUrl!)
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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        color: Colors.grey.shade400,
      ),
      padding: const EdgeInsets.all(32.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 200),
        child: image
      ),
    );

  }

  void _logException(String message) {
    debugPrint(message);
    // _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    // _scaffoldMessengerKey.currentState?.showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //   ),
    // );
  }
}
