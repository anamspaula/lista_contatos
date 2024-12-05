import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/data/model/return_api_users.dart';
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

  @override
  void initState() {
    super.initState();
    _initializeUsers();
  }

  void _initializeUsers() async {
    // Carrega os usuários e realiza a busca quando o carregamento terminar
    await widget.usersStrore.getUsers(); // Espera o carregamento
    _searchContact(); // Realiza a busca após o carregamento
  }

  void _searchContact() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResult = widget.usersStrore.state.value!
          .where((contact) => contact.name.toLowerCase().contains(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: (query) {
            _searchContact(); // Refiltra sempre que o texto mudar
          },
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
          animation: Listenable.merge([widget.usersStrore.isLoading, widget.usersStrore.state, widget.usersStrore.error]),
          builder: (context, child) {
            if (widget.usersStrore.isLoading.value) {
              return const CircularProgressIndicator();
            }

            if (widget.usersStrore.error.value.isNotEmpty) {
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
                    children: [
                      Expanded(
                        child: Text(
                          'Erro ao tentar conectar com o db ${widget.usersStrore.error.value}',
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (_searchResult.isEmpty) {
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
                  child: const Text("Não foi possível encontrar nenhum usuário"),
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
                              user.name[0],
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
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditContacts(
                                    contact: user,
                                    usersStore: widget.usersStrore,
                                    onEditSuccess: (bool success) {
                                      if (success) {
                                        _initializeUsers();  // Atualiza a lista de usuários
                                      } else {
                                        // Tratar falha de edição, por exemplo, mostrando um alerta
                                      }
                                    }
                                  ),
                                ),
                              );

                              if(result == true){
                                _initializeUsers();
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
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
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          try {
                                            // Chama a função editUsers e verifica se foi bem-sucedido
                                            ReturnApiUsers<Null> isDeleted = await widget.usersStrore.deleteUsers(
                                              id: user.id,
                                            );

                                            if (isDeleted.code == 200) {
                                              // Exibe o toast informando que foi atualizado com sucesso
                                              Fluttertoast.showToast(
                                                msg: isDeleted.message,
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0,
                                              );

                                              if(mounted){
                                                _initializeUsers();
                                                Navigator.pop(context);
                                              }
                                            }
                                          } catch (e) {
                                            // Caso ocorra um erro
                                            Fluttertoast.showToast(
                                              msg: e.toString(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          }
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
                ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
