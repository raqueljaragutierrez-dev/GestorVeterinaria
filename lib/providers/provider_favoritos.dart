//este archivo utiliza InheritedNotifier para compartir ese administrador con diferentes partes d la aplicacion
//de esta manera favoritos puede consultarse y actualizarse desde distintas pantallas y componentes
//este archivo permite q otras partes d la aplicacion pueda acceder a esa informacion y escuchar sus cambios
import 'package:flutter/material.dart';

import 'favoritos_provider.dart';

//hereda funcionalidades d otra clas. InheritedNotifier es una herramienta d flutter permite compartir un objeto y
//notificar a los widgets q dependen d el. <FavoritosProvider> indica q tipo d objeto va a compartir y observar
class ProviderFavoritos extends InheritedNotifier<FavoritosProvider> {
  const ProviderFavoritos({
    //permite crear una instancia cuando se cumplen las condiciones
    super.key, //recibe y pasa la clave del widget a la clase heredada
    required FavoritosProvider
    favoritos, //exige recibir un objeto q administre los favoritos
    required super.child, //exige recibir el widget hijo q esta dentro d ese proveedor,child es el widget o
    //conjunto de widgets q estaran dentro de ProviderFavoritos y podran acceder al administrador d favoritos
  }) : super(
         notifier: favoritos,
       ); //envia el administrador d favoritos a la clase InheritedNotifier
  //metodo para acceder al proveedor, FavoritosProvider  indica q tipo d objeto devuelve
  static FavoritosProvider of(BuildContext context) {
    //busca un ProviderFavoritos en los widgets q contienen al widget actual
    final ProviderFavoritos? provider = context
        .dependOnInheritedWidgetOfExactType<
          ProviderFavoritos
        >(); //busca el proveedor y registra q este widget depende d el
    //comprueba q el proveedor exista
    assert(provider != null, 'No se encontró ProviderFavoritos');

    return provider!.notifier!; //devuelve el objeto FavoritosProvider q esta administrando los favoritos
  } //ESTE METODO FACILITA Q LOS WIDGETS PUEDAN ACCEDER A LOS METODOS Q ESTAN EN EL OTRO ARCCHIVO
}
