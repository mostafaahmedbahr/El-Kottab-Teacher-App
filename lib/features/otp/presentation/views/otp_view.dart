import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/otp/presentation/views/widgets/otp_texts.dart';
import 'package:el_kottab_teacher_app/features/otp/presentation/views/widgets/pin_code_fields_widget.dart';
import 'package:el_kottab_teacher_app/features/otp/presentation/views/widgets/verify_otp_button.dart';
import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../main_imports.dart';
import '../../../login/presentation/views/widgets/logo_widget.dart';
import '../../data/repos/otp_repo_impl.dart';
import '../view_model/otp_cubit.dart';
import '../view_model/otp_states.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.goToLayoutOrResetPassword, required this.email});
  final String goToLayoutOrResetPassword;
  final String email;
  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangKeys.verifyOtpCode.tr(),),
      ),
      body: BlocProvider(
        create: (context)=>OtpCubit(getIt.get<OtpRepoImpl>()),
        child: BlocBuilder<OtpCubit, OtpStates>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding:   EdgeInsets.all(20.0.r),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      Scaffold.of(context).appBarMaxHeight! -
                      MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                         const Logo(),
                        const OtpTexts(),
                         Gap(50.h),
                        PinCodeFieldsWidget(controller: _otpController),
                        Gap(20.h),
                         // const ResendCodeWidget(),
                      ],
                    ),
                    Column(
                      children: [
                        VerifyOtpButton(controller: _otpController,goToLayoutOrResetPassword: widget.goToLayoutOrResetPassword,email:widget.email ,),
                        SizedBox(
                          height: 80.h + MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}