import 'dart:async';
import 'package:demo_project/common/local_storage.dart';
import 'package:demo_project/pages/login/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:demo_project/common/page_scaffold.dart';
import 'package:demo_project/api/user_api.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  bool agree = false;
  bool isCodeSent = false; // 是否已发送验证码
  String? sentCode; // 存储发送的验证码
  int countdown = 30; // 30秒倒计时
  Timer? _timer; // 用于倒计时

// 发送验证码
  Future<void> _sendCode() async {
    if (_emailController.text.isEmpty) {
      SmartDialog.showToast('请输入邮箱');
      return;
    }

    // 调用发送验证码接口
    SmartDialog.showLoading(msg: '正在发送验证码...');
    var response = await UserApi().sendEmailVerificationCode(_emailController.text);
    if (response.code == 200) {
      setState(() {
        isCodeSent = true;
        countdown = 30; // 重置倒计时为30秒
      });
      SmartDialog.dismiss();
      SmartDialog.showToast('验证码已发送，请查收');
      _startCountdown(); // 开始倒计时
    } else {
      SmartDialog.dismiss();
      SmartDialog.showToast('发送验证码失败，请重试');
    }
  }

  // 启动倒计时
  void _startCountdown() {
    _timer?.cancel(); // 清除之前的定时器
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          isCodeSent = false;
        });
      }
    });
  }

  // 登录逻辑
  Future<void> _login() async {
    if (!agree) {
      SmartDialog.showToast('请先阅读并同意隐私政策与用户协议');
      return;
    }

    if (_emailController.text.isEmpty || _codeController.text.isEmpty) {
      SmartDialog.showToast('请输入邮箱和验证码');
      return;
    }

    SmartDialog.showLoading(msg: '登录校验中');
    try {
      var resp = await UserApi().login(_codeController.text, _emailController.text);
      if (resp.code != 200) {
        SmartDialog.dismiss();
        SmartDialog.showNotify(
          msg: resp.message ?? '登录失败',
          notifyType: NotifyType.failure,
        );
        return;
      }
      LocalStorage.user_token.set(resp.data);
      SmartDialog.showNotify(msg: '登录成功', notifyType: NotifyType.success);
      SmartDialog.dismiss();
      Navigator.of(context).pop();
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showNotify(msg: '发生错误，请稍后重试', notifyType: NotifyType.failure);
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // 页面销毁时取消定时器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: const Text('登录'),
      actions: [],
      leading: getPopLeading(context, popTo: "/"),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset('assets/images/login_banner.png'),
              const SizedBox(height: 20),
              // 邮箱输入框
              _buildTextField(
                controller: _emailController,
                label: '邮箱',
                hintText: '请输入您的邮箱',
                icon: Icons.email,
              ),
              const SizedBox(height: 16),
              // 验证码输入框和发送验证码按钮在同一行
              _buildCodeAndSendButton(),
              const SizedBox(height: 16),
              // 隐私政策与用户协议复选框
              _buildCheckbox(),
              const SizedBox(height: 16),
              // 登录按钮
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  // 构建文本输入框
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),
      ),
    );
  }

  // 构建验证码输入框和发送验证码按钮
  Widget _buildCodeAndSendButton() {
    return Row(
      children: [
        // 验证码输入框
        Expanded(
          child: _buildTextField(
            controller: _codeController,
            label: '验证码',
            hintText: '请输入验证码',
            icon: Icons.lock,
          ),
        ),
        const SizedBox(width: 10), // 在输入框和按钮之间添加一些间距
        // 发送验证码按钮
        SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: isCodeSent ? null : _sendCode, // 已发送验证码后禁用按钮
            child: isCodeSent ? Text('$countdown秒后重试') : const Text('发送验证码'),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 构建复选框：隐私政策和用户协议
  Widget _buildCheckbox() {
    return CheckboxListTile(
      value: agree,
      contentPadding: EdgeInsets.zero,
      title: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: '已阅读并同意'),
            TextSpan(
              text: '隐私政策',
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // 跳转到隐私政策页面
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                  );
                },
            ),
            const TextSpan(text: '与'),
            TextSpan(
              text: '用户协议',
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // 跳转到用户协议页面
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserAgreementPage()),
                  );
                },
            ),
          ],
        ),
      ),
      onChanged: (bool? value) {
        setState(() {
          agree = value ?? false;
        });
      },
    );
  }

  // 构建登录按钮
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _login,
        child: const Text('登录'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}