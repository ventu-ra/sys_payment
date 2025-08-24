# 💳 Transactions API

API simples em **Ruby on Rails** para processar e armazenar transações de cartão de crédito.
Inclui validação de número de cartão, moeda e valor.

---

## 🚀 Requisitos

- Ruby **3.2+**
- Rails **7+**
- Banco de dados: **SQLite (dev/teste)** ou **PostgreSQL (produção)**

---

## ⚙️ Setup do Projeto

```bash
# Clonar repositório
git clone https://github.com/ventu-ra/transactions.API.git
cd transactions.API

# Instalar dependências
bundle install

# Criar e migrar o banco
bin/rails db:create db:migrate

# Subir o servidor
bin/rails server
```

Servidor disponível em: [http://127.0.0.1:3000](http://127.0.0.1:3000)

---

## 📡 Endpoints

### Criar Transação

```http
POST /transactions
Content-Type: application/json
```

**Body (JSON):**

```json
{
  "card_number": "5555556355564617",
  "amount": 100,
  "currency": "BRL"
}
```

**Response (201 Created):**

```json
{
  "status": "approved",
  "message": "Transaction approved"
}
```

---

### Listar Transações

```http
GET /transactions
```

**Response (200 OK):**

```json
[
  {
    "id": 1,
    "card_number": "4617",
    "amount": 100.0,
    "currency": "BRL",
    "status": "approved",
    "message": "Transaction approved"
  }
]
```

---

## ✅ Regras de Validação

- **Número do cartão**: precisa passar no algoritmo de **Luhn** e ser Visa, MasterCard ou Discover.
- **Moeda**: aceita apenas `USD`, `EUR`, `BRL`.
- **Valor**: deve ser maior que `0`.

---

## 🔒 Segurança

Este projeto é **didático**. Em produção:

- Nunca armazene o cartão completo (use tokenização).
- Use gateways reais (Stripe, PayPal, etc).

---

## 🧪 Testes

```bash
bin/rails test
```
