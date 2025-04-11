import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("隐私政策")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '隐私政策',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                '1. 数据收集：我们可能会收集您的个人信息，例如姓名、联系方式和使用日志等，来改善我们的服务。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '2. 数据使用：收集的个人信息将用于提供和改进我们的应用服务，处理您的请求以及个性化您的使用体验。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '3. 数据共享：我们不会将您的个人信息出售或与第三方共享，除非我们得到您的明确同意或为法律要求的情况。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '4. 数据保护：我们将采取适当的技术和管理措施来保护您的个人信息，防止未经授权的访问、修改或披露。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '5. 用户权利：您有权随时访问、更正或删除您的个人信息，并且有权撤销已授予的任何同意。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '6. 政策更新：我们可能会定期更新隐私政策，所有更改将会发布在本页面上。',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserAgreementPage extends StatelessWidget {
  const UserAgreementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("用户协议")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '用户协议',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                '1. 账号注册：用户必须提供真实、准确的注册信息，并根据应用的要求创建账户，用户需要对自己的账户信息和密码保密。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '2. 服务内容：本应用提供包括但不限于信息查询、数据存储等服务。用户可以根据自身需求选择和使用不同的功能模块。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '3. 用户责任：用户应保证使用本应用的行为合法，并不得通过本应用进行任何非法活动。用户对其行为负责，因其行为产生的所有后果由用户承担。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '4. 隐私保护：我们承诺保护用户隐私信息，未经用户同意，任何时候不会泄露用户的个人数据。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '5. 知识产权：用户使用本应用时，不得侵犯本应用的知识产权，包括但不限于版权、商标、专利等。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '6. 服务中断：若因不可抗力或技术原因导致服务中断或暂停，用户同意本应用不承担任何责任。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '7. 协议修改：本应用有权随时修改本协议条款，修改后的协议会在应用内公示，用户继续使用本应用即视为接受修改后的条款。',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '8. 适用法律：本协议适用中华人民共和国的法律，如发生争议，双方应友好协商解决。',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}