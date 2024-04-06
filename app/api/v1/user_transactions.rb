module V1
  class UserTransactions < Base
    resources :user_transactions do
    
      desc 'This API allows user to get transactions',
           summary: 'Transactions',
           success: { code: 200, model: Entities::V1::UserTransactionResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      params do
        optional :transaction_type, type: String, desc: 'Transaction type', documentation: { param_type: 'query' }
        optional :filter_by, type: String, desc: 'Filter', documentation: { param_type: 'query' }
      end
      get do
        transactions = current_user.user_transactions.includes(user_trade: [:trading_round]).order(id: :desc)
        transactions = transactions.where(transaction_type: params[:transaction_type].split('|')) if params[:transaction_type].present?
        filter_by = params[:filter_by] || 'date'
        if filter_by == 'date'
          transactions = transactions.group_by{|x| x.created_at.to_date.to_s}
        elsif filter_by == 'week'
          transactions = transactions.group_by{|x| x.created_at.beginning_of_week.to_date.to_s}
        elsif filter_by == 'month'
          transactions = transactions.group_by{|x| x.created_at.beginning_of_month.to_s}
        end
        result = {}
        transactions.each do |key, values|
          data = []
          values.each do |value|
            data.push({
              id: value.id, 
              transaction_type: value.transaction_type,
              trading_round_id: value.user_trade&.trading_round_id,
              sender_address: value.sender_address,
              receiver_address: value.receiver_address,
              amount: value.amount,
              trade_id: value.trade_id,
              result: value.user_trade&.trading_round&.result,
              trade_value: value.user_trade&.trade_value,
              trade_at_rate: value.user_trade&.trade_at_rate,
              trade_type: value.user_trade&.trade_type,
              tx_hash: value.tx_hash,
              status: value.status,
              created_at: value.created_at
            })
          end
          result[key] = data
        end
        status 200
        format_response(result)
      end
      desc 'This API allows user to withdraw out the platform',
           summary: 'Withdraw',
           success: { code: 200, model: Entities::V1::AuthenticationResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      params do
        requires :amount, type: Float, desc: 'The unique login email', documentation: { param_type: 'body' }
        requires :address, type: String, desc: 'The login password',documentation: { param_type: 'body' }
      end
      post :withdraw do
        ActiveRecord::Base.transaction do
          currency = Currency.find_by_symbol('USDT')
          wallet = current_user.wallets.first
          tx = UserTransaction.new(
            transaction_type: 'withdraw',
            user_id: current_user.id,
            currency_id: wallet.currency_id,
            wallet_id: current_user.wallets.first.id,
            sender_address: current_user.wallets.first.address,
            receiver_address: params[:address],
            amount: -params[:amount].to_f,
            fee: 1
          )
          
          if params[:amount].to_f <= 2.0
            master_wallet = AdminSetting.first
            transfer = Wallets::TransferErc20.call(from_wallet: master_wallet, to_wallet_address: params[:address], amount: (params[:amount] - 1) * 1e18, currency: currency)
            if transfer.success?
              tx.status = 'paid'
              tx.tx_hash = transfer.success
            else 
              tx.status = 'pending'
              tx.tx_hash = SecureRandom.hex
            end
          else
            tx.tx_hash = SecureRandom.hex
            tx.status = 'pending_admin_approval'
          end
          
          if tx.save
            status 200
            format_response(tx)
          else
            error!(failure_response(*tx.errors), 422)
          end
        end
      end
    
    end
  end
end