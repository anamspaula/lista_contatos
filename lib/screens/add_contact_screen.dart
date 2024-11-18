import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart'; // Importa o CustomAppBar

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Adicionar Contato',
        showBackButton: true, // Exibe o botão de voltar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: _buildInputDecoration(
                label: 'Nome',
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: _buildInputDecoration(
                label: 'Telefone',
                icon: Icons.phone,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: _buildInputDecoration(
                label: 'Email',
                icon: Icons.email,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
