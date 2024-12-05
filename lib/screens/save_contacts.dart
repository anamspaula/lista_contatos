import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/data/model/return_api_users.dart';
import 'package:myapp/data/model/users_edit_model.dart';
import 'package:myapp/data/model/users_model.dart';
import 'package:myapp/screens/stores/users_strore.dart';
import 'package:myapp/widgets/custom_app_bar.dart';

class SaveContacts extends StatefulWidget {
  final UsersStrore usersStore;

  const SaveContacts({
    super.key,
    required this.usersStore
  });

  @override
  _SaveContactsState createState() => _SaveContactsState();
}

class _SaveContactsState extends State<SaveContacts> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
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
        title: 'Salvar Contato',
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

                    if (name.isEmpty || telefone.isEmpty || email.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Por favor, preencha todos os campos.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }

                    try {
                      // Chama a função save e verifica se foi bem-sucedido
                      ReturnApiUsers<Users> isCreated = await widget.usersStore.save(
                        user: UsersEdit(
                          name: name,
                          email: email,
                          telefone: telefone,
                        ),
                      );

                      if (isCreated.code == 200) {
                        // Exibe o toast informando que foi salvo com sucesso
                        if (mounted) {
                          Fluttertoast.showToast(
                            msg: "Contato salvo com sucesso!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          Navigator.pop(context, true); // Retorna à tela anterior
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Erro ao salvar o contato.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    } catch (e) {
                      // Caso ocorra um erro
                      Fluttertoast.showToast(
                        msg: "Erro ao salvar o contato.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
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
