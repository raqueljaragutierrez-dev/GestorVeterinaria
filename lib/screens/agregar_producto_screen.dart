import 'package:flutter/material.dart';

import '../models/producto.dart';

class AgregarProductoScreen extends StatefulWidget {
  final int nuevoId;

  const AgregarProductoScreen({super.key, required this.nuevoId});

  @override
  State<AgregarProductoScreen> createState() => _AgregarProductoScreenState();
}

class _AgregarProductoScreenState extends State<AgregarProductoScreen> {
  // Controla y valida el formulario.
  final _formKey = GlobalKey<FormState>();
  // Controladores para capturar la información.Permiten obtener el contenido q el usuario
  //escribe en los campos
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  // Valores seleccionados en las listas desplegables.
  String? _categoria;
  String _tipo = 'Producto';

  // Libera los controladores cuando se cierra la pantalla.
  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();

    super.dispose();
  }

  // Método para guardar el nuevo producto.
  void _guardarProducto() {
    // Comprueba que todos los campos sean válidos.
    if (_formKey.currentState!.validate()) {
      // Creamos un nuevo objeto Producto.
      final nuevoProducto = Producto(
        id: widget.nuevoId,
        nombre: _nombreController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        precio: double.parse(_precioController.text.trim()),
        categoria: _categoria!,
        tipo: _tipo,
        imagen: '',
      );

      // Regresamos al catálogo enviando el nuevo producto.
      Navigator.pop(context, nuevoProducto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar producto o servicio')),
      //SingleChildScrollView permite recorrer el formulario en pantallas pequeñas
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          20,
        ), //mantiene separacion entre los campos y los bordes

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'Registrar nuevo elemento',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Complete la información del producto o servicio.',
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 24),

              // Campo nombre.
              TextFormField(
                //permite ingresar la informacion
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.pets),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Campo descripción.
              TextFormField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description_outlined),
                  alignLabelWithHint: true,
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'La descripción es obligatoria';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Campo precio.
              TextFormField(
                controller: _precioController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  hintText: 'Ejemplo: 9500',
                  prefixText: '₡ ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'El precio es obligatorio';
                  }

                  final precio = double.tryParse(valor.trim());
                  if (precio == null) {
                    return 'Ingrese un precio numérico válido';
                  }
                  if (precio <= 0) {
                    return 'El precio debe ser mayor que cero';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Lista desplegable de categorías.
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Alimentos',
                    child: Text('Alimentos'),
                  ),
                  DropdownMenuItem(value: 'Estética', child: Text('Estética')),
                  DropdownMenuItem(
                    value: 'Consultas',
                    child: Text('Consultas'),
                  ),
                  DropdownMenuItem(
                    value: 'Accesorios',
                    child: Text('Accesorios'),
                  ),
                ],
                onChanged: (valor) {
                  setState(() {
                    _categoria = valor;
                  });
                },
                validator: (valor) {
                  if (valor == null) {
                    return 'Seleccione una categoría';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Lista desplegable del tipo.
              DropdownButtonFormField<String>(
                value: _tipo,
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label_outline),
                ),
                items: const [
                  DropdownMenuItem(value: 'Producto', child: Text('Producto')),
                  DropdownMenuItem(value: 'Servicio', child: Text('Servicio')),
                ],
                onChanged: (valor) {
                  if (valor != null) {
                    setState(() {
                      _tipo = valor;
                    });
                  }
                },
              ),

              const SizedBox(height: 24),

              // Botón para guardar.
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _guardarProducto,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
