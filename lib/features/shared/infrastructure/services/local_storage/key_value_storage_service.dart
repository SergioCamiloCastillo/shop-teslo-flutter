abstract class KeyValueStorageService {
  //T significa que es un dato de tipo generico segun como lo manden, si es entero entonces manejelo como entero, si se manda string, entonces manejelo como string
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getKeyValue<T>(String key);

  Future<bool> removeKey(String key);
}
