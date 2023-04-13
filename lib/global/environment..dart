import 'dart:io';

class Environment{
  //Servicios Rest
  static String apiUrl = Platform.isAndroid ? 
  'http://10.0.2.2:3000/api' : 'http://localhost:3000/api';
  
  //Servicios Socket's
  static String socketUrl = Platform.isAndroid ? 
  'http://10.0.2.2:3000/' : 'http://localhost:3000/';
}