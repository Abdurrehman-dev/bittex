import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/all_utilities.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const String routeName = "/privacy_policy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy', style: AppTheme.font)),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'This SERVICE is provided at no cost and is intended for use as is.\n\nThis page is used to inform app, game and website visitors regarding my policies with the collection, use, and\ndisclosure of Personal Information if anyone decided to use my Service.\n\nIf you choose to use my Service, then you agree to the collection and use of information in relation\nto this policy. The Personal Information that I collect is used for providing and improving the\nService. I will not use or share your information with anyone except as described\nin this Privacy Policy.\n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible unless otherwise defined in this Privacy Policy.',
                      style: Theme.of(context).textTheme.bodyText2,
                      children: [
                        TextSpan(
                          text: '\n\nInformation Collection and Use\n\n',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(
                            text:
                                'For a better experience, while using our Service, I may require you to provide us with certain\npersonally identifiable information, including but not limited to We made free games for user for their better experience.. The information that I request is retained on your device and is not collected by me in any way\n\nThe app does use third party services that may collect information used to identify you.'),
                        TextSpan(
                          text: '\n\nLog Data\n\n',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(
                            text:
                                'I want to inform you that whenever you use my Service, in a case of an\nerror in the app I collect data and information (through third party products) on your phone\ncalled Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address,\ndevice name, operating system version, the configuration of the app when utilizing my Service,\nthe time and date of your use of the Service, and other statistics.'),
                        TextSpan(
                          text: '\n\nService Providers\n\n',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(
                            text:
                                'I may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nI want to inform users of this Service that these third parties have access to your\nPersonal Information. The reason is to perform the tasks assigned to them on our behalf. However, they\nare obligated not to disclose or use the information for any other purpose.'),
                        TextSpan(
                          text: '\n\nSecurity\n\n',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(
                            text:
                                'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.'),
                        TextSpan(
                          text: '\n\nLinks to Other Sites\n\n',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(
                            text:
                                'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.'),
                        TextSpan(
                          text: '\n\nChildren’s Privacy\n\n',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(
                            text:
                                'These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do necessary actions.'),
                        TextSpan(
                          text: '\n\nChanges to This Privacy Policy\n\n',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(
                            text:
                                'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.'),
                        TextSpan(
                          text: '\n\nContact Us\n\n',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(
                            text:
                                'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me.\n\n'),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
