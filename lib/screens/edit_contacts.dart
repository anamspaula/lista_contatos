import 'package:flutter/material.dart';
import 'package:myapp/data/model/users_model.dart';
import '../widgets/custom_app_bar.dart'; // Importa o CustomAppBar

class EditContacts extends StatelessWidget {
  final Users? contact;

  const EditContacts({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Editar Contato', // Título dinâmico
        showBackButton: true, // Exibe o botão de voltar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              label: 'Nome',
              icon: Icons.person,
              initialValue: contact?.name,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              label: 'Telefone',
              icon: Icons.phone,
              initialValue: contact?.telefone,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              label: 'Email',
              icon: Icons.email,
              initialValue: contact?.email,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Espaçamento entre os botões
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Volta para a tela anterior
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Salvar'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Implementar a lógica para excluir contato
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmar Exclusão'),
                          content: const Text(
                              'Tem certeza de que deseja excluir este contato?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Fecha o diálogo
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Lógica para excluir o contato
                                // Exemplo: Remover contato de uma lista ou banco de dados
                                Navigator.pop(context); // Fecha o diálogo
                                Navigator.pop(context); // Volta para a tela anterior
                              },
                              child: const Text('Excluir'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Excluir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Método para criar campos de texto reutilizáveis
  Widget _buildTextField({
    required String label,
    required IconData icon,
    String? initialValue,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
      controller: TextEditingController(text: initialValue),
    );
  }
}
