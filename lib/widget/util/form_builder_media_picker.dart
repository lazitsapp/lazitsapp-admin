import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderMediaPicker extends FormBuilderField<Uint8List> {

  final String? initialImageUrl;
  final String labelText;
  final String buttonText;

  FormBuilderMediaPicker({
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
      final state = field as FormBuilderMediaPickerState;
      final widget = state.widget;

      return InputDecorator(
        decoration: state.decoration.copyWith(
          border: InputBorder.none,
        ),
        child: MediaPickerWidget(
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
  FormBuilderMediaPickerState createState() => FormBuilderMediaPickerState();

}

class FormBuilderMediaPickerState
  extends FormBuilderFieldState<FormBuilderMediaPicker, Uint8List> {}

class MediaPickerWidget extends StatefulWidget {
  final String labelText;
  final String buttonText;
  final String? initialImageUrl;
  final FormFieldValidator<String?>? validator;
  final void Function(Uint8List)? onImageSelected;

  const MediaPickerWidget({
    Key? key,
    this.validator,
    this.initialImageUrl,
    this.onImageSelected,
    this.labelText = 'Photo',
    this.buttonText = 'Select Photo'
  }) : super(key: key);

  @override
  State<MediaPickerWidget> createState() => _MediaPickerWidgetState();
}

class _MediaPickerWidgetState extends State<MediaPickerWidget> {

  PlatformFile? selectedFile;
  bool hasInitialValue = false;
  bool hasSelectedImage = false;
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
        // type: FileType.audio,
        allowedExtensions: ['mp3'],
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
      ],
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