
// String? required(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Required field.';
//   } else {
//     return null;
//   }
//
//
// }

String? Function(String?)? requiredValidator({errorMessage: 'Required field.'}) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    } else {
      return null;
    }
  };
}
