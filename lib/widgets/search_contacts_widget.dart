import 'package:flutter/material.dart';
import 'package:myapp/data/model/users_model.dart';
import 'package:myapp/screens/edit_contacts.dart';
import 'package:myapp/screens/stores/users_strore.dart';

class SearchContactsWidget extends StatefulWidget {
  final UsersStrore usersStrore;

  const SearchContactsWidget({super.key, required this.usersStrore});

  @override
  State<SearchContactsWidget> createState() => _SearchContactsWidgetState();
}

class _SearchContactsWidgetState extends State<SearchContactsWidget> {
  final TextEditingController _searchController = TextEditingController();
  Users? _searchResult;

  void _searchContact() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResult = widget.usersStrore.state.value.firstWhere(
        (contact) => contact.name.toLowerCase().contains(query),
        orElse: () => Users(
          id: "id",
          name: "name",
          email: "email",
          telefone: "telefone",
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    widget.usersStrore.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Buscar',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 16.0),
        AnimatedBuilder(
          animation: Listenable.merge([
            widget.usersStrore.error,
            widget.usersStrore.isLoading,
            widget.usersStrore.state
          ]),
          builder: (context, child) {
            if (widget.usersStrore.isLoading.value) {
              return const CircularProgressIndicator();
            }

            if(widget.usersStrore.error.value.isNotEmpty){
              return Card(
                elevation: 2,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Erro ao tentar conectar com o db ${widget.usersStrore.error.value}'),
                    ],
                  ),
                ),
              );
            }

            if (widget.usersStrore.state.value.isEmpty) {
              return Card(
                elevation: 2,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Não foi possível encontrar nenhum usuário"),
                    ],
                  ),
                ),
              );
            } else {
              return Card(
                elevation: 2,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          _searchResult!.name[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _searchResult!.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(_searchResult!.telefone),
                            Text(_searchResult!.email),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditContacts(
                                contact: _searchResult!,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        ElevatedButton(
          onPressed: _searchContact,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const Text('Procurar'),
        ),
      ],
    );
  }
}
