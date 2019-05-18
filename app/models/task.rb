class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label

  enum priority: { 低: 0, 中: 1, 高: 2 }

  # タスク検索機能
  scope :search_name, -> (params) do
    name = params[:name]
    where("name LIKE?", "%#{name}%") if name.present?
  end

  scope :search_status, -> (params) do
    status = params[:status]
    where(status: status) if status.present?
  end

  scope :search_label, -> (params) do
    id = params[:label_id]
    joins(:labels).where(labels: {id: id}) if id.present?
  end

  scope :search_tasks, -> (params) { search_name(params).search_status(params).search_label(params)}

  # タスクソート機能
  class << self
    def sort_tasks(params)
      #binding.pry
      return nil if params.nil?
      if (params[:sort_expired])
        return Task.all.order(:due_date)
      elsif (params[:sort_expired_priority])
        return Task.all.order(priority: 'DESC')
      else
        return Task.all.order(created_at: 'DESC')
      end
    end
  end

  def status_key
    [['未着手', '未着手'], ['着手中', '着手中'], ['完了', '完了']]
  end
end