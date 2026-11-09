import 'package:flutter/material.dart';

import 'screens/catalogo_screen.dart';
import 'providers/favoritos_provider.dart';
import 'providers/provider_favoritos.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatefulWidget {
  const MiAplicacion({super.key});

  @override
  State<MiAplicacion> createState() => _MiAplicacionState();
}

class _MiAplicacionState extends State<MiAplicacion> {
  final FavoritosProvider favoritosProvider =
      FavoritosProvider(); //crea el administrador de favoritos

  @override
  void dispose() {
    //libera el administrador cuando la aplicacion se destruye
    favoritosProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderFavoritos(
      //ProviderFavoritos permite q los widgets accedan a esa misma instancia

      favoritos: favoritosProvider,
      child: MaterialApp(
        //configura aspectos generales como el tema visual
        debugShowCheckedModeBanner: false,
        title: 'Gestor Veterinaria',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const CatalogoScreen(), //indica q el catalogo sera la pantalla inicial
      ),
    );
  }
}
