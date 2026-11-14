import '../models/transferencia.dart';
import '../models/contato.dart';
import 'configuracao_persistencia.dart';
import '../database/app_database.dart' as bancoLocal;
import '../services/api_service.dart';

abstract class BankRepository {
  // busca a lista de transferências.
  Future<List<Transferencia>> buscarTransferencias();

  // salva uma nova transferência.
  Future<void> salvarTransferencia(Transferencia transferencia);

  // busca a lista de contatos.
  Future<List<Contato>> buscarContatos();

  // salva um novo contato.
  Future<void> salvarContato(Contato contato);
}

class BankRepositoryLocal implements BankRepository {
  @override
  Future<List<Transferencia>> buscarTransferencias() {
    // busca as transferências no banco local SQLite.
    return bancoLocal.buscarTransferencias();
  }

  @override
  Future<void> salvarTransferencia(Transferencia transferencia) async {
    await bancoLocal.salvarTransferencia(transferencia);
  }

  @override
  Future<List<Contato>> buscarContatos() {
    // busca os contatos no banco local SQLite.
    return bancoLocal.buscarContatos();
  }

  @override
  Future<void> salvarContato(Contato contato) async {
    // salva o contato no banco local SQLite.
    await bancoLocal.salvarContato(contato);
  }
}

class BankRepositoryRemoto implements BankRepository {
  @override
  Future<List<Transferencia>> buscarTransferencias() {
    // busca as transferências na API remota.
    return ApiService.buscarTransferencias();
  }

  @override
  Future<void> salvarTransferencia(Transferencia transferencia) async {
    // salva a transferência na API remota.
    await ApiService.salvarTransferencia(transferencia);
  }

  @override
  Future<List<Contato>> buscarContatos() {
    // busca os contatos na API remota.
    return ApiService.buscarContatos();
  }

  @override
  Future<void> salvarContato(Contato contato) async {
    // salva o contato na API remota.
    await ApiService.salvarContato(contato);
  }
}

class RepositorioBank {
  static BankRepository get instancia {
    // verifica qual origem foi definida na configuração.
    switch (ConfiguracaoPersistencia.origem) {      
      case OrigemPersistencia.local:
        return BankRepositoryLocal();      
      case OrigemPersistencia.remota:
        return BankRepositoryRemoto();
    }
  }
}