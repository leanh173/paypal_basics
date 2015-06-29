class Registration < ActiveRecord::Base
  belongs_to :course

  validates :full_name, :company, :email, :telephone, presence: true

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
      business: "leanh@merchant.com",
      cmd: "_xclick",
      upload: 1,
      return: "#{Settings.app_host}#{return_path}",
      invoice: id,
      amount: course.price,
      item_name: course.name,
      item_number: course.id,
      quantity: '3',
      notify_url: "#{Settings.app_host}/hook"
    }
    "#{Settings.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  # test paying multi item
  # def paypal_url(return_path)
  #   values = {
  #     business: "leanh@merchant.com",
  #     cmd: "_cart",
  #     upload: 1,
  #     return: "#{Settings.app_host}#{return_path}",
  #     invoice: id,
  #     amount_1: 100,
  #     item_name_1: "item no 01",
  #     item_number_1: 1,
  #     quantity_1: "1",
  #     amount_2: 200,
  #     item_name_2: "item no 02",
  #     item_number_2: 2,
  #     quantity_2: "2",
  #     notify_url: "#{Settings.app_host}/hook"
  #   }
  #   "#{Settings.paypal_host}/cgi-bin/webscr?" + values.to_query
  # end
end
