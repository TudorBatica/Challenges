// ignore: public_member_api_docs
import 'dart:typed_data';

import 'package:formz/formz.dart';

import '../../domain/common/pair.dart';

// ignore: public_member_api_docs
enum ImageSelectionInputError { invalid }

/// Challenge team size input
class ImageSelectionInput
    extends FormzInput<Pair<Uint8List?, String?>, ImageSelectionInputError> {
  const ImageSelectionInput.pure(Pair<Uint8List?, String?> value)
      : super.pure(value);

  /// Input has been modified by user
  const ImageSelectionInput.dirty(Pair<Uint8List?, String?> value)
      : super.dirty(value);

  @override
  ImageSelectionInputError? validator(Pair<Uint8List?, String?>? value) {
    if (value == null || value.first == null || value.second == null) {
      return ImageSelectionInputError.invalid;
    }
  }
}
