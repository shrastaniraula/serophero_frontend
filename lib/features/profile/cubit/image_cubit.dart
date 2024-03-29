import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:serophero/features/profile/cubit/image_cubit_state.dart';
// import 'package:bookme/logic/bloc_export.dart';

class StoreImageCubit extends Cubit<ImageStorage> {
  StoreImageCubit() : super(ImageStorage());
  void addition({required File image}) => emit(ImageStorage(image: image));

  void clear() => emit(ImageStorage());
}
