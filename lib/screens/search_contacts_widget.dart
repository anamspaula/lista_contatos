import 'package:flutter/material.dart';
import 'package:myapp/screens/edit_contacts.dart';

class SearchContactsWidget extends StatefulWidget {
  final List<Map<String, String>> contacts;

  const SearchContactsWidget({super.key, required this.contacts});

  @override
  State<SearchContactsWidget> createState() => _SearchContactWindgetsState();
}

class _SearchContactWindgetsState extends State<SearchContactsWidget> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, String>? _searchResult;

  void _searchContact() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResult = widget.contacts.firstWhere(
        (contact) => contact['Nome']!.toLowerCase().contains(query),
        orElse: () => {'Nome': 'Nenhum contato encontrado'},
      );
    });
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
        if (_searchResult != null)
          Card(
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
                      _searchResult!['Nome']![0],
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
                          _searchResult!['Nome']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (_searchResult!.containsKey('Telefone'))
                          Text('${_searchResult!['Telefone']}'),
                        if (_searchResult!.containsKey('Email'))
                          Text('${_searchResult!['Email']}'),
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
