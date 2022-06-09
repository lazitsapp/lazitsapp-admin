import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
    {
      required Widget title,
      required ValueChanged<bool?> onChanged,
      required FormFieldSetter<bool> onSaved,
      required FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false,
      Key? key,
    }
  ) : super(
    key: key,
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    builder: (FormFieldState<bool> state) {

      void onChangedHandler(bool? value) {
        state.didChange(value);
        onChanged(value);
      }

      return CheckboxListTile(
        dense: state.hasError,
        title: title,
        value: state.value,
        // onChanged: state.didChange,
        onChanged: onChangedHandler,
        subtitle: state.hasError ? Builder(
          builder: (BuildContext context) =>  Text(
            state.errorText ?? '',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ) : null,
        controlAffinity: ListTileControlAffinity.leading,
      );
    }
  );
}