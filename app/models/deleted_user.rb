class DeletedUser
  include ApplicationHelper

  def name
    "Deleted"
  end

  def avatar?
  end

  def null_object?
    true
  end
end
