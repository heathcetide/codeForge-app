import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/pages/pageScaffold.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _studentNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: const Text('登录'),
      actions: [],
      leading: getPopLeading(context, popTo: "/"),
      child: SingleChildScrollView(
        // 添加 SingleChildScrollView
        child: Column(
          children: [
            Image.asset('assets/images/login_banner.png'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.all(6.0)),
                  TextField(
                    controller: _studentNumberController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: '账号',
                      hintText: '请输入您的账号',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(6.0)),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: '密码',
                      prefixIcon: Icon(Icons.lock),
                      hintText: '请输入您的密码',
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(6.0)),
                  CheckboxListTile(
                    value: agree,
                    contentPadding: EdgeInsets.all(0),
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '已阅读并同意'),
                          TextSpan(
                            text: '隐私政策',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(text: '与'),
                          TextSpan(
                            text: '用户协议',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                    onChanged: (b) {
                      setState(() {
                        agree = b!;
                      });
                    },
                  ),
                  Padding(padding: const EdgeInsets.all(6.0)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!agree) {
                            SmartDialog.showToast('请先阅读并同意隐私政策与用户协议');
                            return;
                          }
                          SmartDialog.showLoading(msg: '登录校验中');
                          var resp = null;
                          if (resp['code'] != 0) {
                            SmartDialog.dismiss();
                            SmartDialog.showNotify(
                              msg: resp['msg'],
                              notifyType: NotifyType.failure,
                            );
                            return;
                          }
                          SmartDialog.showLoading(msg: '更新信息中');
                          SmartDialog.showNotify(
                            msg: '登录成功',
                            notifyType: NotifyType.success,
                          );
                          SmartDialog.dismiss();
                          Navigator.of(context).pop();
                        },
                        child: Text('登录'),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            // 修正 WidgetStateProperty 为 MaterialStateProperty
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
