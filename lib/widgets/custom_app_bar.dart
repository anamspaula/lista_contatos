import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; // Botões personalizados no lado direito
  final bool showBackButton; // Controla se o botão de voltar deve aparecer

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true, // Por padrão, o botão de voltar é exibido
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.bold,
          color: Colors.white
          ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: showBackButton, 
      backgroundColor: Colors.blue,// Controla o botão de voltar
      iconTheme: const IconThemeData(
        color: Colors.white, // Cor do ícone de voltar
      ),
      actions: actions, // Adiciona os botões personalizados
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
