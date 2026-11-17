import 'package:flutter/material.dart';

//este archivo muestra el formulario, captura los datos, valida la informacion y devuelve el nuevo producto
import '../models/producto.dart'; //permite crear objetos de la clase Producto

//utiliza StatefulWidget xq el formulario contiene informacion q puede cambiar mientras el usuario intectura con el
class AgregarProductoScreen extends StatefulWidget {
  final int nuevoId; //variable q recibe el id del nuevo producto

  const AgregarProductoScreen({
    super.key,
    required this.nuevoId,
  }); //recibe el id del nuevo producto desde catalogo_screen

  @override //este metodo crea el objeto q administra el estado del formulario
  State<AgregarProductoScreen> createState() => _AgregarProductoScreenState();
}

//comienza la clase q contiene el funcionamiento del formulario
class _AgregarProductoScreenState extends State<AgregarProductoScreen> {
  // Controla y valida el formulario.
  final _formKey = GlobalKey<FormState>(); //crea una clave q permite identificar y acceder al estado dl formulario
  // Controladores para capturar la información.Permiten obtener el contenido q el usuario
  //escribe en los campos
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  // Valores seleccionados en las listas desplegables.
  String?
  _categoria; //estas variables alamacenan las opciones q selecciona el usuario
  String _tipo = 'Producto';

  // Libera los controladores cuando se cierra la pantalla.
  //xq TextEditingController administra recursos y deben liberarse cuando ya no se necesitan
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
      //_formKey.identifica el formulario,currentState! permite acceder a su estado actual
      // Creamos un nuevo objeto Producto.
      final nuevoProducto = Producto(
        //aqui utilizamos el constructor de la clase Producto
        id: widget.nuevoId,
        nombre: _nombreController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        precio: double.parse(_precioController.text.trim()),
        categoria: _categoria!,
        tipo: _tipo,
        imagen: '',
      );
      //AQUI SE DA LA NAVEGACION ENTRE PANTALLAS
      // Regresamos al catálogo enviando el nuevo producto.
      Navigator.pop(
        context,
        nuevoProducto,
      ); //permite cerrar la pantalla actual y regresar a la pantalla superior
    }
  }

  //aqui comienza la construccion visual d la pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar producto o servicio')),
      //SingleChildScrollView permite recorrer el formulario en pantallas pequeñas
      body: SingleChildScrollView(
        //permite desplazarse verticalmente por el formulario
        padding: const EdgeInsets.all(
          20,
        ), //mantiene separacion entre los campos y los bordes
        //aqui conectamos el formulario con la clave q declaramos anteriormente
        child: Form(
          //form agrupa los campos del formulario y permite administrarlos y validarlos
          key: _formKey,

          child: Column(
            //organiza verticalmente los componentes
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
                //crea el campo donde el usuario escribe
                //permite ingresar la informacion
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.pets),
                ),
                validator: (valor) {
                  //comprueba si la informacion es valida
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
                  //solicita teclado numerico q permite ingresar decimales
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  hintText: 'Ejemplo: 9500', //muestra un ejemplo de lo q se debe ingresar
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
                    //cada uno representa una opcion de la lista
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
                  //onChanged: detecta el cambio, valor contiene la opcion seleccionada
                  setState(() {
                    //actualiza el estado dl formulario
                    _categoria = valor; //guarda la seleccion
                  });
                },
                validator: (valor) {
                  //evita q guarde el formulario sin seleccionar una categoria
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
                  //comprueba q el valor seleccionado no sea nulo y despues actualiza
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
                  onPressed: _guardarProducto, //cuando presiona guardar ejecuta el metoso guardarProducto
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
