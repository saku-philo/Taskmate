class Task < ApplicationRecord
  validates :name, presence: true

  class << self
    def get_from_params(params)
      return nil if params.nil?
      if (params[:sort_expired])
        return Task.all.order(:due_date)
      elsif (params[:task] && params[:task][:search])
        return Task.where("name LIKE?", "%#{params[:task][:name]}%").where("status LIKE?", "%#{params[:task][:status]}%")
      else
        return Task.all.order(created_at: 'DESC')
      end
    end
  end

  def status_key
    [['', ''], ['未着手', '未着手'], ['着手中', '着手中'], ['完了', '完了']]
  end
end
