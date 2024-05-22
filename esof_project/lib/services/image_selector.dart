import 'package:image_picker/image_picker.dart';

selectImage(ImageSource source) async {
  final ImagePicker selector = ImagePicker();
  final XFile? selectedImage = await selector.pickImage(source: source);

  if (selectedImage != null) {
    return await selectedImage.readAsBytes();
  }

  return null;
}
