
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/datasource/user_data_source.dart';
import '../profile/state/profile_state.dart';

class RoleSelectionPage extends ConsumerStatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  ConsumerState<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends ConsumerState<RoleSelectionPage> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Selecciona tu rol')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
              IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    onPressed: () async {
                      ref.read(signOutStateProvider);
                    },
                  ),
            const Text(
              'Nota: No se pueden revertir los cambios.',
              style: TextStyle(color: Colors.redAccent),
            ),
            const SizedBox(height: 20),
            _buildRoleOption(context, 'cliente'),
            const SizedBox(height: 10),
            _buildRoleOption(context, 'administrador'),
            const Spacer(),
            if (_selectedRole != null)
              ElevatedButton(
                onPressed: () async {
                  if (user != null) {
                    await ref
                        .read(userDataSourceProvider)
                        .updateUserRole(uid: user.uid, role: _selectedRole!);

                    // Redirige según rol
                    if (_selectedRole == 'user') {
                      context.go('/home');
                    } else {
                      context.go('/admin'); // define esta ruta
                    }
                  }
                },
                child: const Text('Continuar'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption(BuildContext context, String role) {
    final isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            role.toUpperCase(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
