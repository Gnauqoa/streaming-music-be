task :transfer_winloss_to_winlossdetail do
  last_win_loss_detail_id = WinLossDetail.maximum(:id)
  next_id = last_win_loss_detail_id ? last_win_loss_detail_id + 1 : 1

  WinLoss.all.order(:id).each do |item|
    ActiveRecord::Base.transaction do
      win_loss_detail = WinLossDetail.create(item.attributes.except("id"))
      win_loss_detail.update(id: next_id)
      next_id += 1
    end
  end
end