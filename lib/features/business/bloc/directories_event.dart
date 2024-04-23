part of 'directories_bloc.dart';

abstract class BusinessEvent {}

class DirectoriesPageOpened extends BusinessEvent {
  DirectoriesPageOpened();
}

class DirectoryRegisterButtonClicked extends BusinessEvent {
  final File? citizenFront;
  final File? citizenBack;
  final File? doc1;
  final File? doc2;
  final File? doc3;
  final String name;
  final String description;

  DirectoryRegisterButtonClicked(
      {required this.citizenFront,
      required this.citizenBack,
      required this.doc1,
      required this.doc2,
      required this.doc3,
      required this.name,
      required this.description});
}
