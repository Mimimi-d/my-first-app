import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_first_app/ui/calendar/calendar_card.dart';

import '../bottom_navigation/botom_navigation.dart';
import '../home/home_page.dart';

// ユーザー情報の受け渡しを行うためのProvider
final userProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser;
});

// エラー情報の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final infoTextProvider = StateProvider.autoDispose((ref) {
  return '';
});

// メールアドレスの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final emailProvider = StateProvider.autoDispose((ref) {
  return '';
});

// パスワードの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final passwordProvider = StateProvider.autoDispose((ref) {
  return '';
});

// メッセージの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final messageTextProvider = StateProvider.autoDispose((ref) {
  return '';
});

// StreamProviderを使うことでStreamも扱うことができる
// ※ autoDisposeを付けることで自動的に値をリセットできます
final postsQueryProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('date')
      .snapshots();
});

// ConsumerWidgetでProviderから値を受け渡す
class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから値を受け取る
    final infoText = ref.watch(infoTextProvider.state).state;
    final email = ref.watch(emailProvider.state).state;
    final password = ref.watch(passwordProvider.state).state;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'メールアドレス'),
              onChanged: (String value) {
                // Providerから値を更新
                ref.read(emailProvider.state).state = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,
              onChanged: (String value) {
                // Providerから値を更新
                ref.read(passwordProvider.state).state = value;
              },
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(infoText),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('ユーザー登録'),
                onPressed: () async {
                  try {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final result = await auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    // ユーザー情報を更新
                    ref.read(userProvider.state).state = result.user;

                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }),
                    );
                  } catch (e) {
                    // Providerから値を更新
                    ref.read(infoTextProvider.state).state =
                        "登録に失敗しました：${e.toString()}";
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  try {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return BottomNavigation();
                      }),
                    );
                  } catch (e) {
                    // Providerから値を更新
                    ref.read(infoTextProvider.state).state =
                        "ログインに失敗しました：${e.toString()}";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
