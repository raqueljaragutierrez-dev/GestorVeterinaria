import 'package:flutter/material.dart';

import 'favoritos_provider.dart';

class ProviderFavoritos extends InheritedNotifier<FavoritosProvider> {
  const ProviderFavoritos({
    super.key,
    required FavoritosProvider favoritos,
    required super.child,
  }) : super(notifier: favoritos);

  static FavoritosProvider of(BuildContext context) {
    final ProviderFavoritos? provider = context
        .dependOnInheritedWidgetOfExactType<ProviderFavoritos>();

    assert(provider != null, 'No se encontró ProviderFavoritos');

    return provider!.notifier!;
  }
}
