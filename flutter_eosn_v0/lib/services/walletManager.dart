import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:uuid/uuid.dart';

const CURRENT_WALLET_ACCOUNT = 'currentWalletAccount';

class WalletManager {
  List<WalletAccount> _walletAccounts = [];
  WalletAccount _currentAccount;
  FlutterSecureStorage _storage;

  WalletManager() {
    this._storage = FlutterSecureStorage();
    // _storage.deleteAll();
    this.fetchWalletFromSecureStorage();
  }

  set currentAccount(WalletAccount account) {
    this._currentAccount = account;
    _storage.write(key: CURRENT_WALLET_ACCOUNT, value: account.id);
  }

  WalletAccount get currentAccount {
    return _currentAccount;
  }

  Future<List<WalletAccount>> fetchWalletFromSecureStorage() async {
    Map<String, String> accounts = await _storage.readAll();

    String currentAccountId = accounts[CURRENT_WALLET_ACCOUNT];
    if (accounts[currentAccountId] != null) {
      _currentAccount = accountFromJson(accounts[currentAccountId]);
      accounts.remove(CURRENT_WALLET_ACCOUNT);
    }

    _walletAccounts = accounts.entries
        .map((account) => accountFromJson(account.value))
        .toList();
    return _walletAccounts;
  }

  Future<List<WalletAccount>> get walletAccounts async {
    await this.fetchWalletFromSecureStorage();
    return _walletAccounts;
  }

  void addAccount(String accountName, String publicKey, String privateKey) {
    try {
      String id = Uuid().v4();
      WalletAccount account = WalletAccount(
        id: id,
        accountName: accountName.trim(),
        publicKey: publicKey.trim(),
        privateKey: privateKey.trim(),
      );
      _storage.write(key: id, value: account.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void editAccount(String id,
      {String accountName, String publicKey, String privateKey}) async {
    try {
      WalletAccount accountToEdit =
          accountFromJson(await _storage.read(key: id));

      if (accountName != null) accountToEdit.accountName = accountName.trim();
      if (publicKey != null) accountToEdit.publicKey = publicKey.trim();
      if (privateKey != null) accountToEdit.privateKey = privateKey.trim();

      _storage.write(key: id, value: accountToEdit.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteAccount(String id) {
    try {
      _storage.delete(key: id);
    } catch (e) {
      print(e.toString());
    }
  }

  WalletAccount accountFromJson(String walletAccountAsString) {
    try {
      Map<String, dynamic> map = jsonDecode(walletAccountAsString);
      return WalletAccount(
          id: map['id'],
          publicKey: map['publicKey'],
          privateKey: map['privateKey'],
          accountName: map['accountName']);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
