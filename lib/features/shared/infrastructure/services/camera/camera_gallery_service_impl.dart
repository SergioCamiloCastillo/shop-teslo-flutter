//aqui esta el codigo necesito para que funcione la camara
import 'package:image_picker/image_picker.dart';
import 'package:teslo_shop_flutter/features/shared/infrastructure/services/camera/camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (photo == null) return null;
    print("el path de select es $photo");
    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.rear);
    if (photo == null) return null;
    print("el path de take es $photo");

    return photo.path;
  }
}
