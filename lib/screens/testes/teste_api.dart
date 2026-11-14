import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/transferencia.dart';
import '../../models/contato.dart';

class TesteApi extends StatefulWidget {
  const TesteApi({super.key});

  @override
  State<TesteApi> createState() => _TesteApiState();
}

class _TesteApiState extends State<TesteApi> {
  String _resultado = 'nenhum teste executado ainda';
  bool _carregando = false;

  Future<void> _testarConexao() async {
    setState(() {
      _carregando = true;
      _resultado = 'testando conexão com a api...';
    });

    try {
      final mensagem = await ApiService.testarConexaoBanco();
      setState(() {
        _resultado = mensagem;
      });
    } catch (erro) {
      setState(() {
        _resultado = 'erro ao testar conexão: $erro';
      });
    } finally {
      // o finally sempre será executado, dando certo ou dando erro.
      // aqui usamos para encerrar o carregamento.
      setState(() {
        _carregando = false;
      });
    }
  }

  Future<void> _listarTransferencias() async {
    setState(() {
      _carregando = true;
      _resultado = 'buscando transferências...';
    });

    try {
      final transferencias = await ApiService.buscarTransferencias();
      setState(() {
        _resultado = transferencias.isEmpty
            ? 'nenhuma transferência encontrada na api'
            : transferencias.join('\n');
      });
    } catch (erro) {
      setState(() {
        _resultado = 'erro ao buscar transferências: $erro';
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  Future<void> _criarTransferenciaTeste() async {
    setState(() {
      _carregando = true;
      _resultado = 'criando transferência de teste...';
    });

    try {
      final transferencia = Transferencia(25.50, 1234);
      await ApiService.salvarTransferencia(transferencia);
      setState(() {
        _resultado = 'transferência de teste criada com sucesso';
      });
    } catch (erro) {
      setState(() {
        _resultado = 'erro ao criar transferência: $erro';
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  Future<void> _listarContatos() async {
    setState(() {
      _carregando = true;
      _resultado = 'buscando contatos...';
    });

    try {
      final contatos = await ApiService.buscarContatos();
      setState(() {
        _resultado = contatos.isEmpty
            ? 'nenhum contato encontrado na api'
            : contatos.join('\n');
      });
    } catch (erro) {
      setState(() {
        _resultado = 'erro ao buscar contatos: $erro';
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  Future<void> _criarContatoTeste() async {
    setState(() {
      _carregando = true;
      _resultado = 'criando contato de teste...';
    });

    try {
      final contato = Contato(nome: 'Contato Flutter', numeroConta: 4321);
      await ApiService.salvarContato(contato);
      setState(() {
        _resultado = 'contato de teste criado com sucesso';
      });
    } catch (erro) {
      setState(() {
        _resultado = 'erro ao criar contato: $erro';
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // barra superior da tela.
      appBar: AppBar(title: const Text('Teste da API')),

      // corpo da tela.
      body: SingleChildScrollView(
        child: Padding(
          // espaçamento interno em todos os lados da tela.
          padding: const EdgeInsets.all(16.0),

          // organiza os elementos verticalmente.
          child: Column(
            // faz os widgets ocuparem toda a largura disponível.
            // crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              // botão usado para iniciar o teste de conexão.
              ElevatedButton(
                // se estiver carregando, o botão fica desabilitado.
                // caso contrário, chama a função _testarConexao.
                onPressed: _carregando ? null : _testarConexao,

                child: const Text('Testar conexão com o banco remoto'),
              ),

              // espaçamento vertical entre o botão e os próximos elementos.
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _carregando ? null : _listarTransferencias,
                child: const Text('Listar transferências da API'),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _carregando ? null : _criarTransferenciaTeste,
                child: const Text('Criar transferência teste na API'),
              ),

              // espaçamento vertical.
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _carregando ? null : _listarContatos,
                child: const Text('Listar Contatos da API'),
              ),

              // espaçamento vertical.
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _carregando ? null : _criarContatoTeste,
                child: const Text('Criar contato teste na API'),
              ),

              // espaçamento vertical.
              const SizedBox(height: 24),

              // se _carregando for true, exibe o indicador de carregamento.
              if (_carregando) const Center(child: CircularProgressIndicator()),

              // espaçamento vertical.
              const SizedBox(height: 24),

              // exibe o resultado do teste na tela.
              // pode ser a mensagem inicial, uma mensagem de sucesso ou uma mensagem de erro.
              Text(_resultado, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}