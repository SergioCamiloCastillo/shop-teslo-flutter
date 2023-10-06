import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }
  //declaramos static para no tener que crear una instancia de la clase y acceder a apiUrl de la siguiente manera Environment.apiUrl
  static String apiUrl =
      dotenv.env['API_URL'] ?? "No esta configurado el API_URL";
}
