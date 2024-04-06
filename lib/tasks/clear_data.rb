# frozen_string_literal: true

namespace :clear_data do
  task except_meta: :env do
    BetResult.destroy_all
    WinLossDetail.destroy_all
    GameTransaction.destroy_all
    UserRecord.destroy_all
    BankStatement.destroy_all
    UserTransaction.destroy_all
    DepositCryptoAddress.update_all(locked_at: nil, locked_by_id: nil)
    User.destroy_all
    Settlement.update_all(outstanding: 0)
    Agent.all.each do |agent|
      agent.send(:create_win_loss_detail)
    end
  end
end
