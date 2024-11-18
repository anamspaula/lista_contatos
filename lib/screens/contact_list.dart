import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_app_bar.dart';
import 'add_contact_screen.dart';
import 'search_contacts_widget.dart'; // Importa o novo widget de busca

class ContactList extends StatelessWidget {
  ContactList({super.key});

  // Lista de contatos mockados
  final List<Map<String, String>> contacts = [
    {'Nome': 'Ana', 'Telefone': '1234-5678', 'Email': 'ana@teste.com'},
    {'Nome': 'Bruno', 'Telefone': '9876-5432', 'Email': 'bruno@teste.com'},
    {'Nome': 'Carlos', 'Telefone': '5555-5555', 'Email': 'carlos@teste.com'},
    {'Nome': 'Diana', 'Telefone': '1111-2222', 'Email': 'diana@teste.com'},
    {'Nome': 'Eduardo', 'Telefone': '3333-4444', 'Email': 'eduardo@teste.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Contatos',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddContactScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchContactsWidget(contacts: contacts), // Novo widget de busca
          ],
        ),
      ),
    );
  }
}
