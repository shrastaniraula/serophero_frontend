import 'dart:io';

import 'package:equatable/equatable.dart';

class ImageStorage extends Equatable {
  // int counter;
  File? image;

  ImageStorage({this.image});

  @override
  List<Object> get props {
    if (this.image != null) {
      return [this.image!];
    }
    return [];
  }
}
