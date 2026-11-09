import 'package:flutter/material.dart';

import 'agregar_producto_screen.dart';
import '../data/productos_iniciales.dart';
import '../models/producto.dart';
import '../widgets/tarjeta_producto.dart';
import '../widgets/encabezado.dart';

//StatefulWidget  permite actualizar la interfaz cuando cambia su estado
class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  // Lista que contiene los productos y servicios del catálogo. es una lista modificable
  //List.from crea una lista independientebq si podemos modificar agregando nuevos elementos
  final List<Producto> productos = List.from(productosIniciales);
  //metodo q va a conectar el formulario con el catalogo
  Future<void> _abrirFormulario() async {
    // Calculamos el siguiente identificador disponible.
    int nuevoId = productos.isEmpty
        ? 1
        : productos
                  .map((producto) => producto.id)
                  .reduce((a, b) => a > b ? a : b) +
              1;

    // Abrimos el formulario y esperamos el producto.
    final nuevoProducto = await Navigator.push<Producto>(
      context,
      MaterialPageRoute(
        builder: (context) => AgregarProductoScreen(nuevoId: nuevoId),
      ),
    );

    // Si recibimos un producto, lo agregamos al catálogo.
    if (nuevoProducto != null) {
      setState(() {
        productos.add(nuevoProducto);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VetCare'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Encabezado(),

              const SizedBox(height: 16),

              const Text(
                'Catálogo veterinario',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Productos y servicios para tus mascotas',
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _abrirFormulario,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar producto o servicio'),
                ),
              ),

              const SizedBox(height: 16),

              LayoutBuilder(
                builder: (context, constraints) {
                  int columnas;

                  if (constraints.maxWidth < 600) {
                    columnas = 1;
                  } else if (constraints.maxWidth < 900) {
                    columnas = 2;
                  } else {
                    columnas = 3;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnas,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final producto = productos[index];

                      return TarjetaProducto(producto: producto);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
