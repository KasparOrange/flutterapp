import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class ImageModel {
  final String name;
  final Uint8List bytes;

  ImageModel({required this.name, required this.bytes});

  ImageModel.fromList({required this.name, required List list})
      : bytes = Uint8List.fromList(List<int>.from(list));

  Image toWidget({double scale = 1}) {
    return Image.memory(bytes);
  }
}
