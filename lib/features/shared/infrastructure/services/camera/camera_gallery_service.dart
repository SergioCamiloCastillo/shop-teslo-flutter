//aqui se definen las reglas que necesitan los paquetes que vayan a usar la camara

abstract class CameraGalleryService {
  Future<String?> takePhoto();
  Future<String?> selectPhoto();
}
