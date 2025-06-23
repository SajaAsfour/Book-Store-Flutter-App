part of 'code_verification_cubit.dart';

@immutable
sealed class CodeVerificationState {}

final class CodeVerificationInitial extends CodeVerificationState {}
final class CodeVerificationSuccess extends CodeVerificationState {}
final class CodeVerificationLoading extends CodeVerificationState {}
final class CodeVerificationError extends CodeVerificationState {
  final String errorMsg;
   CodeVerificationError(this.errorMsg);
}