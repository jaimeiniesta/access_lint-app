class Result
  include ActiveModel::Model

  attr_accessor :code, :status, :elements, :element_names

  def title
    I18n.t(:title, scope: [:rules, code])
  end

  def passing?
    status == "PASS"
  end

  def failing?
    status == "FAIL"
  end

  def not_applicable?
    status == "NA"
  end
end
