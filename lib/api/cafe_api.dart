import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
//Crea instancia
  static final Dio _dio = Dio();

  static void configureDio() {
    //Base del url
    _dio.options.baseUrl = 'http://localhost:8080/api';

    //Configurar Headers
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }

// Peticion http .GET

  static Future httpGet(String path) async {
    try {
      //respuesta
      final resp = await _dio.get(path);

      return resp.data;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw ("Error en el GET");
    }
  }
}
