class PmbokWorkflow < ActiveRecord::Base
  belongs_to :pmbok_process
  belongs_to :document_template

  def doctype=(value)
    doctype = if value.nil? then nil else value[0].upcase end
    super(doctype)
  end

  validates :pmbok_process, presence: true
  validates :document_template, presence: true
  validates :doctype, length: { maximum: 1 }, inclusion: { in: (%w(I O)) << nil }
end
