import 'package:flutter/material.dart';

//permite q el encabezado aaceda al proveedor de favoritos
import '../providers/provider_favoritos.dart';

class Encabezado extends StatelessWidget {
  const Encabezado({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de favoritos.
    final favoritos = ProviderFavoritos.of(
      //permite consultar la informacion compartida de favoritos
      context,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pets, color: Colors.white, size: 32),

              const SizedBox(width: 10),

              const Text(
                'VetCare',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              const Icon(Icons.favorite, color: Colors.white, size: 24),

              const SizedBox(width: 5),

              Text(
                //la propiedad cantidad devuelve el numero de elementos favoritos marcados
                '${favoritos.cantidad}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Text(
            'Tu compañero en el cuidado de tus mascotas',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
