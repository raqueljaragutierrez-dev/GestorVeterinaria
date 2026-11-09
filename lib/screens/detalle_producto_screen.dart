import 'package:flutter/material.dart';

import '../models/producto.dart';
//permiten acceder a la lista compartida d favoritos y modificarla
import '../providers/favoritos_provider.dart';
import '../providers/provider_favoritos.dart';

class DetalleProductoScreen extends StatelessWidget {
  final Producto producto; //esta variable recibe el producto q queremos mostrar

  const DetalleProductoScreen({
    super.key,
    required this.producto,
  }); //este constructor obliga a q al abrir la pantalla le enviamos un producto
  //no necesistamos crear una pantalla diferente para cada produco, reutilizamos la misma,
  // se le pasan los datos correspondientes
  @override
  Widget build(BuildContext context) {
    //obtiene el proveedor d favoritos q comparte la informacion entre las pantallas
    final favoritos = ProviderFavoritos.of(context);
    //comprueba si el producto q estamos mostrando ya esta marcado como favorito
    final esFavorito = favoritos.esFavorito(producto.id);
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del producto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 250,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  //redondea las esquinas d la imagen
                  borderRadius: BorderRadius.circular(20),
                  child: producto.imagen.isNotEmpty
                      ? Image.asset(
                          //carga la imagen guardada en la carpeta assets/images
                          producto.imagen, //obtiene la ruta de la imagen del producto seleccionado
                          width:
                              250, //establece el ancho del espcaio de la imagen
                          height: 220, //su altura
                          fit: BoxFit.contain, //muestra la imagen compleat sin deformarla
                          errorBuilder: (context, error, stackTrace) {
                            //muestra un icono si ocurre un error al cargarla
                            return const Icon(
                              Icons.pets,
                              size: 70,
                              color: Colors.teal,
                            );
                          },
                        )
                      : const Icon(Icons.pets, size: 70, color: Colors.teal),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              //coloca el nombre y el corazon en una misma fila
              children: [
                Expanded(
                  //permite q el nombre utilice es espacio disponible sin chocar con el boton
                  child: Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  //crea el boton q podemos preseionar
                  onPressed: () {
                    //ejecuta la accion cuando presionamos el corazon
                    favoritos.cambiarFavorito(
                      producto.id,
                    ); //agrega o quita de favoritos
                  },
                  icon: Icon(
                    //muestra corazon vacio o lleno, depende del estado
                    esFavorito ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 30,
                  ),
                  tooltip: esFavorito
                      ? 'Quitar de favoritos'
                      : 'Agregar a favoritos',
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              producto.categoria,
              style: const TextStyle(fontSize: 16, color: Colors.teal),
            ),

            const SizedBox(height: 20),

            const Text(
              'Descripción',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(producto.descripcion, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            const Text(
              'Precio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              '₡${producto.precio.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),

            const SizedBox(height: 16),

            Chip(
              label: Text(producto.tipo),
              avatar: const Icon(Icons.label_outline),
            ),
          ],
        ),
      ),
    );
  }
}
