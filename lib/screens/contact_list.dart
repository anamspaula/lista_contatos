import 'package:flutter/material.dart';
import 'package:myapp/https/https_client.dart';
import 'package:myapp/repository/users_repository.dart';
import 'package:myapp/screens/stores/users_strore.dart';
import 'package:myapp/widgets/custom_app_bar.dart';
import 'add_contact_screen.dart';
import '../widgets/search_contacts_widget.dart'; // Importa o novo widget de busca

class ContactList extends StatelessWidget {
  ContactList({super.key});

  final UsersStrore users = UsersStrore(repository: UsersRepository(client: HttpsClient()));
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
            SearchContactsWidget(usersStrore: users,), // Novo widget de busca
          ],
        ),
      ),
    );
  }
}
