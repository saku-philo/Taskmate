class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label

  enum priority: { 低: 0, 中: 1, 高: 2 }

  ## タスク検索機能
  # タスク名検索
  scope :search_name, -> (params) do
    where("name LIKE?", "%#{params}%") if params.present?
  end

  # ステータス検索
  scope :search_status, -> (params) do
    where(status: params) if params.present?
  end

  # ラベル検索
  scope :search_label, -> (params) do
    joins(:labels).where(labels: {id: params}) if params.present?
  end

  # タスク名、ステータス、ラベル検索を統合
  scope :search_tasks, -> (params) do
    if params[:search].present?
      search_name(params[:name])
      .search_status(params[:status])
      .search_label(params[:label_id])
    end
  end

  ## タスクソート機能
  class << self
    def sort_tasks(params)
      return self.order(created_at: 'DESC') if params[:sort].nil?
      if (params[:sort_expired])
        return self.order(:due_date)
      elsif (params[:sort_expired_priority])
        return self.order(priority: 'DESC')
      else
        return self.order(created_at: 'DESC')
      end
    end
  end

  def status_key
    [['未着手', '未着手'], ['着手中', '着手中'], ['完了', '完了']]
  end
end