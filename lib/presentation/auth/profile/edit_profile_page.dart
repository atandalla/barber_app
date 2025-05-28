import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/common.dart';
import '../../../core/routing/router.dart';
import '../../../domain/entity/image_type.dart';
import 'state/profile_state.dart';
import 'widgets/profile_image.dart';

class EditProfilePage extends ConsumerWidget {
  EditProfilePage({
    super.key,
  });

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserStateProvider);

    return user.when(
      data: (user) => CommonPageScaffold(
        title: 'Editar Perfil',
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileImageUpdater(
                imageUrl: user.avatar,
                userId: user.uid,
                type: ImageType.avatar,
              ),
              GapWidgets.h16,
              ProfileImageUpdater(
                imageUrl: user.cover,
                userId: user.uid,
                type: ImageType.cover,
              ),
              GapWidgets.h16,
              TextField(
                controller: firstNameController..text = user.firstName ?? '',
                decoration: const InputDecoration(
                  labelText: 'Tu nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              GapWidgets.h16,
              TextField(
                controller: lastNameController..text = user.lastName ?? '',
                decoration: const InputDecoration(
                  labelText: 'Tu apellido',
                  border: OutlineInputBorder(),
                ),
              ),
              GapWidgets.h16,
              TextField(
                controller: bioController..text = user.bio ?? '',
                decoration: const InputDecoration(
                  labelText: 'Tu Biografía',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              GapWidgets.h16,
              HighlightButton(
                onPressed: () {
                  ref.read(
                    editProfileStateProvider(
                      EditProfileData(
                        uid: user.uid,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        bio: bioController.text,
                      ),
                    ),
                  );
                  AppRouter.pop(context);
                },
                text: 'Guardar Cambios',
              ),
            ],
          ),
        ),
      ),
      error: (_, __) {
        return const CommonPageScaffold(
          title: 'Error',
          child: Text('Error Loading User!'),
        );
      },
      loading: () {
        return const CommonPageScaffold(
          title: 'Loading...',
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
