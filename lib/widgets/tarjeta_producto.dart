import 'package:flutter/material.dart';

import '../models/producto.dart';
import '../providers/provider_favoritos.dart'; //permite acceder al administrador d favoritos desde le contexto del widget
import '../screens/detalle_producto_screen.dart'; //permite abrir la pantalla d detalles del producto

//creamos un widget llamado TarjetaProducto
class TarjetaProducto extends StatelessWidget {
  //StatelessWidget significa q la tarjeta recibe informacion pero no modifica esos datos por si misma
  //la tarjeta consulta un proveedor externo q puede notifica cambios, x eso el corazon puede actualizarse cuando cambia de favoritos
  final Producto producto; //indica q la tarjeta recibe un producto para mostrar
  //required this.producto obliga a proporcionar ese producto al crear la tarjeta
  const TarjetaProducto({super.key, required this.producto});
  //una tarjeta puede recibir el alimento para perros y otra el servicio de baño. Ambas usan el mismo
  // codigo pero muestran informacion diferente
  @override
  Widget build(BuildContext context) {
    //build define como se vera visualmente
    final favoritos = ProviderFavoritos.of(context); //aqui utiliza el metodo of q busca el proveedor y devuelve el objeto FavoritosProvider
    //aqui llama el metodo preguntando si el identificador dl producto actual esta marcado como favorito
    final esFavorito = favoritos.esFavorito(
      producto.id,
    ); //esta linea consulta el estado actual, si esta marcado como favorito

    return Card(
      //crea una tarjeta con apariencia de panel
      elevation: 3, //agrega una sombre para darle profundidad
      clipBehavior:
          Clip.antiAlias, //recorta el contenido q sobresalga dlos bordes
      child: Padding(
        //agrega espacio interno
        padding: const EdgeInsets.all(
          12,
        ), //establece 12 unidades d espacio en los cuatro lados
        child: Column(
          //organiza los elementos verticalmente uno debajo dl otro,child significa q coloca un widget dentro d otro
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //contiene la lista d widgets q se van a mostrar dentro d la columna
            Row(
              //organiza horizontalmente
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      producto
                          .imagen
                          .isNotEmpty //si la ruta d la imagen no esta vacia, utiliza image.asset
                      //si esta vacia muestra un icono d huellitas d mascota
                      ? Image.asset(
                          producto.imagen,
                          width: 85, //ancho imagen
                          height: 85, //alto d la imagen
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.pets, //si flutter no consigue cargar imagen, muestra el icono
                              size: 36,
                              color: Colors.teal,
                            );
                          },
                        )
                      : const Icon(Icons.pets, size: 36, color: Colors.teal),
                ),
                //conecta directamente tarjeta_producto con favoritos_provider
                IconButton(
                  tooltip: esFavorito
                      ? 'Quitar de favoritos'
                      : 'Agregar a favoritos',
                  onPressed: () {
                    favoritos.cambiarFavorito(
                      //cuando presiona llama al metodo q hace el cambio en favoritos_provider
                      //llama al metodo q agrega o elimina el identificado
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
            //espacios y nombre dl producto
            const SizedBox(height: 10),

            Text(
              //muestra texto
              producto.nombre, //obtiene el nombre del objeto recibido
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2, //limita el nombre a dos lineas
              overflow: TextOverflow.ellipsis, //TextOverflow.ellipsis evita q los nombres largos se salgan de la tarjeta
            ),

            const SizedBox(height: 6),
            //CATEGORIA
            Text(
              producto.categoria,
              style: const TextStyle(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(), //distirbuye el espacio dentro de la tarjeta
            //PRECIO
            Text(
              '₡${producto.precio.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            //TIPO D ELEMENTO
            const SizedBox(height: 4),

            Text(producto.tipo, style: const TextStyle(fontSize: 12)),
            //BOTON DE VER DETALLE
            const SizedBox(height: 10),

            SizedBox(
              width: double
                  .infinity, //permite q el boton ocupe todo el ancho disponible
              child: FilledButton.icon(
                //crea un boton con fondo, icono y texto
                onPressed: () {
                  //indica q debe ocurrir cuando el usuario presiona el boton
                  Navigator.push(
                    //permite abrir una nueva pantalla
                    context, //indica desde dond se realiza la navegacion
                    MaterialPageRoute(
                      //define la ruta hacia la pantalla siguiente
                      builder:
                          (
                            context,
                          ) => //construye la pantalla q contiene los detalles
                              //DetalleProductoScreen es la pantalla q contiene los detalles
                              DetalleProductoScreen(producto: producto), //envia el objeto completo a la pantalla detalles
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
