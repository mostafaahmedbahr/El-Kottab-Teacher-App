import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/otp/presentation/views/widgets/resend_phone_otp_view_widgets/resend_email_otp_view_body.dart';

import '../../../../main_imports.dart';

class ResendPhoneOtpView extends StatelessWidget {
  const ResendPhoneOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOlive,
      appBar: AppBar(
        backgroundColor: AppColors.darkOlive,
        title: Text(
          LangKeys.resendEmailOtp.tr(),
          style: TextStyle(color: AppColors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
      ),
      body: ResendEmailOtpViewBody(),
    );
  }
}
