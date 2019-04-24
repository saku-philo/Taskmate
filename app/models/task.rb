class Task < ApplicationRecord
  validates :name, presence: true

  class << self
    def get_from_params(params)
      return nil if params.nil?
      if (params[:sort_expired])
        return Task.all.order(:due_date)
      else
        return Task.all.order(created_at: 'DESC')
      end
    end
  end
end
