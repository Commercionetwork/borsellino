/// Contains the arguments.dart that must be passed to the VerifyMnemonicPage
/// to properly allow the verification of the mnemonic.
class VerifyMnemonicArguments {
  final List<String> mnemonic;

  VerifyMnemonicArguments(this.mnemonic) : assert(mnemonic != null);
}
