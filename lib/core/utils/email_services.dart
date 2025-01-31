import 'package:email_otp/email_otp.dart';

abstract class EmailServices
{
  static init()
  {
    EmailOTP.config(
      appName: 'Travel Go',
      otpType: OTPType.numeric,
      expiry: 30000,
      emailTheme: EmailTheme.v4,
      appEmail: 'hishamaymen64@gmail.com',
      otpLength: 6,
    );
  }

  static sendOTP(String email)
  {
    EmailOTP.sendOTP(email: email);
  }
  static getOtp()
  {

    return EmailOTP.getOTP();
  }
  static verifyOTP(String otp)
  {
    return EmailOTP.verifyOTP(otp: otp);
  }
  static isExpired()
  {
    return EmailOTP.isOtpExpired();
  }
}