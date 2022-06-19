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

//Peticiones http

//GET
  static Future httpGet(String path) async {
    // path ej: /user, /users
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

  //POST
  static Future httpPost(String path, Map<String, dynamic> data) async {
    //Convierte la data como body para poder utilizarla
    final formData = FormData.fromMap(data);

    try {
      //respuesta
      final resp = await _dio.post(path, data: formData);
      return resp.data;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw ("Error en el POST");
    }
  }
}
