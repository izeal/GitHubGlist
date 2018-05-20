class DeletedUser
  include ApplicationHelper

  def name
    "Deleted"
  end

  def avatar?
    # asset_path('deleted.jpg')
  end

  def null_object?
    true
  end
end
