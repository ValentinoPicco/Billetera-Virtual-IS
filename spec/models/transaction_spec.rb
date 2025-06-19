require 'spec_helper'

RSpec.describe Transaction do

  let(:user1) { User.create!(name: "Alice", email: "alice@exampl.com", password: "secret123", surname: "Perez", dni: "1101010", tel: "991919191919", address: "Muniz 123") }
  let(:user2) { User.create!(name: "Bob", email: "bob@example.com", password: "secret123", surname: "Alvarez", dni: "77777777", tel: "554545553", address: "Antolin 123") }

  let(:source_account) do
    Account.create!(
      user: user1,
      cvu: rand(10**9..10**10),
      alias: "alice.cuenta",
      total_balance: 10000,
      creation_date: Date.today,
      password: "clave123"
    )
  end

  let(:target_account) do
    Account.create!(
      user: user2,
      cvu: rand(10**9..10**10),
      alias: "bob.cuenta",
      total_balance: 50000,
      creation_date: Date.today,
      password: "clave456"
    )
  end

  let(:user3) do
    User.create!(
      name: "Clara",
      surname: "Gómez",
      email: "clara@example.com",
      password: "secret123",
      dni: "22333444",
      tel: "1134567890",
      address: "Independencia 456"
    )
  end

  let(:user4) do
    User.create!(
      name: "David",
      surname: "Martínez",
      email: "david@example.com",
      password: "secret123",
      dni: "33445566",
      tel: "1155556666",
      address: "Sarmiento 987"
    )
  end

  let(:user5) do
    User.create!(
      name: "Eva",
      surname: "López",
      email: "eva@example.com",
      password: "secret123",
      dni: "44556677",
      tel: "1166667777",
      address: "Belgrano 123"
    )
  end

  let(:user6) do
    User.create!(
      name: "Fernando",
      surname: "Pérez",
      email: "fernando@example.com",
      password: "secret123",
      dni: "55667788",
      tel: "1177778888",
      address: "Mitre 456"
    )
  end

  let(:account3) do
    Account.create!(
      user: user3,
      cvu: rand(10**9..10**10),
      alias: "clara.cuenta",
      total_balance: 30000,
      creation_date: Date.today,
      password: "clave789"
    )
  end

  let(:account4) do
    Account.create!(
      user: user4,
      cvu: rand(10**9..10**10),
      alias: "david.cuenta",
      total_balance: 40000,
      creation_date: Date.today,
      password: "clave321"
    )
  end

  let(:account5) do
    Account.create!(
      user: user5,
      cvu: rand(10**9..10**10),
      alias: "eva.cuenta",
      total_balance: 60000,
      creation_date: Date.today,
      password: "clave654"
    )
  end

  let(:account6) do
    Account.create!(
      user: user6,
      cvu: rand(10**9..10**10),
      alias: "fernando.cuenta",
      total_balance: 25000,
      creation_date: Date.today,
      password: "clave987"
    )
  end



  context 'validations' do
    it 'no permite crear transacción si no hay saldo suficiente' do
      transaction = Transaction.new(
        source_account: source_account,
        target_account: target_account,
        value: 15000000,
        no_operation: SecureRandom.hex(5),
        date: Date.today,
        transaction_type: 0
      )

      expect(transaction).not_to be_valid
      expect(transaction.errors[:base]).to include("Saldo insuficiente en la cuenta del remitente.")
    end

    it 'permite crear transacción si hay saldo suficiente' do
      transaction = Transaction.new(
        source_account: account3,
        target_account: account4,
        value: 5000,
        no_operation: SecureRandom.hex(5),
        date: Date.today,
        transaction_type: 0
      )

      expect(transaction).to be_valid
    end
  end

  context 'after create callback' do
    it 'debita y acredita los balances correctamente' do
      transaction = Transaction.create!(
        source_account: account5,
        target_account: account6,
        value: 4000,
        no_operation: SecureRandom.hex(5),
        date: Date.today,
        transaction_type: 0
      )

      expect(account5.reload.total_balance).to eq(60000)
      expect(account6.reload.total_balance).to eq(25000)
    end
  end
end
