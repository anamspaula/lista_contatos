import 'package:flutter/material.dart';
import 'package:myapp/data/model/users_model.dart';
import 'package:myapp/screens/edit_contacts.dart';
import 'package:myapp/screens/stores/users_strore.dart';

class SearchContactsWidget extends StatefulWidget {
  final UsersStrore usersStrore;

  const SearchContactsWidget({super.key, required this.usersStrore});

  @override
  State<SearchContactsWidget> createState() => _SearchContactsWidgetState();

  // @override
  // State<SearchContactsWidget> createUsersState() => this.usersStrore.getUsers;
}

class _SearchContactsWidgetState extends State<SearchContactsWidget> {
  final TextEditingController _searchController = TextEditingController();
  Iterable<Users> _searchResult = <Users>[];

  void _searchContact() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResult = widget.usersStrore.state.value!.where(
        (contact) => contact.name.toLowerCase().contains(query)
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeUsers();
  }

  void _initializeUsers() async {
    final users = await widget.usersStrore.getUsers() as Iterable<Users>;
    setState(() {
      _searchResult = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
        //     DefaultTextStyle(
        //   style: Theme.of(context).textTheme.displayMedium!,
        //   textAlign: TextAlign.center,
        //   child: FutureBuilder<List<Users>>(
        //     future: widget.usersStrore.state.value, // a previously-obtained Future<String> or null
        //     builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
        //       List<Widget> children;
        //       if (snapshot.hasData) {
        //         children = <Widget>[
        //           const Icon(
        //             Icons.check_circle_outline,
        //             color: Colors.green,
        //             size: 60,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.only(top: 16),
        //             child: Text('Result: ${snapshot.data}'),
        //           ),
        //         ];
        //       } else if (snapshot.hasError) {
        //         children = <Widget>[
        //           const Icon(
        //             Icons.error_outline,
        //             color: Colors.red,
        //             size: 60,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.only(top: 16),
        //             child: Text('Error: ${snapshot.error}'),
        //           ),
        //         ];
        //       } else {
        //         children = const <Widget>[
        //           SizedBox(
        //             width: 60,
        //             height: 60,
        //             child: CircularProgressIndicator(),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(top: 16),
        //             child: Text('Awaiting result...'),
        //           ),
        //         ];
        //       }
        //       return Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: children,
        //         ),
        //       );
        //     },
        //   ),
        // ),

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
                      Expanded( // Adicionado para permitir que o texto quebre dentro do espaço disponível
                        child: Text(
                          'Erro ao tentar conectar com o db ${widget.usersStrore.error.value}',
                          textAlign: TextAlign.left, // Ajustado para alinhar corretamente
                          softWrap: true, // Permite quebra automática
                          overflow: TextOverflow.clip, // Corta o texto ao final do espaço
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (widget.usersStrore.state.value!.isEmpty) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _searchResult.map((user) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              user.name[0], // Primeiro caractere do nome
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
                                  user.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(user.telefone),
                                Text(user.email),
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
                                    contact: user,
                                    usersStore: widget.usersStrore,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }).toList(), // Converte o Iterable para uma lista
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
