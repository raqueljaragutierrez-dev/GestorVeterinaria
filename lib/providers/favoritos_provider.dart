//este archivo administra cuales productos estan marcados como favoritos
import 'package:flutter/material.dart'; //importa herramientas de Flutter material

//declaracion d la clase, hereda funcionalidades de otra clase como ChangeNotifier
//FavoritosProvider puede avisar a los widgets q dependen d ella cuando cambia la informacion d favoritos
class FavoritosProvider extends ChangeNotifier {
  //ChangeNotifier permite avisar a otros componentes cuando cambia la lista de favoritos
  final Set<int> _favoritos = //se utiliza Set xq un producto no debe aparecer dos veces en la lista favoritos
      {}; //guarda los identificadores de los productos favoritos sin repetirlos
  //aqui obtenemos los favoritos, getter permite consultar los favoritos desde otras partes del proyecto
  Set<int> get favoritos => Set.unmodifiable(
    _favoritos,
  ); //devuelve una version q no puede modificarse directamente

  int get cantidad => _favoritos.length; //cantidad devuelve cuantos productos estan marcados como favoritos
  //esfavorito() comprueba si un producto ya esta marcado
  bool esFavorito(int productoId) {
    //metodo recibe el identificador del producto
    return _favoritos.contains(
      productoId,
    ); //comprueba si ese identificador esta dentro del conjunto
  }

  //agrega el producto o lo quita si ya era favorito
  void cambiarFavorito(int productoId) {
    if (_favoritos.contains(productoId)) {
      //si ya esta en favoritos lo elimina
      _favoritos.remove(productoId);
    } else {
      //sino esta lo agrega
      _favoritos.add(productoId);
    }

    notifyListeners(); //avisa a los widgets para que actualicen lo q muestran
  }
}
