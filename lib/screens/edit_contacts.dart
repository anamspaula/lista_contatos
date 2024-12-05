import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/data/model/return_api_users.dart';
import 'package:myapp/data/model/users_edit_model.dart';
import 'package:myapp/data/model/users_model.dart';
import 'package:myapp/screens/stores/users_strore.dart';
import 'package:myapp/widgets/custom_app_bar.dart';

class EditContacts extends StatefulWidget {
  final Users? contact;
  final UsersStrore usersStore;
  final ValueChanged<bool> onEditSuccess;

  const EditContacts({
    super.key,
    required this.contact,
    required this.usersStore,
    required this.onEditSuccess,
  });

  @override
  _EditContactsState createState() => _EditContactsState();
}

class _EditContactsState extends State<EditContacts> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name);
    _phoneController = TextEditingController(text: widget.contact?.telefone);
    _emailController = TextEditingController(text: widget.contact?.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Editar Contato',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              label: 'Nome',
              icon: Icons.person,
              controller: _nameController,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              label: 'Telefone',
              icon: Icons.phone,
              controller: _phoneController,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              label: 'Email',
              icon: Icons.email,
              controller: _emailController,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String name = _nameController.text;
                    String telefone = _phoneController.text;
                    String email = _emailController.text;

                    try {
                      // Chama a função editUsers e verifica se foi bem-sucedido
                      ReturnApiUsers<Users> isUpdated = await widget.usersStore.editUsers(
                        id: widget.contact!.id,
                        user: UsersEdit(
                          name: name,
                          email: email,
                          telefone: telefone,
                        ),
                        onEditSuccess: (success) {
                          widget.onEditSuccess(success); 
                        },              
                      );

                      if (isUpdated.code == 200) {
                        // Exibe o toast informando que foi atualizado com sucesso
                        if(mounted){
                          Fluttertoast.showToast(
                            msg: "Contato atualizado com sucesso!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          // Navigator.pop(context, true);
                        }
                        
                      }
                    } catch (e) {
                      // Caso ocorra um erro
                      Fluttertoast.showToast(
                        msg: "Erro ao atualizar o contato.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
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
                                  ReturnApiUsers<Null> isDeleted = await widget.usersStore.deleteUsers(
                                    id: widget.contact!.id,
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
                                      Navigator.pop(context);
                                      Navigator.pop(context, true);
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
                  child: const Text('Excluir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
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
    );
  }
}