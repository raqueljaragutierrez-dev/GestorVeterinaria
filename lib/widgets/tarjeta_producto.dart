import 'package:flutter/material.dart';

import '../models/producto.dart';
import '../providers/favoritos_provider.dart';
import '../providers/provider_favoritos.dart';
import '../screens/detalle_producto_screen.dart';

//creamos un widget llamado TarjetaProducto
class TarjetaProducto extends StatelessWidget {
  final Producto producto; //indica q la tarjeta recibe un producto para mostrar
  //required this.producto obliga a proporcionar ese producto al crear la tarjeta
  const TarjetaProducto({super.key, required this.producto});
  //una tarjeta puede recibir el alimento para perros y otra el servicio de baño. Ambas usan el mismo
  // codigo pero muestran informacion diferente
  @override
  Widget build(BuildContext context) {
    //build define como se vera visualmente
    final favoritos = ProviderFavoritos.of(context);
    final esFavorito = favoritos.esFavorito(
      producto.id,
    ); //esta linea consulta el estado actual

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: producto.imagen.isNotEmpty
                      ? Image.asset(
                          producto.imagen,
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.pets,
                              size: 36,
                              color: Colors.teal,
                            );
                          },
                        )
                      : const Icon(Icons.pets, size: 36, color: Colors.teal),
                ),

                IconButton(
                  tooltip: esFavorito
                      ? 'Quitar de favoritos'
                      : 'Agregar a favoritos',
                  onPressed: () {
                    favoritos.cambiarFavorito(
                      producto.id,
                    ); //esta linea cambia el estado al presionar el corazon
                  },
                  icon: Icon(
                    esFavorito ? Icons.favorite : Icons.favorite_border,
                    color: esFavorito ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              producto.nombre,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2, //limita el nombre a dos lineas
              overflow: TextOverflow.ellipsis, //TextOverflow.ellipsis evita q los nombres largos se salgan de la tarjeta
            ),

            const SizedBox(height: 6),

            Text(
              producto.categoria,
              style: const TextStyle(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(), //distirbuye el espacio dentro de la tarjeta

            Text(
              '₡${producto.precio.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(producto.tipo, style: const TextStyle(fontSize: 12)),

            const SizedBox(height: 10),

            SizedBox(
              width: double
                  .infinity, //permite q el boton ocupe todo el ancho disponible
              child: FilledButton.icon(
                //crea un boton con fondo, icono y texto
                onPressed: () {
                  //indica q debe ocurrir cuando el usuario prseiona el boton
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetalleProductoScreen(producto: producto),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.visibility_outlined,
                ), //muestra un icono de visualizacion
                label: const Text(
                  'Ver detalle',
                ), //establece el texto Ver Detalle
              ),
            ),
          ],
        ),
      ),
    );
  }
}
