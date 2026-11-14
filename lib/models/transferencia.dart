class Transferencia {
  final int? id;

  // valor monetário da transferência.
  final double valor;

  // número da conta de destino da transferência.
  final int numeroConta;
  Transferencia(this.valor, this.numeroConta, {this.id});

  factory Transferencia.fromJson(Map<String, dynamic> json) {
    final valorRecebido = json['valor'];

    // variável que armazenará o valor convertido para double.
    double valorConvertido;

    // verifica se o valor recebido veio como String.
    if (valorRecebido is String) {
      // se veio como texto, converte para double.
      valorConvertido = double.parse(valorRecebido);
    } else {
      valorConvertido = (valorRecebido as num).toDouble();
    }

    return Transferencia(
      // valor já convertido para double.
      valorConvertido,
      json['numero_conta'],

      // id recebido da api.
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // envia o valor da transferência.
      'valor': valor,
      'numeroConta': numeroConta,
    };
  }

  @override
  String toString() {
    return 'Transferencia{id: $id, valor: $valor, numeroConta: $numeroConta}';
  }
}
