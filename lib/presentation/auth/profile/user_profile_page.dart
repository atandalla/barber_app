import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/common.dart';

import 'state/profile_state.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_info.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestedUser = ref.watch(userProfileProvider(userId));
    
    final currentUser = ref.watch(currentUserStateProvider).valueOrNull;
    

    if (currentUser == null) {
      return const CommonPageScaffold(
        title: 'NotFound',
        child: Text('You are not logged in!'),
      );
    }

    return requestedUser.when(
      data: (user) {
        if (user == null) {
          return const CommonPageScaffold(
            title: 'NotFound',
            child: Text('User Not Found!'),
          );
        }
        return CommonPageScaffold(
          title: user.name,
          actions: userId == user.uid
              ? [
                  IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    onPressed: () {
                      ref.read(signOutProvider);
                    },
                  ),
                ]
              : null,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(
                  coverImageUrl: user.cover,
                  profileImageUrl: user.avatar,
                  uid: user.uid,
                  currentUserId: currentUser.uid,
                ),
                ProfileInfo(
                  name: user.name,
                  email: user.email,
                  bio: user.bio,
                ),
                const Divider(),
            
        
             
              ],
            ),
          ),
        );
      },
      error: (error, _) {
        return CommonPageScaffold(
          title: 'Error',
          child: Text('Error: $error'),
        );
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
