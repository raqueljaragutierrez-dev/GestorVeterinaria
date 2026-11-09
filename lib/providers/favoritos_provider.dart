import 'package:flutter/material.dart';

import '../providers/favoritos_provider.dart';

class FavoritosProvider extends ChangeNotifier {
  //ChangeNotifier permite avisar cuando cambia la lista de favoritos
  final Set<int> _favoritos =
      {}; //guarda los identificadores de los productos favoritos sin repetirlos

  Set<int> get favoritos => Set.unmodifiable(_favoritos);

  int get cantidad => _favoritos.length; //cantidad devuelve cuantos productos estan marcados como favoritos
  //esfavorito() comprueba si un producto ya esta marcado
  bool esFavorito(int productoId) {
    return _favoritos.contains(productoId);
  }

  //agrega el producto o lo quita si ya era favorito
  void cambiarFavorito(int productoId) {
    if (_favoritos.contains(productoId)) {
      _favoritos.remove(productoId);
    } else {
      _favoritos.add(productoId);
    }

    notifyListeners(); //avisa alos widgets para que actualicen lo q muestran
  }
}
